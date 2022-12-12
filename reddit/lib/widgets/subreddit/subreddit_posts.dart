import 'package:flutter/material.dart';

class SubredditPostsWidget extends StatelessWidget {
  const SubredditPostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        {
          return Container(
            color: Color.fromARGB(
                255, 10 * (index + 1), 15 * (index + 1), 12 * (index + 1)),
            height: 70,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text('Post $index'),
          );
        }
      },
    );
  }
}
