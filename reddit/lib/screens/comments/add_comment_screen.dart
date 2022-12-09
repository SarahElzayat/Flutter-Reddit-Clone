import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../data/comment/comment_model.dart';
import '../../data/post_model/post_model.dart';

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
  quill.QuillController? _controller;

  @override
  void initState() {
    _controller = quill.QuillController.basic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add comment'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Post',
              style: TextStyle(color: ColorManager.blue),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          quill.QuillEditor(
            controller: quill.QuillController(
              document: quill.Document.fromJson(
                  jsonDecode(widget.post.content ?? '[]')),
              selection: const TextSelection(baseOffset: 0, extentOffset: 0),
            ),
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
            child: quill.QuillEditor(
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
        ],
      ),
    );
  }
}
