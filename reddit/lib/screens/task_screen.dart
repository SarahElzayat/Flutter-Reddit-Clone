/// The main Post screen that displays a list of posts
/// @auther Ahmed Atta
/// @created at 2022 14/10

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:reddit/widgets/post.dart';

/// The Screen that displays a list of posts
class PostList extends StatelessWidget {
  const PostList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recently Visited',
                        style: Theme.of(context).textTheme.titleSmall),
                    Text('See All',
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                ListTile(
                  title: const Text('r/Egypt'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('r/Flutter'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.notification_important_rounded),
            onPressed: () {},
          ),
        ],
        title: const Text('Posts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: 10,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Post(
              photo:
                  'https://avatars.githubusercontent.com/u/114713937?s=200&v=4',
              name: 'Reddit',
              message: lorem(paragraphs: 2, words: 60)),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.black,
            );
          },
        ),
      ),
    );
  }
}
