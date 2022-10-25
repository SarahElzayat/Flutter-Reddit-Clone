/// Author @yasmineghanem
/// Date: 25/10/2022
/// Reuasable custom button component

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Button extends StatelessWidget {
  final String text; //text written in button
  final Color textColor; //color of button text
  final Color backgroundColor; //color of the button
  final double buttonWidth; //for size of button
  final double buttonHeight; //for size of button
  FontWeight? textFontWeight; //font size of text
  double? textFontSize; //weight of font (normal/bold/...)
  Color? borderColor; //border color if it exists
  VoidCallback onPressed; //actual function of button when pressed
  double _borderWidth = 1.0;

  Button(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.buttonWidth,
      required this.buttonHeight,
      this.textFontSize,
      this.textFontWeight,
      this.borderColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      child: Material(
          child: Ink(
        decoration: BoxDecoration(
            color: backgroundColor, //button background color
            borderRadius: BorderRadius.circular(50), //for circular buttons
            border: Border.all(
              color: borderColor ??
                  backgroundColor, //if border color is not passed set it to background color
              width: _borderWidth = borderColor == null ? 0 : _borderWidth,
            )),
        child: InkWell(
          onTap: onPressed, //passed function of button when pressed
          splashColor: Colors.transparent,
          highlightColor:
              Colors.black.withOpacity(0.1), //color when the button is pressed
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: textFontSize ?? 12,
                fontWeight: textFontWeight ?? FontWeight.normal,
              ),
            ),
          ),
        ),
      )),
    );
  }
}
