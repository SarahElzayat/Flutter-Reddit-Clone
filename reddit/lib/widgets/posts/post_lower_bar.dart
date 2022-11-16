/// The Lower Bar of the Post that contains the Comments and the Share Button and any other necessary buttons
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reddit/data/post_model/post_model.dart';
import '../../Components/helpers/color_manager.dart';
import '../../components/helpers/posts/helper_funcs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostLowerBarWithoutVotes extends StatefulWidget {
  const PostLowerBarWithoutVotes(
      {Key? key,
      required this.post,
      this.backgroundColor = Colors.transparent,
      this.iconColor = ColorManager.greyColor,
      this.pad = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      this.isWeb = false,
      this.isMod = false})
      : super(key: key);

  /// The post to be displayed
  final PostModel post;

  /// The background color of the bar
  final Color backgroundColor;

  /// The default color of the icons
  final Color iconColor;

  /// the padding of the bar
  final EdgeInsets pad;

  /// if the user is a mod of the subreddit
  ///
  /// defaults to false
  final bool isMod;

  /// if the app is running on web
  final bool isWeb;

  @override
  State<PostLowerBarWithoutVotes> createState() =>
      _PostLowerBarWithoutVotesState();
}

class _PostLowerBarWithoutVotesState extends State<PostLowerBarWithoutVotes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Padding(
        padding: widget.pad,
        child: Row(
          mainAxisAlignment: widget.isWeb
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                //
                // goToPost(context, widget.post);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.comment_outlined,
                    color: widget.iconColor,
                    size: min(5.5.w, 30),
                  ),
                  Text(
                    ' ${widget.post.comments ?? 0}'
                    '${widget.isWeb ? ' Comments' : ''}',
                    style: TextStyle(
                      color: widget.iconColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: !widget.isMod
                    ? [
                        Icon(
                          Icons.share,
                          color: widget.iconColor,
                          size: min(5.5.w, 30),
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                            color: widget.iconColor,
                            fontSize: 15,
                          ),
                        ),
                      ]
                    : [
                        Icon(
                          Icons.shield_outlined,
                          color: widget.iconColor,
                        ),
                        Text(
                          'Mod',
                          style: TextStyle(
                            color: widget.iconColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
