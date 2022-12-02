/// The Lower Bar of the Post that contains the Comments and the Share Button and any other necessary buttons
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum ModOPtions { spoiler, nsfw, lock, unsticky, remove, spam, approve }

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
    var isMod = widget.post.inYourSubreddit ?? false;
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
              onTap: () {
                if (isMod) {
                  _askedToLead();
                } else {
                  // TODO
                  // sharePost(context, widget.post);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: isMod
                    ? [
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
                      ]
                    : [
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
                      ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget _buildItem(icon, text) {
    return Row(
      children: [
        Icon(icon, color: ColorManager.eggshellWhite, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style:
              const TextStyle(color: ColorManager.eggshellWhite, fontSize: 15),
        ),
      ],
    );
  }

  Future<void> _askedToLead() async {
    switch (await showDialog<ModOPtions>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ModOPtions.spoiler);
                },
                child: _buildItem(Icons.privacy_tip_outlined, 'Mark Spoiler'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ModOPtions.nsfw);
                },
                child: _buildItem(Icons.eighteen_up_rating, 'Mark NSFW'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ModOPtions.lock);
                },
                child: _buildItem(Icons.lock, 'Lock Comments'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ModOPtions.unsticky);
                },
                child: _buildItem(Icons.push_pin_outlined, 'Unsticky Post'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ModOPtions.remove);
                },
                child: _buildItem(Icons.cancel, 'Remove Post'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ModOPtions.spam);
                },
                child: _buildItem(Icons.delete, 'Remove as Spam'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, ModOPtions.approve);
                },
                child: _buildItem(Icons.check, 'Approve Post'),
              ),
            ],
          );
        })) {
      case ModOPtions.spoiler:
        // TODO: Handle this case.
        break;
      case ModOPtions.nsfw:
        // TODO: Handle this case.
        break;
      case ModOPtions.lock:
        // TODO: Handle this case.
        break;
      case ModOPtions.unsticky:
        // TODO: Handle this case.
        break;
      case ModOPtions.remove:
        // TODO: Handle this case.
        break;
      case ModOPtions.spam:
        // TODO: Handle this case.
        break;
      case ModOPtions.approve:
        // TODO: Handle this case.
        break;
      case null:
        // dialog dismissed
        break;
    }
  }
}
