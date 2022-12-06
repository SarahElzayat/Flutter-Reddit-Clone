import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:reddit/functions/post_functions.dart';

import '../../data/post_model/post_model.dart';

class Comment extends StatefulWidget {
  const Comment({
    super.key,
    required this.post,
    this.stop = false,
    this.level = 0,
  });
  final PostModel post;

  final bool stop;

  final int level;

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool isCompressed = false;
  final QuillController _controller = QuillController(
    document: Document.fromDelta(
      Delta()..insert('White\n', {'color': '#cccccc'}),
    ),
    selection: const TextSelection.collapsed(offset: 0),
  );
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: isCompressed,
      builder: (context) {
        return Row(
          children: [
            singleRow(post: widget.post, showIcon: true),
          ],
        );
      },
      fallback: (context) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: singleRow(
                    post: widget.post,
                    showDots: false,
                    showIcon: true,
                  ),
                ),
              ],
            ),
            QuillEditor(
              controller: _controller,
              readOnly: true,
              autoFocus: false,
              expands: false,
              scrollable: false,
              scrollController: ScrollController(),
              focusNode: FocusNode(),
              padding: EdgeInsets.zero,
            ),
          ],
        );
      },
    );
  }
}
