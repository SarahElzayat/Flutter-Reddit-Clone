import 'package:flutter/material.dart';
import 'package:reddit/posts/tmp_data.dart';
import '../posts/post_widget.dart';
import 'inline_image_viewer.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PostWidget(post: textPost),
                PostWidget(post: oneImagePost),
                PostWidget(post: manyImagePost),
              ],
            ),
          ),
        ));
  }
}
