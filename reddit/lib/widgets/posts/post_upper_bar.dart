/// The upper bar of the post that contains the avatar, title and the subreddit and so on
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/widgets/posts/dropdown_list.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../cubit/post_notifier/post_notifier_state.dart';
import '../../data/post_model/post_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../functions/post_functions.dart';

bool isjoined = true;

enum ShowingOtions { onlyUser, onlySubreddit, both }

class PostUpperBar extends StatefulWidget {
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
  State<PostUpperBar> createState() => _PostUpperBarState();
}

class _PostUpperBarState extends State<PostUpperBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConditionalSwitch.single<ShowingOtions>(
          context: context,
          valueBuilder: (BuildContext context) {
            return widget.showRowsSelect;
          },
          caseBuilders: {
            ShowingOtions.onlyUser: (ctx) {
              return singleRow(
                  context: context,
                  sub: false,
                  showIcon: true,
                  post: widget.post,
                  isWeb: widget.isWeb);
            },
            ShowingOtions.onlySubreddit: (_) {
              return singleRow(
                  context: context,
                  sub: true,
                  showIcon: true,
                  post: widget.post,
                  isWeb: widget.isWeb);
            },
            ShowingOtions.both: (_) {
              return _bothRows();
            },
          },
          fallbackBuilder: (BuildContext context) {
            return _bothRows();
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
  }

  SizedBox _bothRows() {
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
              InkWell(
                onTap: () {
                  SubredditCubit.get(context)
                      .setSubredditName(context, widget.post.subreddit ?? '');
                },
                child: Text(
                  'r/${widget.post.subreddit ?? ''}',
                  style: const TextStyle(
                    color: ColorManager.eggshellWhite,
                    fontSize: 15,
                  ),
                ),
              ),
              singleRow(
                  context: context,
                  sub: false,
                  showDots: false,
                  post: widget.post,
                  isWeb: widget.isWeb),
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
          else if (widget.outSide && !widget.isWeb)
            dropDownDots(widget.post),
        ],
      ),
    );
  }

  BlocBuilder<PostNotifierCubit, PostNotifierState> dropDownDots(
      PostModel post) {
    return BlocBuilder<PostNotifierCubit, PostNotifierState>(
      builder: (context, state) {
        return DropDownList(
          post: widget.post,
          itemClass: ItemsClass.posts,
          outsideScreen: widget.outSide,
        );
      },
    );
  }

  Row _tagsRow() {
    return Row(
      children: [
        if (widget.post.nsfw ?? false)
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
        if (widget.post.nsfw ?? false) const SizedBox(width: 5),
        if (widget.post.spoiler ?? false)
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
