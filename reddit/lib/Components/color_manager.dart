/// Author @SarahElzayat
/// Date: 23/10/2022
/// Color palette static Colorants of Reddit

import 'package:flutter/material.dart';

class ColorManager {
  static Color primaryColor =
      const Color(0xffcc3700); //primary color of the application

  static Color hoverOrange =
      const Color(0xffbe3502); //orange buttons when hovered

  static Color darkGrey =
      const Color(0xff181a1b); //posts background, colorless buttons

  static const Color black = Color(0xff0a0a0a); //background color of the app
  static Color lightGrey =
      const Color(0xff8d857b); //text in appbar, small headlines and icons

  static Color blueGrey =
      const Color(0xff191f25); //body background, text form fields when hovered

  static Color hoverGrey =
      const Color(0xff171d21); //colorless buttons when hovered

  static Color grey = const Color(0xff2f3435); //buttons when hovered

  static Color disabledButtonGrey =
      const Color(0xff5f5f5f); //buttons when hovered
  static Color disabledHoverButtonGrey =
      const Color(0xff5a5a5a); //buttons when hovered

  static Color deepDarkGrey =
      const Color(0xff1d1f20); //text form field when not focused

  static const Color eggshellWhite = Color(0xffd6d3cd); //general text
  static const Color white = Color(0xffffffff); //general text

  static Color blue = const Color(
      0xff47aef8); //blue buttons, some borders, selected filter(hot, trending...)

  static Color downvoteBlue =
      const Color(0xff69adff); //arrow color when downvote is pressed
  static Color upvoteRed =
      const Color(0xffff581a); //arrow color when upvote is pressed

  static Color hoverBlue = const Color(0xff025b9e); //blue buttons when hovered

//red and orange are used together as a gradient background for some buttons
  static Color gradientRed = const Color(0xffbd051c);
  static Color gradientOrange = const Color(0xffbe5c01);

  static Color green =
      const Color(0xff55d56d); //news growing up arrow, online, some buttons
  static Color red = const Color(0xffff284c); //news growing down arrow

  static Color notificationRed =
      const Color(0xffcc3700); //news growing down arrow

  static Color bottomSheetBackgound = const Color(0xFF212121);

  static Color bottomSheetTitle = const Color.fromRGBO(129, 131, 132, 1);

  static Color unselectedItem = const Color.fromRGBO(86, 87, 88, 1);
}
