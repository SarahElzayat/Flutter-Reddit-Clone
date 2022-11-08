///@author Ahmed Atta
///@date 9/11/2022
///
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../Components/helpers/color_manager.dart';
import '../../Data/post_model/post_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

bool isjoined = false;

class PostUpperBar extends StatefulWidget {
  const PostUpperBar({
    Key? key,
    required this.post,
    this.showSubReddit = true,
  }) : super(key: key);

  /// The post to be displayed
  final PostModel post;

  /// if the subreddit should be shown
  ///
  /// it's passed because the post don't require the subreddit to be shown in
  /// the sunreddit screen
  final bool showSubReddit;

  @override
  State<PostUpperBar> createState() => _PostUpperBarState();
}

class _PostUpperBarState extends State<PostUpperBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConditionalBuilder(
              condition: widget.showSubReddit,
              builder: (context) => SizedBox(
                    height: 15.w,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5.5.w,
                          child: const Icon(Icons.category_sharp),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'r/${widget.post.subreddit ?? ''}',
                              style: const TextStyle(
                                color: ColorManager.eggshellWhite,
                                fontSize: 15,
                              ),
                            ),
                            userRow(),
                          ],
                        ),
                        const Spacer(),
                        if (!isjoined)
                          InkWell(
                            onTap: () {
                              setState(() {
                                isjoined = true;
                              });
                            },
                            child: const Chip(
                              label: Text(
                                'Join',
                                style: TextStyle(
                                  color: ColorManager.eggshellWhite,
                                ),
                              ),
                              backgroundColor: ColorManager.blue,
                            ),
                          )
                      ],
                    ),
                  ),
              fallback: (context) => userRow()),

          if (widget.post.nsfw ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: const [
                  Icon(Icons.eighteen_up_rating, color: ColorManager.red),
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
              widget.post.title ?? '',
              style: const TextStyle(
                color: ColorManager.eggshellWhite,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (widget.post.flair != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: HexColor(
                      widget.post.flair!.backgroundColor ?? '#FF00000'),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  widget.post.flair!.flairText ?? '',
                  style: TextStyle(
                      color:
                          HexColor(widget.post.flair!.textColor ?? '#FFFFFF')),
                ),
              ),
            )
        ],
      ),
    );
  }

  Row userRow() {
    return Row(
      children: [
        Text(
          'u/${widget.post.postedBy} • ',
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
        Text(
          timeago.format(DateTime.parse(widget.post.publishTime!),
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
