/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the appBar model for the Login
///and sign up and forget user name and also and we may use it later
///instead of creating it every single time.
import 'package:flutter/material.dart';

import '../../components/helpers/color_manager.dart';

class LogInAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LogInAppBar(
      {super.key,
      required this.sideBarButtonText,
      required this.sideBarButtonAction});

  /// this is the text in the app bar which may be sign in or sign out ... etc
  // ignore: prefer_typing_uninitialized_variables
  final sideBarButtonText;

  /// this is the function that should be excuted when pressing on the button
  // ignore: prefer_typing_uninitialized_variables
  final sideBarButtonAction;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AppBar(
        iconTheme: const IconThemeData(color: ColorManager.greyColor),
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

  /// defining how much height do we want to take for the app bar
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
