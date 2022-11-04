import 'package:flutter/material.dart';
import 'post_data.dart';
import 'post_screen.dart';

void goToPost(BuildContext context, Post post) {
  // Navigator.of(context).pushNamed(Postscreen.routeName, arguments: post);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PostScreen(
        post: post,
      ),
    ),
  );
}
