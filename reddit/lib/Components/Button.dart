/// Author @yasmineghanem
/// Date: 25/10/2022
/// Reuasable custom button component

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  final String text; //text written in button
  final Color textColor; //color of button text
  final Color backgroundColor; //color of the button
  final double buttonWidth; //for size of button
  final double buttonHeight; //for size of button
  final FontWeight? textFontWeight; //font size of text
  final double textFontSize; //weight of font (normal/bold/...)
  final Color? borderColor; //border color if it exists
  final VoidCallback onPressed; //actual function of button when pressed
  double _borderWidth = 1.0;

  /// it requires
  /// @param [text] which is the text to be displayed on the button
  /// @param [textColor] which is the color of the text
  /// @param [backgroundColor] which is the color of the background
  /// @param [buttonWidth] which is the width of each button
  /// @param [buttonHeight] which is the height of each button
  /// @param [textFontSize] which is the fontsize used for this button
  /// @param [textFontweight] which is the weight used for this button ie: bold
  /// @param [boarderWeight] which is the color of the boarders
  /// @param [onPressed] which is handler for each button
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
            color: backgroundColor, //button background color
            borderRadius: BorderRadius.circular(50), //for circular buttons
            border: Border.all(
              color: borderColor ??
                  backgroundColor, //if border color is not passed set it to background color
              width: _borderWidth = borderColor == null ? 0 : _borderWidth,
            )),
        child: InkWell(
          onTap: onPressed,
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
