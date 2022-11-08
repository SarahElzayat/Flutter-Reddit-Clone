import 'package:flutter/material.dart';
import 'post_model/post_model.dart';
import 'post_screen.dart';

/// Goes to the post screen
void goToPost(BuildContext context, PostModel post) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PostScreen(
        post: post,
      ),
    ),
  );
}
