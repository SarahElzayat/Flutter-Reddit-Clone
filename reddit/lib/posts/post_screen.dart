import 'package:flutter/material.dart';
import 'package:reddit/posts/post_widget.dart';

import 'post_model/post_model.dart';

class PostScreen extends StatefulWidget {
  static const String routeName = 'post_screen';
  const PostScreen({super.key, required this.post});
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
