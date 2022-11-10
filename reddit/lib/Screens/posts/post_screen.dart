/// The Main Post Screen with the Comments
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import '../../Data/post_model/post_model.dart';

/// The Screen that displays the indvidual Posts
///
/// it will contain the [PostWidget] and the [Comments]
class PostScreen extends StatefulWidget {
  static const String routeName = 'post_screen';
  const PostScreen({super.key, required this.post});

  /// The post to be displayed
  final PostModel post;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostWidget(
              post: widget.post,
              outsideScreen: false,
            ),
          ],
        ),
      ),
    );
  }
}
