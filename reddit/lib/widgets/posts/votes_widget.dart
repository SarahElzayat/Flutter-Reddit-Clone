/// The votes widget that is used in the post widget and have different sizes and shapes
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../data/post_model/post_model.dart';
import '../../components/helpers/color_manager.dart';
import 'cubit/post_cubit.dart';
import 'cubit/post_state.dart';

class VotesPart extends StatelessWidget {
  const VotesPart({
    super.key,
    required this.post,
    this.isWeb = false,
    this.iconColor = ColorManager.greyColor,
  });

  /// The post to be displayed
  final PostModel post;

  /// The default color of the icons
  final Color iconColor;

  /// if the app is running on web
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    List<Widget> getchildren() {
      var cubit = PostCubit.get(context);
      int dir = cubit.getVotingType();
      return [
        Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: IconButton(
            key: const Key('upvoteButton'),
            onPressed: () async {
              PostCubit.get(context)
                  .vote(
                direction: 1,
              )
                  .then((value) {
                PostNotifierCubit.get(context).changedPost();
              });
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            splashColor: ColorManager.hoverOrange,
            color: ColorManager.hoverOrange,
            icon: Icon(
              Icons.arrow_upward,
              color: dir == 1 ? ColorManager.hoverOrange : iconColor,
            ),
            iconSize: min(5.5.w, 30),
          ),
        ),
        Text(
          cubit.getVotesCount().toString(),
          style: TextStyle(
            color: dir == 0
                ? iconColor
                : dir == 1
                    ? ColorManager.hoverOrange
                    : ColorManager.downvoteBlue,
            fontSize: 15,
          ),
        ),
        Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: IconButton(
            key: const Key('downvoteButton'),
            onPressed: () {
              cubit.vote(direction: -1).then((value) {
                PostNotifierCubit.get(context).changedPost();
              });
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            splashColor: ColorManager.downvoteBlue,
            icon: Icon(
              Icons.arrow_downward,
              color: dir == -1 ? ColorManager.downvoteBlue : iconColor,
            ),
            iconSize: min(5.5.w, 30),
          ),
        ),
      ];
    }

    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return BlocBuilder<PostNotifierCubit, PostNotifierState>(
            builder: (context, state) {
          return !isWeb
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getchildren(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: getchildren(),
                );
        });
      },
    );
  }
}
