/// the menu items manager in the post DropDownList
/// date: 8/11/2022
/// @Author: Ahmed Atta

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';

import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/screens/posts/edit_screen.dart';
import 'package:reddit/screens/posts/pick_community.dart';
import 'package:reddit/screens/posts/share_to_community.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../functions/post_functions.dart';

/// Class of a single Menu item
/// it contains the icon and the text used
class MenuItem {
  const MenuItem({required this.text, required this.icon, this.modOPtions});

  /// The text of the menu item
  final String text;

  /// The icon of the menu item
  final IconData icon;

  final ModOPtions? modOPtions;
}

/// container class of all the menu items that are shown iin the dropDownList
class MenuItems {
  static const List<MenuItem> publicOutItems = [hide, report, block];
  static const List<MenuItem> publicInItems = [
    share,
    follow,
    copy,
    save,
    hide,
    report,
    block
  ];
  static const List<MenuItem> publicItemsSaved = [unsave, hide, report, block];
  static const List<MenuItem> myPostsOutItems = [save, share, delete];
  static const List<MenuItem> myPostsInItems = [
    share,
    follow,
    save,
    copy,
    delete
  ];

  static const List<MenuItem> commentItems = [
    share,
    copy,
    collapse,
    block,
    report,
    markNSFW
  ];

  static const List<MenuItem> myCommentItems = [
    share,
    save,
    follow,
    copy,
    collapse,
    delete
  ];

  // all the menu items that we choose from
  static const save = MenuItem(text: 'Save', icon: Icons.bookmark_border);
  static const follow = MenuItem(text: 'Follow', icon: Icons.notification_add);
  static const unfollow =
      MenuItem(text: 'Unfollow', icon: Icons.notifications_active);
  static const collapse =
      MenuItem(text: 'Collapse Thread', icon: Icons.compare_arrows);
  static const unsave = MenuItem(text: 'UnSave', icon: Icons.bookmark);
  static const hide = MenuItem(text: 'Hide post', icon: Icons.visibility_off);
  static const report = MenuItem(text: 'Report', icon: Icons.flag_outlined);
  static const block = MenuItem(text: 'Block Acount', icon: Icons.block);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);
  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const copy = MenuItem(text: 'Copy text', icon: Icons.copy);
  static const markNSFW = MenuItem(text: 'Mark NSFW', icon: Icons.flag);
  static const markSpoiler =
      MenuItem(text: 'Mark Spoiler', icon: Icons.privacy_tip_outlined);
  static const download = MenuItem(text: 'Download', icon: Icons.download);
  static const mute = MenuItem(text: 'Mute', icon: Icons.volume_off_sharp);

  /// builds the row of the menu Item
  static Widget buildDropMenuItem(MenuItem item, {iconColor = Colors.white}) {
    return Row(
      children: [
        Icon(item.icon, color: iconColor, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: TextStyle(color: iconColor, fontSize: 15),
        ),
      ],
    );
  }

  /// exexutes the onChanged of each Item
  static onChanged(BuildContext context, MenuItem item, PostModel post) {
    var cubit = PostAndCommentActionsCubit.get(context);
    switch (item) {
      case MenuItems.save:
      case MenuItems.unsave:
        //Do something
        cubit.save().then((value) {
          PostNotifierCubit.get(context).notifyPosts();
        });
        break;
      case MenuItems.report:
        //Do something
        break;
      case MenuItems.hide:
        //Do something
        cubit.hide().then((value) {
          if (value == true) {
            PostNotifierCubit.get(context).deletedPost(cubit.post.id!);
            ScaffoldMessenger.of(context).showSnackBar(
              responseSnackBar(
                message: 'Post Hidden',
                error: false,
              ),
            );
          }
        });
        break;
      case MenuItems.block:
        //Do something
        cubit.blockUser().then((value) {
          PostNotifierCubit.get(context).notifyPosts();
        });

        break;
      case MenuItems.share:
        showModalBottomSheet(
          context: context,
          builder: (context) =>
              shareModalBottomSheet(context: context, post: post),
        );
        //Do something

        break;
      case MenuItems.delete:
        //Do something
        cubit.delete().then((value) {
          if (value == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              responseSnackBar(
                message: 'Something went wrong',
                error: true,
              ),
            );
            return;
          }
          if (value) {
            PostNotifierCubit.get(context).deletedPost(cubit.post.id!);
          } else {
            PostNotifierCubit.get(context)
                .deletedComment(cubit.currentComment!.id!);
          }
        });
        PostNotifierCubit.get(context).notifyPosts();

        break;
      case MenuItems.edit:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditScreen(
            post: post,
            currentComment: cubit.currentComment,
          );
        }));

        break;
      case MenuItems.follow:
      case MenuItems.unfollow:
        cubit.follow().then((value) {
          PostNotifierCubit.get(context).notifyPosts();
        });
        break;
      case MenuItems.copy:
        cubit.copyText().then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            responseSnackBar(
              message: 'Your copy is ready for paste!',
              error: false,
            ),
          );
        }).catchError((err) {
          ScaffoldMessenger.of(context).showSnackBar(
            responseSnackBar(
              message: 'Error while copying',
              error: true,
            ),
          );
        });
        break;
      case MenuItems.collapse:
        cubit.collapse();
        PostNotifierCubit.get(context).notifyPosts();
        break;
      default:
        break;
    }
  }
}

shareModalBottomSheet(
    {required BuildContext context, required PostModel post}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        shareIcon(
            icon: Icons.fork_right,
            label: 'Community',
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PickCommunityScreen(
                    sharedPost: post,
                  ),
                ))),
        shareIcon(
            icon: Icons.person_outline_rounded,
            label: 'Profile',
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShareToCommunityScreen(
                    isCommunity: false,
                    username: AppCubit.get(context).username,
                    sharedPost: post,
                  ),
                ))),
      ],
    ),
  );
}

Widget shareIcon({required IconData icon, required label, required onPressed}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: onPressed,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: ColorManager.black,
          child: Icon(icon),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: ColorManager.eggshellWhite,
        ),
      )
    ],
  );
}
