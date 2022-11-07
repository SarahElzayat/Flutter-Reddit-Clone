import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../Components/helpers/color_manager.dart';
import 'post_model/post_model.dart';

class PostUpperBar extends StatelessWidget {
  const PostUpperBar({
    Key? key,
    required this.post,
    this.showSubReddit = true,
  }) : super(key: key);

  final PostModel post;
  final bool showSubReddit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                            'r/${post.data!.subreddit ?? ''}',
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

          if (post.data!.nsfw ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: const [
                  Icon(Icons.eighteen_up_rating, color: ColorManager.red),
                  SizedBox(
                    width: 5,
                  ),
                  Text('NSFW',
                      style: TextStyle(
                        color: ColorManager.red,
                        fontSize: 15,
                      )),
                ],
              ),
            ),

          // The title of the post
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              post.data!.title ?? '',
              style: const TextStyle(
                color: ColorManager.eggshellWhite,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (post.data!.flair != null)
            SizedBox(
              height: 40,
              child: Chip(
                label: Text(
                  post.data!.flair!.flairText ?? '',
                  style: TextStyle(
                      color:
                          HexColor(post.data!.flair!.textColor ?? '#FFFFFF')),
                ),
                backgroundColor:
                    HexColor(post.data!.flair!.backgroundColor ?? '#FF00000'),
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
          'u/${post.data!.postedBy} • ',
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
        Text(
          timeago.format(DateTime.parse(post.data!.publishTime!),
              locale: 'en_short'),
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
