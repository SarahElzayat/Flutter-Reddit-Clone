/// The Post's DropDown List Widget that has Alot of options depending on the post
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'menu_items.dart';

enum ItemsClass { comments, posts }

/// The DropDown List Widget that has Alot of options depending on the post
class DropDownList extends StatelessWidget {
  const DropDownList({
    Key? key,
    required this.post,
    this.comment,
    this.itemClass = ItemsClass.posts,
    this.outsideScreen = false,
    this.isWeb = false,
  }) : super(key: key);

  /// The [PostModel] of targeted Post
  final PostModel post;
  final CommentModel? comment;

  /// The Class of the Post
  /// depends on the post's status
  /// defaults to [ItemsClass.public]
  final ItemsClass itemClass;

  final bool outsideScreen;

  final bool isWeb;
  List<MenuItem> getList() {
    switch (itemClass) {
      case ItemsClass.comments:
        return _chooseForComments();
      case ItemsClass.posts:
        return _chooseForPosts(isWeb: isWeb);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.more_vert,
          color: ColorManager.greyColor,
        ),
        items: [
          ...getList().map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildDropMenuItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem, post);
        },
        dropdownWidth: 45.w,
        dropdownMaxHeight: 40.h,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 8),
      ),
    );
  }

  List<MenuItem> _chooseForComments() {
    List<MenuItem> l = MenuItems.commentItems.toList();

    l.add((comment?.followed ?? false) ? MenuItems.unfollow : MenuItems.follow);
    l.insert(0, (comment?.saved ?? false) ? MenuItems.unsave : MenuItems.save);
    if (!outsideScreen) {
      l.add(MenuItems.edit);
    }
    return l;
  }

  List<MenuItem> _chooseForPosts({bool? isWeb}) {
    List<MenuItem> l = [];
    if (post.saved ?? false) {
      l.add(MenuItems.unsave);
    } else {
      l.add(MenuItems.save);
    }

    // not my post
    if (post.postedBy != CacheHelper.getData(key: 'username')) {
      l.add(MenuItems.report);
      l.add(MenuItems.hide);
      l.add(MenuItems.block);
    } else {
      l.add(MenuItems.delete);
      if (!outsideScreen && post.kind == 'hybrid') {
        l.add(MenuItems.edit);
      }
    }

    if (!outsideScreen) {
      l.add(MenuItems.share);
      l.add(MenuItems.copy);
      l.add((post.followed ?? false) ? MenuItems.unfollow : MenuItems.follow);
    }

    if (isWeb ?? false) {
      l.removeWhere(
          (element) => (element.text == 'Save' || element.text == 'UnSave'));
    }
    return l;
  }
}
