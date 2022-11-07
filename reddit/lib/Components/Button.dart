/// @author yasmineghanem
/// @date: 25/10/2022
/// Reuasable custom button component

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;

  /// text written in button
  final Color textColor;

  /// color of button text
  final Color backgroundColor;

  /// color of the button
  final double buttonWidth;

  /// for size of button
  final double buttonHeight;

  /// for size of button
  final FontWeight? textFontWeight;

  /// font size of text
  final double textFontSize;

  /// weight of font (normal/bold/...)
  final Color? borderColor;

  /// border color if it exists
  final VoidCallback onPressed;

  /// actual function of button when pressed
  final double _borderWidth = 1.0;

  const Button(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.buttonWidth,
      required this.buttonHeight,
      required this.textFontSize,
      this.textFontWeight,
      this.borderColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double fontScale = MediaQuery.of(context).textScaleFactor;
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
                color: backgroundColor,

                /// button background color
                borderRadius: BorderRadius.circular(50),

                /// for circular buttons
                border: Border.all(
                  /// if border color is not passed set it to background color
                  color: borderColor == null ? backgroundColor : borderColor!,
                  width: borderColor == null ? 0 : _borderWidth,
                )),
            child: InkWell(
              onTap: onPressed,

              /// color when the button is pressed
              highlightColor: Colors.black.withOpacity(0.1),
              customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: (textFontSize * fontScale),

                    ///  ignore: prefer_if_null_operators
                    fontWeight: textFontWeight == null
                        ? FontWeight.normal
                        : textFontWeight,
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
