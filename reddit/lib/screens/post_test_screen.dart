///@author Ahmed Atta
///@date 9/11/2022
///
import 'package:flutter/material.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

class PostTestScreen extends StatelessWidget {
  static const routeName = '/post_test_screen_route';
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
