import 'package:flutter/material.dart';
import 'package:reddit/posts/post_data.dart';
import '../posts/post_widget.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemBuilder: (context, index) {
      return PostWidget(
        post: Post(
          title: 'COME ON GUYS, KIDS ARE WATIN, MAKE ME MY Pizza $index',
          body: lorem(paragraphs: 1, words: 50),
          id: '$index',
          userId: '557545467',
          subredditId: 'r/Flutter',
        ),
      );
    }));
  }
}
