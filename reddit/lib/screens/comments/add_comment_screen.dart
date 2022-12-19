import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/helpers/color_manager.dart';
import '../../data/comment/comment_model.dart';
import '../../data/comment/sended_comment_model.dart';
import '../../data/post_model/post_model.dart';

var logger = Logger();

class AddCommentScreen extends StatefulWidget {
  static const routeName = 'add-comment';
  const AddCommentScreen({super.key, required this.post, this.parentComment});

  /// the post to which the comment will be added
  final PostModel post;

  /// the parent comment to which the comment will be added
  /// if null, the comment will be added to the post
  final CommentModel? parentComment;

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  QuillController? _controller;
  @override
  void initState() {
    _controller = QuillController.basic();
    super.initState();
  }

  bool _isPostParent() => widget.parentComment == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isPostParent() ? 'Add comment' : 'Reply'),
        actions: [
          TextButton(
            onPressed: () {
              // check if the comment is empty
              if (_controller!.document.length == 1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: ColorManager.yellow,
                    content: Text('Comment cannot be empty'),
                  ),
                );
                return;
              }
              final content = _controller!.document.toDelta().toJson();
              logger.i(content);
              SendedCommentModel c = SendedCommentModel(
                content: {'ops': content},
                postId: widget.post.id!,
                parentType: _isPostParent() ? 'post' : 'comment',
                haveSubreddit: widget.post.subreddit != null,
                level: _isPostParent() ? 1 : (widget.parentComment!.level! + 1),
                parentId:
                    _isPostParent() ? widget.post.id : widget.parentComment!.id,
                subredditName: widget.post.subreddit,
              );

              PostAndCommentActionsCubit.postComment(
                c: c,
                onSuccess: () {
                  PostNotifierCubit.get(context).notifyPosts();
                  Navigator.of(context).pop(true);
                },
                onError: (DioError error) {
                  logger.wtf(error);
                  Map<String, dynamic> errorData = error.response!.data;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorManager.hoverOrange,
                      content: Text(errorData['error'] ?? 'Error'),
                    ),
                  );
                },
              );
            },
            child: const Text(
              'Post',
              style: TextStyle(color: ColorManager.blue),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          QuillEditor(
            controller: getController(),
            readOnly: true,
            enableInteractiveSelection: false,
            autoFocus: false,
            expands: false,
            scrollable: false,
            scrollController: ScrollController(),
            focusNode: FocusNode(),
            padding: EdgeInsets.zero,
            embedBuilders: [
              ...FlutterQuillEmbeds.builders(),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          Expanded(
            child: QuillEditor(
              controller: _controller!,
              readOnly: false,
              autoFocus: true,
              expands: true,
              scrollable: true,
              scrollController: ScrollController(),
              focusNode: FocusNode(),
              padding: EdgeInsets.zero,
              embedBuilders: [
                ...FlutterQuillEmbeds.builders(),
              ],
            ),
          ),
          const Divider(
            height: 10,
            thickness: 2,
          ),
          Row(
            children: [
              LinkStyleButton(
                controller: _controller!,
                dialogTheme: QuillDialogTheme(
                  dialogBackgroundColor: ColorManager.darkBlack,
                  labelTextStyle: const TextStyle(color: ColorManager.blue),
                ),
                iconTheme: const QuillIconTheme(
                    iconUnselectedFillColor: Colors.transparent,
                    iconUnselectedColor: ColorManager.greyColor),
              ),
              const Spacer(),
              ImageButton(
                icon: Icons.image,
                controller: _controller!,
                onImagePickCallback: _onImagePickCallback,
                // change it for web
                webImagePickImpl: _webImagePickImpl,
                fillColor: Colors.transparent,
                iconTheme: const QuillIconTheme(
                    iconUnselectedColor: ColorManager.blue),
              ),
              IconButton(
                  onPressed: () async {
                    GiphyGif? gif = await GiphyGet.getGif(
                      context: context, //Required
                      apiKey: 'Cy67mi7cCOLy9reX6CtubyaAxFbNCflL', //Required.
                      lang: GiphyLanguage
                          .english, //Optional - Language for query.
                      tabColor: Colors.teal, // Optional- default accent color.
                    );
                    if (gif != null) {
                      _linkSubmitted(gif.images?.original?.url);
                    }
                  },
                  icon: const Icon(
                    Icons.gif_box_outlined,
                    color: ColorManager.blue,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  QuillController getController() {
    Document doc;
    // try {
    //   logger.wtf(widget.post.content ?? {'ops': []});
    //   doc = Document.fromJson((widget.post.content ?? {'ops': []})['ops']);
    // } catch (e) {
    //   logger.wtf(e);
    //   doc = Document();
    // }
    doc = Document();

    return QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void _linkSubmitted(String? value) {
    if (value != null && value.isNotEmpty && _controller != null) {
      final index = _controller!.selection.baseOffset;
      final length = _controller!.selection.extentOffset - index;
      _controller!.replaceText(index, length, BlockEmbed.image(value), null);

      // _controller!.document
      //     .insert(_controller!.selection.start, BlockEmbed.image(value));
      _controller!.document.format(
          _controller!.selection.start,
          1,
          StyleAttribute(
              'mobileWidth: ${30.w}; mobileHeight: ${30.h}; mobileMargin: 10; mobileAlignment: topLeft'));
      _controller!.document.insert(_controller!.selection.start, '\n');
      // insert new line

    }
  }

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    // insert new line
    _controller!.document.format(
        _controller!.selection.start,
        1,
        StyleAttribute(
            'mobileWidth: ${30.w}; mobileHeight: ${30.h}; mobileMargin: 10; mobileAlignment: topLeft'));
    _controller!.document.insert(_controller!.selection.start, '\n');
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${p.basename(file.path)}');
    return copiedFile.path.toString();
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
  }
}
