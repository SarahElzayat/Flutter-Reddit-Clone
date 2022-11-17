import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_state.dart';
import 'package:reddit/widgets/posts/cubit/post_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'cubit/post_state.dart';
import 'menu_items.dart' as mi;

enum ItemsClass { public, publicSaved, myPost }

class DropDownList extends StatelessWidget {
  const DropDownList({
    Key? key,
    required this.postId,
    required this.itemClass,
  }) : super(key: key);

  final String postId;
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
