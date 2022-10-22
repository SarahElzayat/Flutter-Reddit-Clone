/// this is simple SubReddit Screen
/// Navigating to it when click on subreddit icon in the post
/// @author Haitham Mohamed
/// @date 14/10/2022

import 'package:flutter/material.dart';

class SubReddit extends StatelessWidget {
  const SubReddit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: const Center(child: Text('Subreddit Page')),
      ),
    );
  }
}
