import 'package:flutter/material.dart';
import 'package:reddit/posts/tmp_data.dart';
import '../posts/post_widget.dart';

class PostTestScreen extends StatelessWidget {
  const PostTestScreen({super.key});

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
