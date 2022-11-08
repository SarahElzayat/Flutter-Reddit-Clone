import 'package:flutter/material.dart';
import 'package:reddit/posts/post_model/post_model.dart';
import '../Components/helpers/color_manager.dart';
import 'helper_funcs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum LowerPostBarState { upvoted, downvoted, none }

bool isUpvoted = false;
bool isDownvoted = false;

class PostLowerBar extends StatefulWidget {
  const PostLowerBar(
      {Key? key,
      required this.post,
      this.backgroundColor = Colors.transparent,
      this.iconColor = ColorManager.greyColor,
      this.pad = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
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
  @override
  State<PostLowerBar> createState() => _PostLowerBarState();
}

class _PostLowerBarState extends State<PostLowerBar> {
  LowerPostBarState state = isUpvoted
      ? LowerPostBarState.upvoted
      : isDownvoted
          ? LowerPostBarState.downvoted
          : LowerPostBarState.none;
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Padding(
        padding: widget.pad,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    shape: const CircleBorder(),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (state == LowerPostBarState.upvoted) {
                            state = LowerPostBarState.none;
                            widget.post.setVote(widget.post.votes! - 1);
                          } else if (state == LowerPostBarState.downvoted) {
                            state = LowerPostBarState.upvoted;
                            widget.post.setVote(widget.post.votes! + 2);
                          } else {
                            state = LowerPostBarState.upvoted;
                            widget.post.setVote(widget.post.votes! + 1);
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
                      color: widget.iconColor,
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
                            widget.post.setVote(widget.post.votes! + 1);
                          } else if (state == LowerPostBarState.upvoted) {
                            state = LowerPostBarState.downvoted;
                            widget.post.setVote(widget.post.votes! - 2);
                          } else {
                            state = LowerPostBarState.downvoted;
                            widget.post.setVote(widget.post.votes! - 1);
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
                ],
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  goToPost(context, widget.post);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      color: widget.iconColor,
                    ),
                    Text(
                      '${widget.post.numberOfComments ?? 0}',
                      style: TextStyle(
                        color: widget.iconColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            Expanded(
              flex: 4,
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: !widget.isMod
                      ? [
                          Icon(
                            Icons.share,
                            color: widget.iconColor,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
