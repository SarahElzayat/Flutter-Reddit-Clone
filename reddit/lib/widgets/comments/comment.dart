import 'package:flutter/material.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
import 'package:reddit/functions/post_functions.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    this.stop = false,
  });
  final bool stop;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            singleRow(
              post: textPost,
              showDots: false,
            ),
          ],
        ),
      ],
    );
  }
}
