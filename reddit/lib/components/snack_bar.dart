///@author: Yasmine Ghanem
///@date: 10/12/2022
///functions that return error and success snack bar
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///@param [message] the message shown in the snack bar
///@param [error] specifies whether the snack bar is intended to show error message
SnackBar responseSnackBar({message, error = true}) => SnackBar(
    behavior: SnackBarBehavior.floating,
    width: 90.w,
    padding: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    backgroundColor: ColorManager.darkGrey,
    content: Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: (error) ? ColorManager.red : ColorManager.green,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
          width: 15,
          height: 50,
        ),
        const SizedBox(width: 10),
        //insert reddit image
        Text(message,
            style: TextStyle(
              color: ColorManager.white,
              fontSize: 16.sp,
            ))
      ],
    ));
