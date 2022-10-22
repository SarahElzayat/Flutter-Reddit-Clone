/// this is the Home Page  for the application
/// @author Haitham Mohamed
/// @date 14/10/2022

/// same issue here always use the relative paths
// import 'package:assignment/data/constantData/posts.dart';
// import 'package:assignment/view/widgets/post_widget.dart';

import '../../data/constantData/posts.dart';
import '../../view/widgets/post_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: const Drawer(),
      body: PostWidget(
        posts: constPosts,
      ),
    );
  }
}
