/// The Lower Bar of the Post that contains the Comments and the Share Button and any other necessary buttons
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/mod_in_post_models/approve_model.dart';
import 'package:reddit/data/mod_in_post_models/lock_model.dart';
import 'package:reddit/data/mod_in_post_models/mark_nsfw_model.dart';
import 'package:reddit/data/mod_in_post_models/mark_spoiler_model.dart';
import 'package:reddit/data/mod_in_post_models/remove_model.dart';
import 'package:reddit/data/mod_in_post_models/unsticky_post_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
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
                key: const Key('spoiler-option'),
                onPressed: () {
                  Navigator.pop(context, ModOPtions.spoiler);
                },
                child: _buildItem(Icons.privacy_tip_outlined, 'Mark Spoiler'),
              ),
              SimpleDialogOption(
                key: const Key('nsfw-option'),
                onPressed: () {
                  Navigator.pop(context, ModOPtions.nsfw);
                },
                child: _buildItem(Icons.eighteen_up_rating, 'Mark NSFW'),
              ),
              SimpleDialogOption(
                key: const Key('lock-option'),
                onPressed: () {
                  Navigator.pop(context, ModOPtions.lock);
                },
                child: _buildItem(Icons.lock, 'Lock Comments'),
              ),
              SimpleDialogOption(
                key: const Key('unsticky-option'),
                onPressed: () {
                  Navigator.pop(context, ModOPtions.unsticky);
                },
                child: _buildItem(Icons.push_pin_outlined, 'Unsticky Post'),
              ),
              SimpleDialogOption(
                key: const Key('remove-option'),
                onPressed: () {
                  Navigator.pop(context, ModOPtions.remove);
                },
                child: _buildItem(Icons.cancel, 'Remove Post'),
              ),
              SimpleDialogOption(
                key: const Key('spam-option'),
                onPressed: () {
                  Navigator.pop(context, ModOPtions.spam);
                },
                child: _buildItem(Icons.delete, 'Remove as Spam'),
              ),
              SimpleDialogOption(
                key: const Key('approve-option'),
                onPressed: () {
                  Navigator.pop(context, ModOPtions.approve);
                },
                child: _buildItem(Icons.check, 'Approve Post'),
              ),
            ],
          );
        })) {
      case ModOPtions.spoiler:
        // marks a post as a spoiler to blur the post
        () {
          final spoiler = MarkSpoilerModel(id: widget.post.id);
          var token = CacheHelper.getData(key: 'token') ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';

          DioHelper.postData(
                  token: '$token', path: markSpoiler, data: spoiler.toJson())
              .then((value) {
            if (value.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Sorry please try again later')));
            }
          }).catchError((err) {
            err = err as DioError;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('The post is now marked spoiler')));
          });
        };
        break;
      // sends request to mark a post as nsfw
      case ModOPtions.nsfw:
        // marks the post as nsfw
        () {
          final nsfw = MarkNSFWModel(id: widget.post.id);
          var token = CacheHelper.getData(key: 'token') ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';
          DioHelper.postData(
                  token: '$token', path: markNSFW, data: nsfw.toJson())
              .then((value) {
            if (value.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('The post is now marked spoiler')));
            }
          }).catchError((err) {
            err = err as DioError;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry please try again later')));
          });
        };
        break;
      case ModOPtions.lock:
        // locks comments on a post so no one can comment
        () {
          final lockComments = LockModel(id: widget.post.id, type: 'comment');
          var token = CacheHelper.getData(key: 'token') ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';

          DioHelper.postData(
                  token: '$token', path: lock, data: lockComments.toJson())
              .then((value) {
            if (value.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Comments are now locked')));
            }
          }).catchError((err) {
            err = err as DioError;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry please try again later')));
          });
        };
        break;

      case ModOPtions.unsticky:
        // pins or unpins a post to or from a subreddit
        () {
          final stickUnstickPost = PinPostModel(id: widget.post.id, pin: false);

          var token = CacheHelper.getData(key: 'token') ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';

          DioHelper.postData(
                  token: '$token',
                  path: pinPost,
                  data: stickUnstickPost.toJson())
              .then((value) {
            if (value.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post is now unstickied')));
            }
          }).catchError((err) {
            err = err as DioError;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry please try again later')));
          });
        };
        break;
      case ModOPtions.remove:
        // removes a post from subreddit
        () {
          final removePost = RemoveModel(id: widget.post.id, type: 'post');
          var token = CacheHelper.getData(key: 'token') ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';
          DioHelper.postData(
                  token: '$token', path: remove, data: removePost.toJson())
              .then((value) {
            if (value.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post is removed')));
            }
          }).catchError((err) {
            err = err as DioError;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry please try again later')));
          });
        };
        break;
      case ModOPtions.spam:
        // removes post or comment as spam
        () {
          final removeAsSpam = RemoveModel(id: widget.post.id, type: 'post');
          var token = CacheHelper.getData(key: 'token') ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';
          DioHelper.postData(
                  token: '$token', path: remove, data: removeAsSpam.toJson())
              .then((value) {
            if (value.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post is removed as spam')));
            }
          }).catchError((err) {
            err = err as DioError;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry please try again later')));
          });
        };
        break;
      case ModOPtions.approve:
        // approves a post to be posted in a subreddit
        () {
          final approvePost = ApproveModel(id: widget.post.id, type: 'post');
          var token = CacheHelper.getData(key: 'token') ??
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';
          DioHelper.postData(
                  token: '$token', path: approve, data: approvePost.toJson())
              .then((value) {
            if (value.statusCode == 200) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Post approved')));
            }
          }).catchError((err) {
            err = err as DioError;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sorry please try again later')));
          });
        };
        break;
      case null:
        // dialog dismissed
        break;
    }
  }
}
