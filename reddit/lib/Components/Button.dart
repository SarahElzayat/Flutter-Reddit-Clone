/// @author yasmineghanem
/// @date: 25/10/2022
/// Reuasable custom button component
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

class Button extends StatelessWidget {
  Key? key;

  ///the text on the button
  final String text;

  ///color of the text
  final Color? textColor;

  ///button background color
  final Color backgroundColor;

  ///splash color of button for android
  final Color? splashColor;

  ///width of the button
  final double? buttonWidth;

  ///height of the button
  final double? buttonHeight;

  /// fontweight of the text
  final FontWeight textFontWeight;

  ///font size of text
  final double? textFontSize;

  ///border color of button border
  final Color? borderColor;

  ///circular radius of border
  final double borderRadius;

  ///thickness of border
  final double borderWidth;

  ///bool to check for validation, disables button when not validated
  final bool disabled;

  ///image path to add image to button
  final String? imagePath;

  ///function of the pressed button
  final onPressed;

  Button({
    super.key,
    this.text = 'Button',
    this.textColor = ColorManager.white,
    this.backgroundColor = ColorManager.blue,
    this.buttonWidth = 10.0,
    this.buttonHeight = 5.0,
    this.textFontSize = 16,
    this.textFontWeight = FontWeight.normal,
    this.splashColor = ColorManager.white,
    this.borderColor,
    this.borderRadius = 50.0,
    this.borderWidth = 1.0,
    this.disabled = false,
    this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          // for circular buttons
          border: Border.all(
            // if border color is not passed set it to background color
            color: borderColor == null ? backgroundColor : borderColor!,
            width: borderColor == null ? 0 : borderWidth,
          )),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: buttonWidth,
        height: buttonHeight,
        elevation: 0,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        highlightElevation: 0,
        color: backgroundColor,
        splashColor: (disabled || (CacheHelper.getData(key: 'isWindows')!))
            ? Colors.transparent
            : splashColor,
        highlightColor: (CacheHelper.getData(key: 'isAndroid')!)
            ? Colors.transparent
            : Colors.black.withOpacity(0.1),
        child: Text(text,
            style: TextStyle(
                fontSize: textFontSize,
                fontWeight: textFontWeight,
                color: textColor)),
      ),
    );
  }
}
