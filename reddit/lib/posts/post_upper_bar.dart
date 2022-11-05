import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../Components/helpers/color_manager.dart';
import 'post_data.dart';

class PostUpperBar extends StatelessWidget {
  const PostUpperBar({
    Key? key,
    required this.post,
    this.showSubReddit = true,
  }) : super(key: key);

  final Post post;
  final bool showSubReddit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConditionalBuilder(
              condition: showSubReddit,
              builder: (context) => Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.category_sharp),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.subredditId,
                            style: const TextStyle(
                              color: ColorManager.eggshellWhite,
                              fontSize: 15,
                            ),
                          ),
                          userRow(),
                        ],
                      ),
                      const Spacer(),
                      const Chip(
                        label: Text('Join'),
                        backgroundColor: ColorManager.blue,
                      ),
                    ],
                  ),
              fallback: (context) => userRow()),

          // The title of the post
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              post.title,
              style: const TextStyle(
                color: ColorManager.eggshellWhite,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row userRow() {
    return Row(
      children: [
        Text(
          'u/${post.userId}',
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
        const Text(
          ' • ',
          style: TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
        const Text(
          '14h',
          style: TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
