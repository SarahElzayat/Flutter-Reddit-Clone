import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:logger/logger.dart';
import '../../components/helpers/color_manager.dart';
import '../../data/comment/comment_model.dart';
import '../../data/post_model/post_model.dart';

var logger = Logger();

class MessagesScreen extends StatefulWidget {
  static const routeName = 'add-comment';
  const MessagesScreen({super.key, required this.post, this.parentComment});

  /// the post to which the comment will be added
  final PostModel post;

  /// the parent comment to which the comment will be added
  /// if null, the comment will be added to the post
  final CommentModel? parentComment;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  QuillController? _controller;
  @override
  void initState() {
    _controller = QuillController.basic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reply to Messages'),
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
          Expanded(
            child: QuillEditor(
              controller: getController(),
              readOnly: true,
              enableInteractiveSelection: true,
              autoFocus: false,
              expands: false,
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
            thickness: 1,
          ),
          QuillEditor(
            controller: _controller!,
            readOnly: false,
            autoFocus: true,
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
            ],
          ),
        ],
      ),
    );
  }

  QuillController getController() {
    Document doc;
    try {
      logger.wtf(widget.post.content ?? {'ops': []});
      doc = Document.fromJson((widget.post.content ?? {'ops': []})['ops']);
    } catch (e) {
      logger.wtf(e);
      doc = Document();
    }
    // doc = Document();

    return QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }
}
