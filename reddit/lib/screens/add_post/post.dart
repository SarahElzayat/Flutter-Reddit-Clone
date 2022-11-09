/// Model Simple Post Screen
/// @author Haitham Mohamed
/// @date 11/11/2022

import 'package:flutter/material.dart';
import '../../variable/constants.dart';
import '../../variable/global_varible.dart';

/// Simple Post Screen That Show only Details of the post
class PostSimpleScreen extends StatelessWidget {
  /// Post Title
  final String title;

  /// Optional Text
  final String textBody;

  /// Number of Images
  final int numImages;

  /// if Post has Video or Not
  final bool hasVideos;

  /// Link in the post
  final String link;

  /// Number of Opitions in poll
  final int numPoll;

  const PostSimpleScreen({
    Key? key,
    required this.title,
    required this.textBody,
    required this.numImages,
    required this.hasVideos,
    required this.link,
    required this.numPoll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          (GlobalVarible.postType.value == -1)
              ? const Text('Post Type : None')
              : Text('Post Type : ${labels[GlobalVarible.postType.value]}'),
          Text('Title : $title'),
          Text('Text Body : $textBody'),
          Text('Number of Image : $numImages'),
          Text('Has Link : $link'),
          Text('Number of Poll options : $numPoll'),
        ]),
      ),
    );
  }
}
