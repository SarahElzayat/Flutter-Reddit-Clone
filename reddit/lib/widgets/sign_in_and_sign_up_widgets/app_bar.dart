import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';

class LogInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LogInAppBar(
      {super.key,
      required this.sideBarButtonText,
      required this.sideBarButtonAction});

  final sideBarButtonText;
  final sideBarButtonAction;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AppBar(
        foregroundColor: ColorManager.darkGrey,
        backgroundColor: ColorManager.darkGrey,
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: sideBarButtonAction,
              child: Text(
                sideBarButtonText,
                style: const TextStyle(
                    color: ColorManager.greyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ))
        ],
        title: SizedBox(
          height: mediaQuery.size.height * 0.04,
          child: Image.asset('assets/images/Logo.png', fit: BoxFit.contain),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
