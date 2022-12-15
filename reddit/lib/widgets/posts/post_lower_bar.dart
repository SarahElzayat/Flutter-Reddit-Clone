/// The Lower Bar of the Post that contains the Comments and the Share Button and any other necessary buttons
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';

import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../functions/post_functions.dart';
import '../../screens/posts/insights_screen.dart';
import 'actions_cubit/post_comment_actions_state.dart';

class PostLowerBarWithoutVotes extends StatefulWidget {
  const PostLowerBarWithoutVotes({
    Key? key,
    required this.post,
    this.backgroundColor = Colors.transparent,
    this.iconColor = ColorManager.greyColor,
    this.pad = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
    this.isWeb = false,
  }) : super(key: key);

  /// The post to be displayed
  final PostModel post;

  /// The background color of the bar
  final Color backgroundColor;

  /// The default color of the icons
  final Color iconColor;

  /// the padding of the bar
  final EdgeInsets pad;

  /// if the app is running on web
  final bool isWeb;

  @override
  State<PostLowerBarWithoutVotes> createState() =>
      _PostLowerBarWithoutVotesState();
}

class _PostLowerBarWithoutVotesState extends State<PostLowerBarWithoutVotes> {
  @override
  Widget build(BuildContext context) {
    // var isMod = widget.post.inYourSubreddit ?? false;
    var isMod = true;
    return Container(
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: widget.isWeb
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            key: const Key('comment-button'),
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
            onTap: () {
              if (isMod &&
                  !(PostAndCommentActionsCubit.get(context).showModTools)) {
                showModOperations(
                  context: context,
                  post: widget.post,
                );
              } else {
                // TODO
                // sharePost(context, widget.post);
              }
            },
            child: BlocBuilder<PostAndCommentActionsCubit, PostState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: (isMod &&
                          !(PostAndCommentActionsCubit.get(context)
                              .showModTools))
                      ? [
                          Icon(
                            key: const Key('mod-icon'),
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
                        ]
                      : [
                          Icon(
                            key: const Key('share-icon'),
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
                        ],
                );
              },
            ),
          ),
          Material(
            key: const Key('insights-button'),
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: const CircleBorder(),
            child: IconButton(
              onPressed: () {
                PostAndCommentActionsCubit.get(context)
                    .getInsights()
                    .then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InsightsScreen(
                      iM: value,
                    );
                  }));
                }).catchError((e) {
                  return null;
                });
              },
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(0),
              splashColor: ColorManager.downvoteBlue,
              icon: const Icon(
                Icons.insights,
                color: ColorManager.blue,
              ),
              iconSize: min(5.5.w, 30),
            ),
          ),
        ],
      ),
    );
  }
}
