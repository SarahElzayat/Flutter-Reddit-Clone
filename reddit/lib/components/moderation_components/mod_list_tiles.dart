///@uthor: Yasmine Ghanem
///@date 20/12/2022
///a custom list tile to use in moderation screens

import 'package:flutter/material.dart';
import '../helpers/color_manager.dart';

class ModListTile extends StatelessWidget {
  /// the function performed when tapping on the list tile
  /// goes to user profile
  // ignore: prefer_typing_uninitialized_variables
  final onTap;

  ///the title of the list tile
  ///the username of the user
  final String title;

  const ModListTile({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashColor: Colors.transparent),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(
              color: ColorManager.eggshellWhite, fontWeight: FontWeight.w300),
        ),
        tileColor: ColorManager.betterDarkGrey,
        hoverColor: ColorManager.grey.withOpacity(0.5),
        selectedColor: ColorManager.grey.withOpacity(0.5),
      ),
    );
  }
}
