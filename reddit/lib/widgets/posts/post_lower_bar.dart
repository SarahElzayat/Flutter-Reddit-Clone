/// The Lower Bar of the Post that contains the Comments and the Share Button and any other necessary buttons
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_state.dart';

import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/dropdown_list.dart';
import 'package:reddit/widgets/posts/menu_items.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../cubit/post_notifier/post_notifier_cubit.dart';
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
    this.showIsights = false,
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

  final bool showIsights;
  @override
  State<PostLowerBarWithoutVotes> createState() =>
      _PostLowerBarWithoutVotesState();
}

class _PostLowerBarWithoutVotesState extends State<PostLowerBarWithoutVotes> {
  @override
  Widget build(BuildContext context) {
    // var isMod = widget.post.inYourSubreddit ?? false;
    var isMod = true;
    return BlocBuilder<PostAndCommentActionsCubit, PostActionsState>(
      builder: (context, state) {
        var cubit = PostAndCommentActionsCubit.get(context);
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
                      size: min(5.w, 20),
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
                width: 2.w,
              ),
              InkWell(
                onTap: () {
                  if (!widget.isWeb &&
                      isMod &&
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
                child:
                    BlocBuilder<PostAndCommentActionsCubit, PostActionsState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: (!widget.isWeb &&
                              isMod &&
                              !(PostAndCommentActionsCubit.get(context)
                                  .showModTools))
                          ? [
                              Icon(
                                key: const Key('mod-icon'),
                                Icons.shield_outlined,
                                color: widget.iconColor,
                              ),
                              !_showInsights
                                  ? Text(
                                      'Mod',
                                      style: TextStyle(
                                        color: widget.iconColor,
                                        fontSize: 15,
                                      ),
                                    )
                                  : Container(),
                            ]
                          : [
                              MenuItems.buildDropMenuItem(MenuItems.share,
                                  iconColor: widget.iconColor)
                            ],
                    );
                  },
                ),
              ),
              if (widget.isWeb)
                SizedBox(
                  width: 2.w,
                ),
              if (_showInsights && !widget.isWeb)
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
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
              if (widget.isWeb)
                InkWell(
                  onTap: () {
                    cubit.save().then((value) {
                      PostNotifierCubit.get(context).notifyPosts();
                    });
                  },
                  child: MenuItems.buildDropMenuItem(
                      (widget.post.saved ?? false)
                          ? MenuItems.unsave
                          : MenuItems.save,
                      iconColor: widget.iconColor),
                ),
              if (widget.isWeb)
                SizedBox(
                  width: 2.w,
                ),
              if (widget.isWeb)
                BlocBuilder<PostNotifierCubit, PostNotifierState>(
                  builder: (context, state) {
                    return DropDownList(
                      post: widget.post,
                      itemClass: ItemsClass.posts,
                      isWeb: widget.isWeb,
                    );
                  },
                )
            ],
          ),
        );
      },
    );
  }

  bool get _showInsights => widget.showIsights;
}
