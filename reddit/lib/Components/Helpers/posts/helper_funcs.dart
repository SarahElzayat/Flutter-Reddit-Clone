/// it contains the helper functions.
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import '../../../data/post_model/post_model.dart';
import '../../../screens/posts/post_screen.dart';

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
