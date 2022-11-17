import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/mocks/functions.dart';
import 'package:reddit/constants/constants.dart';

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> publicItems = [save, hide, report, block];
  static const List<MenuItem> myPostsItems = [save, share, delete];

  static const save = MenuItem(text: 'Save', icon: Icons.bookmark_border);
  static const hide = MenuItem(text: 'Hide post', icon: Icons.visibility_off);
  static const report = MenuItem(text: 'Report', icon: Icons.flag_outlined);
  static const block = MenuItem(text: 'Block Acount', icon: Icons.block);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const delete = MenuItem(text: 'Delete', icon: Icons.delete);
  static const edit = MenuItem(text: 'Edit', icon: Icons.edit);
  static const copy = MenuItem(text: 'Copy', icon: Icons.copy);

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

  static onChanged(BuildContext context, MenuItem item, String postId) {
    switch (item) {
      case MenuItems.save:
        //Do something
        mockDio.post(
          '$base/save',
          data: {
            'id': postId,
          },
        ).then((value) => print(value.data));
        break;
      case MenuItems.report:
        //Do something
        break;
      case MenuItems.hide:
        //Do something
        mockDio.post(
          '$base/hide',
          data: {
            'id': postId,
          },
        ).then((value) => print(value.data));
        break;
      case MenuItems.block:
        //Do something
        mockDio.post(
          '$base/block',
          data: {
            'id': postId,
          },
        ).then((value) => print(value.data));
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.delete:
        //Do something
        mockDio.post(
          '$base/delete',
          data: {
            'id': postId,
          },
        ).then((value) => print(value.data));
        break;
    }
  }
}
