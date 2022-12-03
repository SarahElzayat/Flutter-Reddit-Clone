/// The Post's DropDown List Widget that has Alot of options depending on the post
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/widgets/posts/cubit/post_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'cubit/post_state.dart';
import 'menu_items.dart' as mi;

enum ItemsClass { public, publicSaved, myPost }

/// The DropDown List Widget that has Alot of options depending on the post
class DropDownList extends StatelessWidget {
  const DropDownList({
    Key? key,
    required this.postId,
    this.itemClass = ItemsClass.public,
  }) : super(key: key);

  /// The [PostModel.id] of targeted Post
  final String postId;

  /// The Class of the Post
  /// depends on the post's status
  /// defaults to [ItemsClass.public]
  final ItemsClass itemClass;

  List<mi.MenuItem> getList() {
    switch (itemClass) {
      case ItemsClass.public:
        return mi.MenuItems.publicItems;
      case ItemsClass.publicSaved:
        return mi.MenuItems.publicItemsSaved;
      case ItemsClass.myPost:
        return mi.MenuItems.myPostsItems;
      default:
        return mi.MenuItems.publicItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.more_vert,
            ),
            items: [
              ...getList().map(
                (item) => DropdownMenuItem<mi.MenuItem>(
                  value: item,
                  child: mi.MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              mi.MenuItems.onChanged(context, value as mi.MenuItem, postId);
            },
            dropdownWidth: 40.w,
            dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            dropdownElevation: 8,
            offset: const Offset(0, 8),
          ),
        );
      },
    );
  }
}
