/// @author yasmineghanem
/// @date: 25/10/2022
/// Reuasable custom button component
import 'package:flutter/material.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

// Widget Button(
//         {text = 'Button',
//         textColor = ColorManager.white,
//         backgroundColor = ColorManager.blue,
//         splashColor = ColorManager.white,
//         buttonWidth = 10.0,
//         buttonHeight = 5.0,
//         textFontWeight = FontWeight.normal,
//         textFontSize = 10.0,
//         borderColor,
//         borderRadius = 50.0,
//         borderWidth = 1.0,
//         disabled = false,
//         required onPressed}) => Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius),

//           /// for circular buttons
//           border: Border.all(
//             /// if border color is not passed set it to background color
//             color: borderColor == null ? backgroundColor : borderColor!,
//             width: borderColor == null ? 0 : borderWidth,
//           )),
//       child: MaterialButton(
//         minWidth: buttonWidth,
//         height: buttonHeight,
//         onPressed: onPressed,
//         elevation: 0,
//         disabledElevation: 0,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
//         highlightElevation: 0,
//         color: backgroundColor,
//         splashColor: (disabled || (CacheHelper.getData(key: 'isWindows')!))
//             ? Colors.transparent
//             : splashColor,
//         highlightColor: (CacheHelper.getData(key: 'isAndroid')!)
//             ? Colors.transparent
//             : Colors.black.withOpacity(0.1),
//         child: Text(text,
//             style: TextStyle(
//                 fontSize: textFontSize,
//                 fontWeight: textFontWeight,
//                 color: textColor)),
//       ),
//     );

class Button extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color backgroundColor;
  final Color? splashColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final FontWeight textFontWeight;
  final double? textFontSize;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final bool disabled;
  final String? imagePath;
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),

          /// for circular buttons
          border: Border.all(
            /// if border color is not passed set it to background color
            color: borderColor == null ? backgroundColor : borderColor!,
            width: borderColor == null ? 0 : borderWidth,
          )),
      child: MaterialButton(
        minWidth: buttonWidth,
        height: buttonHeight,
        onPressed: onPressed,
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


// // / ignore: must_be_immutable
// class Button extends StatelessWidget {
//   final String text;

//   /// text written in button
//   final Color textColor;

//   /// color of button text
//   final Color backgroundColor;

//   /// the width of the button
//   final double buttonWidth;

//   /// the height of the button
//   final double buttonHeight;

//   /// the fontWeight of the text as the weight.
//   final FontWeight? textFontWeight;

//   /// the font size
//   final double textFontSize;

//   /// the color of the border.
//   final Color? borderColor;

//   /// the function that should be executed when the button is pressed.
//   final VoidCallback onPressed;

//   /// the width of the boarded
//   final double _borderWidth = 1.0;

//   final bool disabled;

//   /// actual function of button when pressed

//   ///boarder radius of the button
//   double? boarderRadius = 50;
//   Button(
//       {super.key,
//       required this.text,
//       required this.textColor,
//       required this.backgroundColor,
//       required this.buttonWidth,
//       required this.buttonHeight,
//       required this.textFontSize,
//       this.textFontWeight,
//       this.borderColor,
//       this.boarderRadius,
//       this.disabled = false,
//       required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     final double fontScale = MediaQuery.of(context).textScaleFactor;
//     return SizedBox(
//       width: buttonWidth,
//       height: buttonHeight,
//       child: Material(
//         color: Colors.transparent,
//         child: Ink(
//           decoration: BoxDecoration(
//               color: backgroundColor,

//               ///button background color
//               borderRadius: BorderRadius.circular(boarderRadius!),

//               /// for circular buttons
//               border: Border.all(
//                 /// if border color is not passed set it to background color
//                 color: borderColor == null ? backgroundColor : borderColor!,
//                 width: borderColor == null ? 0 : _borderWidth,
//               )),
//           child: InkWell(
//             onTap: onPressed,

//             //splash effect is only present in android enviroment
//             splashColor: (!isAndroid || disabled)
//                 ? Colors.transparent
//                 : ColorManager.downvoteBlue,

//             /// color when the button is pressed
//             highlightColor:
//                 isAndroid ? Colors.transparent : Colors.black.withOpacity(0.1),

//             customBorder:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//             child: Center(
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: (textFontSize * fontScale),

//                   ///  ignore: prefer_if_null_operators
//                   fontWeight: textFontWeight == null
//                       ? FontWeight.normal
//                       : textFontWeight,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }