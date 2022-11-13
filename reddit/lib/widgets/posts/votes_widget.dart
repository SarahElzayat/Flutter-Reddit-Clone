/// The votes widget that is used in the post widget and have different sizes and shapes
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/constants.dart';
import '../../data/post_model/post_model.dart';
import '../../components/helpers/color_manager.dart';

enum LowerPostBarState { upvoted, downvoted, none }

bool isUpvoted = false;
bool isDownvoted = false;

class VotesPart extends StatefulWidget {
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
  State<VotesPart> createState() => _VotesPartState();
}

class _VotesPartState extends State<VotesPart> {
  LowerPostBarState state = isUpvoted
      ? LowerPostBarState.upvoted
      : isDownvoted
          ? LowerPostBarState.downvoted
          : LowerPostBarState.none;
  @override
  Widget build(BuildContext context) {
    List<Widget> getchildren() => [
          Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: const CircleBorder(),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (state == LowerPostBarState.upvoted) {
                    state = LowerPostBarState.none;
                    //TODO
                    // widget.post.setVote(widget.post.votes! - 1);

                  } else if (state == LowerPostBarState.downvoted) {
                    state = LowerPostBarState.upvoted;
                    // widget.post.setVote(widget.post.votes! + 2);
                  } else {
                    state = LowerPostBarState.upvoted;
                    // widget.post.setVote(widget.post.votes! + 1);
                  }
                });
              },
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(0),
              splashColor: ColorManager.hoverOrange,
              color: ColorManager.hoverOrange,
              icon: Icon(
                Icons.arrow_upward,
                color: state == LowerPostBarState.upvoted
                    ? ColorManager.hoverOrange
                    : widget.iconColor,
              ),
              iconSize: 7.w,
            ),
          ),
          Text(
            widget.post.votes!.toString(),
            style: TextStyle(
              color: state == LowerPostBarState.none
                  ? widget.iconColor
                  : state == LowerPostBarState.upvoted
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
              onPressed: () {
                setState(() {
                  if (state == LowerPostBarState.downvoted) {
                    state = LowerPostBarState.none;
                    // widget.post.setVote(widget.post.votes! + 1);
                    vote(1);
                  } else if (state == LowerPostBarState.upvoted) {
                    state = LowerPostBarState.downvoted;
                    // widget.post.setVote(widget.post.votes! - 2);
                  } else {
                    state = LowerPostBarState.downvoted;
                    // widget.post.setVote(widget.post.votes! - 1);
                    vote(-1);
                  }
                });
              },
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(0),
              splashColor: ColorManager.downvoteBlue,
              icon: Icon(
                Icons.arrow_downward,
                color: state == LowerPostBarState.downvoted
                    ? ColorManager.downvoteBlue
                    : widget.iconColor,
              ),
              iconSize: 7.w,
            ),
          ),
        ];

    return !widget.isWeb
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getchildren(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getchildren(),
          );
  }

  void vote(int direction) {
    DioHelper.postData(path: '${base}/vote', data: {
      'id': widget.post.id,
      'direction': direction,
      'type': 'post',
    }).then((value) => print(value.data));
  }
}
