/// the menu items manager in the post DropDownList
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:reddit/widgets/posts/cubit/post_cubit.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';

/// Class of a single Menu item
/// it contains the icon and the text used
class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  /// The text of the menu item
  final String text;

  /// The icon of the menu item
  final IconData icon;
}

/// container class of all the menu items that are shown iin the dropDownList
class MenuItems {
  static const List<MenuItem> publicItems = [save, hide, report, block];
  static const List<MenuItem> publicItemsSaved = [unsave, hide, report, block];
  static const List<MenuItem> myPostsItems = [save, share, delete];

  // all the menu items that we choose from
  static const save = MenuItem(text: 'Save', icon: Icons.bookmark_border);
  static const unsave = MenuItem(text: 'UnSave', icon: Icons.bookmark);
  static const hide = MenuItem(text: 'Hide post', icon: Icons.visibility_off);
  static const report = MenuItem(text: 'Report', icon: Icons.flag_outlined);
  static const block = MenuItem(text: 'Block Acount', icon: Icons.block);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);
  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const copy = MenuItem(text: 'Copy', icon: Icons.copy);

  /// builds the row of the menu Item
  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }

  /// exexutes the onChanged of each Item
  static onChanged(BuildContext context, MenuItem item, String postId) {
    var cubit = PostCubit.get(context);
    switch (item) {
      case MenuItems.save:
      case MenuItems.unsave:
        //Do something
        cubit.save().then((value) {
          PostNotifierCubit.get(context).changedPost();
        });
        break;
      case MenuItems.report:
        //Do something
        break;
      case MenuItems.hide:
        //Do something
        cubit.save().then((value) {
          PostNotifierCubit.get(context).changedPost();
        });
        break;
      case MenuItems.block:
        //Do something
        cubit.blockUser().then((value) {
          PostNotifierCubit.get(context).changedPost();
        });

        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.delete:
        //Do something
        cubit.delete();
        PostNotifierCubit.get(context).changedPost();

        break;
    }
  }
}
