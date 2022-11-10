/// Author @yasmineghanem
/// Date: 25/10/2022
/// Reuasable custom button component

import 'package:flutter/material.dart';

/// ignore: must_be_immutable
class Button extends StatelessWidget {
  final String text;

  ///text written in button
  final Color textColor;

  ///color of button text
  final Color backgroundColor;

  ///color of the button
  final double buttonWidth;

  ///for size of button
  final double buttonHeight;

  ///for size of button
  final FontWeight? textFontWeight;

  ///font size of text
  final double textFontSize;

  ///weight of font (normal/bold/...)
  final Color? borderColor;

  ///border color if it exists
  final VoidCallback onPressed;

  ///actual function of button when pressed
  double _borderWidth = 1.0;

  ///boarder radius of the button
  double? boarderRadius = 50;
  Button(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.buttonWidth,
      required this.buttonHeight,
      required this.textFontSize,
      this.textFontWeight,
      this.borderColor,
      this.boarderRadius,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double fontScale = MediaQuery.of(context).textScaleFactor;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Material(
          child: Ink(
        decoration: BoxDecoration(
            color: backgroundColor,

            ///button background color
            borderRadius: BorderRadius.circular(boarderRadius!),

            ///for circular buttons
            border: Border.all(
              color: borderColor ?? backgroundColor,

              ///if border color is not passed set it to background color
              width: _borderWidth = borderColor == null ? 0 : _borderWidth,
            )),
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.black.withOpacity(0.1),

          ///color when the button is pressed
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(boarderRadius!)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: (textFontSize * fontScale),
                fontWeight: textFontWeight ?? FontWeight.normal,
              ),
            ),
          ),
        ),
      )),
    );
  }
}
