/// The upper bar of the post that contains the avatar, title and the subreddit and so on
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_state.dart';
import 'package:reddit/widgets/posts/dropdown_list.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../cubit/post_notifier/post_notifier_state.dart';
import '../../data/post_model/post_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../functions/post_functions.dart';

enum ShowingOtions { onlyUser, onlySubreddit, both }

class PostUpperBar extends StatelessWidget {
  final bool isWeb;

  const PostUpperBar(
      {Key? key,
      required this.post,
      this.showRowsSelect = ShowingOtions.both,
      this.outSide = true,
      required this.isWeb})
      : super(key: key);

  /// The post to be displayed
  final PostModel post;

  /// if the single row should be shown
  ///
  /// it's passed because the post don't require the subreddit to be shown in
  /// the sunreddit screen for example
  final ShowingOtions showRowsSelect;

  /// if the post is in the home page or in the post screen
  final bool outSide;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostAndCommentActionsCubit, PostActionsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConditionalSwitch.single<ShowingOtions>(
              context: context,
              valueBuilder: (BuildContext context) {
                return showRowsSelect;
              },
              caseBuilders: {
                ShowingOtions.onlyUser: (ctx) {
                  return singleRow(
                      sub: false, showIcon: true, post: post, isWeb: isWeb);
                },
                ShowingOtions.onlySubreddit: (_) {
                  return singleRow(
                      sub: true, showIcon: true, post: post, isWeb: isWeb);
                },
                ShowingOtions.both: (_) {
                  return _bothRows(context);
                },
              },
              fallbackBuilder: (BuildContext context) {
                return _bothRows(context);
              },
            ),

            BlocBuilder<PostNotifierCubit, PostNotifierState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: _tagsRow(),
                );
              },
            ),

            // The title of the post
          ],
        );
      },
    );
  }

  SizedBox _bothRows(context) {
    return SizedBox(
      child: Row(
        children: [
          subredditAvatar(),
          SizedBox(
            width: min(2.w, 10),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((post.subreddit ?? '').isNotEmpty)
                InkWell(
                  onTap: () {
                    SubredditCubit.get(context)
                        .setSubredditName(context, post.subreddit ?? '');
                  },
                  child: Text(
                    'r/${post.subreddit ?? ''}',
                    style: const TextStyle(
                      color: ColorManager.eggshellWhite,
                      fontSize: 15,
                    ),
                  ),
                ),
              singleRow(sub: false, showDots: false, post: post, isWeb: isWeb),
            ],
          ),
          const Spacer(),
          if (!(PostAndCommentActionsCubit.get(context).subreddit?.isMember ??
              true))
            InkWell(
              onTap: () {
                PostAndCommentActionsCubit.get(context).joinCommunity();
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
          else if (outSide && !isWeb)
            dropDownDots(post),
        ],
      ),
    );
  }

  BlocBuilder<PostNotifierCubit, PostNotifierState> dropDownDots(
      PostModel post) {
    return BlocBuilder<PostNotifierCubit, PostNotifierState>(
      builder: (context, state) {
        return DropDownList(
          post: post,
          itemClass: ItemsClass.posts,
          outsideScreen: outSide,
        );
      },
    );
  }

  Row _tagsRow() {
    return Row(
      children: [
        if (post.nsfw ?? false)
          Row(
            children: const [
              Icon(Icons.eighteen_up_rating, color: ColorManager.red, size: 20),
              Text('NSFW',
                  style: TextStyle(
                    color: ColorManager.red,
                    fontSize: 13,
                  )),
            ],
          ),
        if (post.nsfw ?? false) const SizedBox(width: 5),
        if (post.spoiler ?? false)
          Row(
            children: const [
              Icon(Icons.privacy_tip_outlined,
                  color: ColorManager.eggshellWhite, size: 20),
              Text('Spoiler',
                  style: TextStyle(
                    color: ColorManager.eggshellWhite,
                    fontSize: 13,
                  )),
            ],
          ),
      ],
    );
  }
}
