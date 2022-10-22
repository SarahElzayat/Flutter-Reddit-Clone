/// this widget contains Action Buttons of the post (like, comment, share )
/// @author Haitham Mohamed
/// @date 14/10/2022

import 'package:flutter/material.dart';

class PostActionButtons extends StatelessWidget {
  const PostActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        MaterialButton(
          onPressed: () {},
          child: Row(
            children: const [Icon(Icons.thumb_up_alt_outlined), Text('Like')],
          ),
        ),
        MaterialButton(
          onPressed: () {},
          child: Row(
            children: const [Icon(Icons.chat_bubble_outline), Text('Comment')],
          ),
        ),
        MaterialButton(
          onPressed: () {},
          child: Row(
            children: const [Icon(Icons.share_outlined), Text('Share')],
          ),
        ),
      ],
    );
  }
}
