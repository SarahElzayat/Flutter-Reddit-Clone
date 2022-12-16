import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:reddit/cubit/comment_notifier/comment_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/screens/posts/post_screen.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/helpers/color_manager.dart';
import '../../components/helpers/universal_ui/universal_ui.dart';
import '../../data/comment/comment_model.dart';
import '../../data/comment/sended_comment_model.dart';
import '../../widgets/posts/actions_cubit/post_comment_actions_cubit.dart';

class AddCommentWeb extends StatelessWidget {
  const AddCommentWeb({
    Key? key,
    required QuillController? controller,
    required this.toolbar,
    required this.post,
    this.parentComment,
  })  : _controller = controller,
        super(key: key);
  final PostModel post;
  final CommentModel? parentComment;
  final QuillController? _controller;
  final QuillToolbar toolbar;

  bool get parentPost => parentComment == null;

  @override
  Widget build(BuildContext context) {
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
        height: 200,
        width: 50.w,
        child: Column(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.text,
                child: QuillEditor(
                  controller: _controller!,
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
                  SizedBox(width: 50.w - 120, child: toolbar),
                  // button to submit comment
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        backgroundColor: ColorManager.blue,
                      ),
                      onPressed: () {
                        final content =
                            _controller!.document.toDelta().toJson();
                        SendedCommentModel c = SendedCommentModel(
                          content: {'ops': content},
                          postId: post.id!,
                          parentType: parentPost ? 'post' : 'comment',
                          haveSubreddit: post.subreddit != null,
                          level: parentPost ? 1 : (parentComment!.level! + 1),
                          parentId: parentPost ? post.id : parentComment!.id,
                          subredditName: post.subreddit,
                        );

                        PostAndCommentActionsCubit.postComment(
                            c: c,
                            onSuccess: () {
                              CommentNotifierCubit.get(context)
                                  .notifyComments();
                              PostScreenCubit.get(context).getCommentsOfPost();
                              _controller!.document = Document();
                            },
                            onError: (DioError error) {
                              Map<String, dynamic> errorData =
                                  error.response!.data;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: ColorManager.hoverOrange,
                                  content: Text(errorData['error'] ?? 'Error'),
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
  }
}
