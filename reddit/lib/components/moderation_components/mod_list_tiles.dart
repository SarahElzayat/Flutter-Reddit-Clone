import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';

class ModListTile extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
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
        tileColor: ColorManager.darkGrey,
        hoverColor: ColorManager.grey.withOpacity(0.5),
        selectedColor: ColorManager.grey.withOpacity(0.5),
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
