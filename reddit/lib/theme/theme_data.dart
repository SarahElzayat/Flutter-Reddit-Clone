import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: ColorManager.black,
      unselectedItemColor: ColorManager.lightGrey,
      selectedItemColor: ColorManager.eggshellWhite,
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.black87,
    ),

    drawerTheme: const DrawerThemeData(
        backgroundColor: ColorManager.black, elevation: 10),
    // ColorManager.deepDarkGrey)
  );
}
