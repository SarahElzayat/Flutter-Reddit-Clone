import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/helpers/color_manager.dart';
import '../cubit/post_notifier/post_notifier_state.dart';
import '../data/post_model/post_model.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/data/mod_in_post_models/approve_model.dart';
import 'package:reddit/data/mod_in_post_models/lock_model.dart';
import 'package:reddit/data/mod_in_post_models/mark_nsfw_model.dart';
import 'package:reddit/data/mod_in_post_models/mark_spoiler_model.dart';
import 'package:reddit/data/mod_in_post_models/remove_model.dart';
import 'package:dio/dio.dart';
import 'package:reddit/data/mod_in_post_models/unsticky_post_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../widgets/posts/dropdown_list.dart';

enum ModOPtions { spoiler, nsfw, lock, unsticky, remove, spam, approve }

BlocBuilder<PostNotifierCubit, PostNotifierState> dropDownDots(post) {
  return BlocBuilder<PostNotifierCubit, PostNotifierState>(
    builder: (context, state) {
      return DropDownList(
        postId: post.id!,
        itemClass:
            (post.saved ?? true) ? ItemsClass.publicSaved : ItemsClass.public,
      );
    },
  );
}

CircleAvatar subredditAvatar({small = false}) {
  return CircleAvatar(
    radius: small ? min(3.w, 15) : min(5.5.w, 30),
    backgroundColor: Colors.transparent,
    backgroundImage: const NetworkImage(
        'https://styles.redditmedia.com/t5_2qh87/styles/communityIcon_ub69d1lpjlf51.png?width=256&s=920c352b6d0c69518b6978ba8b456176a8d63c25'),
  );
}

Widget singleRow({
  bool sub = false,
  bool showIcon = false,
  bool showDots = true,
  required PostModel post,
}) {
  return Row(
    children: [
      if (showIcon) subredditAvatar(small: true),
      if (showIcon)
        SizedBox(
          width: min(5.w, 0.2.dp),
        ),
      Text(
        '${sub ? 'r' : 'u'}/${post.postedBy} • ',
        style: const TextStyle(
          color: ColorManager.greyColor,
          fontSize: 15,
        ),
      ),
      Text(
        timeago.format(DateTime.tryParse(post.postedAt ?? '') ?? DateTime.now(),
            locale: 'en_short'),
        style: const TextStyle(
          color: ColorManager.greyColor,
          fontSize: 15,
        ),
      ),
      if (showIcon) const Spacer(),
      if (showDots) dropDownDots(post)
    ],
  );
}

Widget buildModItem(icon, text, {bool disabled = false}) {
  return Row(
    children: [
      Icon(icon,
          color: disabled
              ? ColorManager.disabledButtonGrey
              : ColorManager.eggshellWhite,
          size: 22),
      const SizedBox(
        width: 10,
      ),
      Text(
        text,
        style: TextStyle(
            color: disabled
                ? ColorManager.disabledButtonGrey
                : ColorManager.eggshellWhite,
            fontSize: 15),
      ),
    ],
  );
}

bool _isApproved(post) {
  if (post.moderation?.approve?.approvedBy == null) {
    return false;
  }
  return true;
}

Future<void> showModOperations({
  required BuildContext context,
  required PostModel post,
}) async {
  var returnedOption = await showDialog<ModOPtions>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              key: const Key('spoiler-option'),
              onPressed: () {
                Navigator.pop(context, ModOPtions.spoiler);
              },
              child: buildModItem(Icons.privacy_tip_outlined,
                  '${post.spoiler ?? false ? 'Unmark' : 'Mark'}Spoiler'),
            ),
            SimpleDialogOption(
              key: const Key('nsfw-option'),
              onPressed: () {
                Navigator.pop(context, ModOPtions.nsfw);
              },
              child: buildModItem(Icons.eighteen_up_rating,
                  '${post.nsfw ?? false ? 'Unmark' : 'Mark'} NSFW'),
            ),
            SimpleDialogOption(
              key: const Key('lock-option'),
              onPressed: () {
                Navigator.pop(context, ModOPtions.lock);
              },
              child: buildModItem(Icons.lock,
                  '${post.moderation?.lock ?? false ? 'Unlock' : 'Lock'} Comments'),
            ),
            SimpleDialogOption(
              key: const Key('unsticky-option'),
              onPressed: () {
                Navigator.pop(context, ModOPtions.unsticky);
              },
              child: buildModItem(Icons.push_pin_outlined, 'Unsticky Post'),
            ),
            SimpleDialogOption(
              key: const Key('remove-option'),
              onPressed: () {
                Navigator.pop(context, ModOPtions.remove);
              },
              child: buildModItem(Icons.cancel, 'Remove Post'),
            ),
            SimpleDialogOption(
              key: const Key('spam-option'),
              onPressed: () {
                Navigator.pop(context, ModOPtions.spam);
              },
              child: buildModItem(Icons.delete, 'Remove as Spam'),
            ),
            SimpleDialogOption(
              key: const Key('approve-option'),
              onPressed: _isApproved(post)
                  ? null
                  : () {
                      Navigator.pop(context, ModOPtions.approve);
                    },
              child: buildModItem(
                  Icons.check, 'Approve${_isApproved(post) ? 'd' : ''} Post',
                  disabled: true),
            ),
          ],
        );
      });
  debugPrint(returnedOption.toString());
  switch (returnedOption) {
    case ModOPtions.spoiler:
      final spoilerObj = MarkSpoilerModel(id: post.id);
      String? token = CacheHelper.getData(key: 'token');

      String finalPath = post.spoiler ?? false ? unmarkSpoiler : markSpoiler;

      DioHelper.patchData(
              token: token, path: finalPath, data: spoilerObj.toJson())
          .then((value) {
        if (value.statusCode == 200) {
          // togle the spoiler in the post
          post.spoiler = !post.spoiler!;
          //NOTE -  You have to update the POSTS after any change in the post that modifies the UI
          PostNotifierCubit.get(context).NotifyPosts();
        }
      }).catchError((err) {
        err = err as DioError;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: ColorManager.red,
            content:
                Text('Sorry, please try again later\nError: ${err.response}')));
      });

      break;
    // sends request to mark a post as nsfw
    case ModOPtions.nsfw:
      // marks the post as nsfw
      () {
        final nsfw = MarkNSFWModel(id: post.id);
        var token = CacheHelper.getData(key: 'token') ??
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';
        DioHelper.postData(token: '$token', path: markNSFW, data: nsfw.toJson())
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
        final lockComments = LockModel(id: post.id, type: 'comment');

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
        final stickUnstickPost = PinPostModel(id: post.id, pin: false);

        var token = CacheHelper.getData(key: 'token') ??
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';

        DioHelper.postData(
                token: '$token', path: pinPost, data: stickUnstickPost.toJson())
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
        final removePost = RemoveModel(id: post.id, type: 'post');
        var token = CacheHelper.getData(key: 'token') ??
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzdlYTA3Mzk2NjRjMzJjYTk4ZmRlYzYiLCJ1c2VybmFtZSI6ImFobWVkYXR0YTMzIiwiaWF0IjoxNjY5MjQyOTk1fQ.DZDPE1su3Pss2izCyv8G2WAdAlBT97mhga5ku-Y2K-U';
        DioHelper.postData(
                token: '$token', path: remove, data: removePost.toJson())
            .then((value) {
          if (value.statusCode == 200) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Post is removed')));
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
        final removeAsSpam = RemoveModel(id: post.id, type: 'post');
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
        final approvePost = ApproveModel(id: post.id, type: 'post');
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
