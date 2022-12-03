/// it contains the helper functions.
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

/// A row with link that opens the url in the browser
TextButton linkRow(String link, Color textColor) {
  return TextButton(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(textColor),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      minimumSize: MaterialStateProperty.all(const Size(20, 20)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    onPressed: () async {
      await launchUrl(Uri.parse(link)).catchError((err) {});
    },
    child: Row(
      children: [
        Text(link),
        const Icon(Icons.open_in_new),
      ],
    ),
  );
}
