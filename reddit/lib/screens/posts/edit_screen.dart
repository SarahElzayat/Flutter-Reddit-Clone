import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:logger/logger.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/helpers/color_manager.dart';
import '../../cubit/comment_notifier/comment_notifier_cubit.dart';
import '../../data/comment/comment_model.dart';
import '../../data/post_model/post_model.dart';

var logger = Logger();

class EditScreen extends StatefulWidget {
  static const routeName = 'add-comment';
  const EditScreen({super.key, required this.post, this.currentComment});

  /// the post to which the comment will be added
  final PostModel post;

  /// the parent comment to which the comment will be added
  /// if null, the comment will be added to the post
  final CommentModel? currentComment;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  QuillController? _controller;
  @override
  void initState() {
    _controller = getController();
    super.initState();
  }

  bool get _isPost => widget.currentComment == null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostAndCommentActionsCubit(
        post: widget.post,
        currentComment: widget.currentComment,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isPost ? 'Edit Post' : 'Edit Comment'),
          actions: [
            BlocBuilder<PostAndCommentActionsCubit, PostActionsState>(
              builder: (context, state) {
                var cubit = PostAndCommentActionsCubit.get(context);
                return TextButton(
                  onPressed: () {
                    try {
                      final content = _controller!.document.toDelta().toJson();
                      logger.i(content);
                      var newContent = {'ops': content};
                      cubit.editIt(newContent).then((value) {
                        if (_isPost) {
                          PostNotifierCubit.get(context).notifyPosts();
                        } else {
                          CommentNotifierCubit.get(context).notifyComments();
                        }
                        Navigator.of(context).pop();
                      });
                    } catch (e) {
                      logger.e(e);
                    }
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: ColorManager.blue),
                  ),
                );
              },
            )
          ],
        ),
        body: Column(
          children: [
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
                if (!_isPost)
                  IconButton(
                      onPressed: () async {
                        GiphyGif? gif = await GiphyGet.getGif(
                          context: context, //Required
                          apiKey:
                              'Cy67mi7cCOLy9reX6CtubyaAxFbNCflL', //Required.
                          lang: GiphyLanguage
                              .english, //Optional - Language for query.
                          tabColor:
                              Colors.teal, // Optional- default accent color.
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
      ),
    );
  }

  QuillController getController() {
    Document doc;
    var content =
        _isPost ? widget.post.content : widget.currentComment!.commentBody;
    try {
      doc = Document.fromJson((content ?? {'ops': []})['ops']);
      Logger().wtf(doc.toPlainText());
    } catch (e) {
      logger.wtf(e);
      doc = Document();
    }

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
}
