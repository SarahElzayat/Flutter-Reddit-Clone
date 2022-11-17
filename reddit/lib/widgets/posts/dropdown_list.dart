import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'menu_items.dart' as mi;

enum ItemsClass { public, myPost }

class DropDownList extends StatelessWidget {
  DropDownList({
    Key? key,
    required this.postId,
    required this.itemClass,
  }) : super(key: key);

  final String postId;
  final ItemsClass itemClass;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.more_vert,
        ),
        items: [
          ...((itemClass == ItemsClass.public)
                  ? mi.MenuItems.publicItems
                  : mi.MenuItems.myPostsItems)
              .map(
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
  }
}
