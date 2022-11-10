/// Author @SarahElzayat
/// Date: 23/10/2022
/// Color palette static const Colorants of Reddit

import 'package:flutter/material.dart';

class ColorManager {
  static const Color primaryColor =
      Color(0xffcc3700); //primary color of the application

  static const Color white = Colors.white; //white color of the application

  static const Color hoverOrange =
      Color(0xffbe3502); //orange buttons when hovered

  static const Color greyColor = Color(0XFF7a7a7a);

  static const Color darkGrey =
      Color(0xff181a1b); //posts background, colorless buttons

  static const Color lightGrey =
      Color(0xff8d857b); //text in appbar, small headlines and icons

  static const Color blueGrey =
      Color(0xff191f25); //body background, text form fields when hovered

  static const Color hoverGrey =
      Color(0xff171d21); //colorless buttons when hovered

  static const Color grey = Color(0xff2f3435); //buttons when hovered

  static const Color disabledButtonGrey =
      Color(0xff5f5f5f); //buttons when hovered
  static const Color disabledHoverButtonGrey =
      Color(0xff5a5a5a); //buttons when hovered

  static const Color deepDarkGrey =
      Color(0xff1d1f20); //text form field when not focused

  static const Color eggshellWhite = Color(0xffd6d3cd); //general text
  static const Color black = Color(0xff0a0a0a); //background color of the app

  static const Color blue = Color(
      0xff47aef8); //blue buttons, some borders, selected filter(hot, trending...)
  static const Color darkBlueColor = Color(0XFF036fc2);

  static const Color hoverBlue = Color(0xff025b9e); //blue buttons when hovered

  static const Color downvoteBlue =
      Color(0xff69adff); //arrow color when downvote is pressed

  static const Color darkBlue =
      Color.fromARGB(255, 8, 57, 117); //arrow color when downvote is pressed
  static const Color upvoteRed =
      Color(0xffff581a); //arrow color when upvote is pressed

//red and orange are used together as a gradient background for some buttons
  static const Color gradientRed = Color(0xffbd051c);
  static const Color gradientOrange = Color(0xffbe5c01);

  static const Color green =
      Color(0xff55d56d); //news growing up arrow, online, some buttons
  static const Color red = Color(0xffff284c); //news growing down arrow

  static const Color notificationRed =
      Color(0xffcc3700); //news growing down arrow

  static const Color bottomSheetBackgound = Color(0xFF212121);
  static const Color bottomSheetTitle = Color.fromRGBO(129, 131, 132, 1);
  static const Color unselectedItem = Color.fromRGBO(86, 87, 88, 1);

  static const Color yellow = Colors.yellow;

  static const Color textFieldBackground = Color.fromARGB(255, 59, 58, 58);
}
