/// Author @yasmineghanem
/// Date: 25/10/2022
/// Reuasable custom button component

import 'package:flutter/material.dart';
import '../Components/color_manager.dart';

/// ignore: must_be_immutable
class Button extends StatelessWidget {

  ///text written in button
  final String text;

  /// color of the text
  final Color textColor;

  /// the background color of the button
  final Color backgroundColor;
  
  /// the width of the button
  final double buttonWidth;
  
  /// the height of the button 
  final double buttonHeight;

  /// the fontWeight of the text as the weight. 
  final FontWeight? textFontWeight;

  /// the font size 
  final double textFontSize;
  
  /// the color of the border.
  final Color? borderColor;

  /// the function that should be executed when the button is pressed. 
  final VoidCallback onPressed;
  
  /// the width of the boarded 
  double _borderWidth = 1.0;


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
              ),
            ),
          )),
    );
  }
}
