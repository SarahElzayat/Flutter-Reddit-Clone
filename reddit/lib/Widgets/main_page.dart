/// this is the Main Screen for the application
/// @author Abdelaziz Salah
/// @date 14/10/2022

import 'package:flutter/material.dart';
import '../Widgets/post.dart';
import '../Data/posts.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reddit Posts Simulator",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: const Drawer(),
      body: ListView.builder(
        itemCount: postsExamples.length,
        itemBuilder: (ctx, index) {
          return Post(
              imgPath: postsExamples[index]["ImagePath"],
              userName: postsExamples[index]["UserName"],
              thePostContent: postsExamples[index]["Content"]);
        },
      ),
    );
  }
}
