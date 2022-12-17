import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reddit/cubit/comment_notifier/comment_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/screens/posts/post_screen.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_cubit.dart';
import 'package:path/path.dart' as p;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/helpers/color_manager.dart';
import '../../components/helpers/universal_ui/universal_ui.dart';
import '../../data/comment/comment_model.dart';
import '../../data/comment/sended_comment_model.dart';
import '../../widgets/posts/actions_cubit/post_comment_actions_cubit.dart';

class AddCommentWeb extends StatelessWidget {
  AddCommentWeb({
    Key? key,
    required this.post,
    this.parentComment,
  }) : super(key: key);
  final PostModel post;
  final CommentModel? parentComment;
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  bool get parentPost => parentComment == null;

  @override
  Widget build(BuildContext context) {
    var toolbar = QuillToolbar.basic(
      showUndo: false,
      showRedo: false,
      showBoldButton: true,
      showItalicButton: true,
      showBackgroundColorButton: false,
      showCenterAlignment: false,
      showLeftAlignment: false,
      showRightAlignment: false,
      showJustifyAlignment: false,
      showHeaderStyle: false,
      showListNumbers: true,
      showListBullets: true,
      showCodeBlock: true,
      showStrikeThrough: true,
      showFontSize: false,
      multiRowsDisplay: false,
      showClearFormat: false,
      showIndent: false,
      showQuote: false,
      showColorButton: false,
      showSearchButton: false,
      showDirection: false,
      showDividers: false,
      showFontFamily: false,
      showInlineCode: false,
      showListCheck: false,
      showUnderLineButton: false,
      controller: _controller,
      embedButtons: FlutterQuillEmbeds.buttons(
        showVideoButton: false,
        showCameraButton: false,
        onImagePickCallback: _onImagePickCallback,
        webImagePickImpl: _webImagePickImpl,
      ),
      showAlignmentButtons: true,
      afterButtonPressed: _focusNode.requestFocus,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            clipBehavior: Clip.antiAlias,
            height: min(200, constraints.maxHeight),
            width: constraints.maxWidth,
            child: Column(
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.text,
                    child: QuillEditor(
                      controller: _controller,
                      readOnly: false,
                      autoFocus: true,
                      expands: false,
                      scrollable: true,
                      scrollController: ScrollController(),
                      focusNode: FocusNode(),
                      placeholder: 'what are your thoughts?',
                      padding: const EdgeInsets.all(8),
                      embedBuilders: defaultEmbedBuildersWeb,
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 0.75 * constraints.maxWidth, child: toolbar),
                      // button to submit comment
                      SizedBox(
                        width: 0.2 * constraints.maxWidth,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            backgroundColor: ColorManager.blue,
                          ),
                          onPressed: () {
                            final content =
                                _controller.document.toDelta().toJson();
                            SendedCommentModel c = SendedCommentModel(
                              content: {'ops': content},
                              postId: post.id!,
                              parentType: parentPost ? 'post' : 'comment',
                              haveSubreddit: post.subreddit != null,
                              level:
                                  parentPost ? 1 : (parentComment!.level! + 1),
                              parentId:
                                  parentPost ? post.id : parentComment!.id,
                              subredditName: post.subreddit,
                            );

                            PostAndCommentActionsCubit.postComment(
                                c: c,
                                onSuccess: () {
                                  PostScreenCubit.get(context).post.comments =
                                      PostScreenCubit.get(context)
                                              .post
                                              .comments! +
                                          1;
                                  PostScreenCubit.get(context)
                                      .getCommentsOfPost();
                                  _controller.document = Document();
                                  PostNotifierCubit.get(context).notifyPosts();
                                  CommentNotifierCubit.get(context)
                                      .notifyComments();
                                },
                                onError: (DioError error) {
                                  Map<String, dynamic> errorData =
                                      error.response!.data;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: ColorManager.hoverOrange,
                                      content:
                                          Text(errorData['error'] ?? 'Error'),
                                    ),
                                  );
                                });
                          },
                          child: const Text('Comment'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> _webImagePickImpl(
      OnImagePickCallback onImagePickCallback) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }

    // Take first, because we don't allow picking multiple files.
    final fileName = result.files.first.name;

    final file = File(fileName);

    return onImagePickCallback(file);
  } // Renders the image picked by imagePicker from local file storage

  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    // insert new line
    _controller.document.format(
        _controller.selection.start,
        1,
        StyleAttribute(
            'mobileWidth: ${30.w}; mobileHeight: ${30.h}; mobileMargin: 10; mobileAlignment: topLeft'));
    _controller.document.insert(_controller.selection.start, '\n');
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${p.basename(file.path)}');
    return copiedFile.path.toString();
  }
}
