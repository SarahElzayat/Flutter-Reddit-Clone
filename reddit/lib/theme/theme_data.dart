/// @author Sarah El-Zayat
/// @date 9/11/2022
/// Theme of the whole application
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
      titleTextStyle: TextStyle(
        color: ColorManager.eggshellWhite,
        fontSize: 20,
      ),
    ),
    drawerTheme: const DrawerThemeData(
        backgroundColor: ColorManager.black, elevation: 10),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: ColorManager.grey),
      alignLabelWithHint: true,
    ),
    colorScheme: const ColorScheme(
      onError: ColorManager.white,
      brightness: Brightness.dark,
      primaryContainer: ColorManager.blue,
      secondaryContainer: ColorManager.blue,
      inverseSurface: ColorManager.blue,
      errorContainer: ColorManager.white,
      background: ColorManager.blue,
      onSurface: ColorManager.white,
      primary: ColorManager.white,
      secondary: ColorManager.white,
      surface: ColorManager.white,
      error: ColorManager.white,
      onBackground: ColorManager.white,
      onPrimary: ColorManager.white,
      onSecondary: ColorManager.white,
      outline: ColorManager.white,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: ColorManager.eggshellWhite,
      ),
      titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: ColorManager.eggshellWhite),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.normal,
          color: ColorManager.eggshellWhite),
      displaySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: ColorManager.eggshellWhite),
    ),
  );
}
