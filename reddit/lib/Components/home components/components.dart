///@author Sarah Elzayat
///@date 16/11/2022
///@description this file has some reusable components to use in the home screen
import 'package:flutter/material.dart';
import 'package:reddit/components/Helpers/color_manager.dart';

/// a reusable button with a dropdown list to use in drawer
/// @param [text] is the name of the list
/// @param [list] is the items to be displayed
/// @param [onPressed] is the function that controls the list
/// @param [isOpen] is the state of the list
Widget listButton(context, text, list, onPressed,isOpen) {
  return  Container(
      decoration: const BoxDecoration(
          border: BorderDirectional(
              end: BorderSide.none,
              start: BorderSide.none,
              top: BorderSide.none,
              bottom: BorderSide(width: 1, color: ColorManager.darkGrey))),
      child: Column(
        children: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: Theme.of(context).textTheme.displaySmall),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.keyboard_arrow_right_outlined,
                  color: ColorManager.eggshellWhite,
                )
              ],
            ),
          ),
          if (isOpen)
            ListView(
              padding: EdgeInsets.zero,
              children: list,
              shrinkWrap: true,
            ),
        ],
      ),
    
  );
}
