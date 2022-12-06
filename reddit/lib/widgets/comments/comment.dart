import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
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

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: isCompressed,
      builder: (context) {
        return Row(
          children: [
            singleRow(post: widget.post),
          ],
        );
      },
      fallback: (context) {
        return Column(
          children: [
            Row(
              children: [
                singleRow(
                  post: widget.post,
                  showDots: false,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
