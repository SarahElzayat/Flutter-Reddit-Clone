/// where are the author, date and description comments ya hanem ??

import 'package:flutter/material.dart';

///  always remove unsed packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:reddit/post.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});

  List posts = [
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'
  ];

  List titles = ['Lorem Ipsum'];

  List names = ['John Doe'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) =>
            PostBuilder(name: names[0], title: titles[0], post: posts[0]),
      ),
    );
  }
}
