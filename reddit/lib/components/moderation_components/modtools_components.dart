///@author Yasmine Ghanem
///@date 06/12/2022

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/screens/moderation/mod_tools.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///@param [context]
///@param [title]
///@param [enabledButton]
///@param [isChanged]
moderationAppBar(context, title, enabledButton, isChanged) => AppBar(
      elevation: 0,
      leading: IconButton(
          onPressed: () {
            moderationDialog(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24.sp,
          )),
      backgroundColor: ColorManager.darkGrey,
      title: Text(title, style: TextStyle(fontSize: 18.sp)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Button(
              onPressed: isChanged
                  ? () {}
                  : () {
                      enabledButton();
                    },
              text: 'Save',
              textFontSize: 16.sp,
              buttonHeight: 5.h,
              buttonWidth: 6.w,
              textColor: isChanged
                  ? ColorManager.darkBlue
                  : ColorManager.darkBlueColor,
              backgroundColor: ColorManager.darkGrey,
              splashColor: ColorManager.grey,
              disabled: isChanged,
              borderRadius: 4.0),
        )
      ],
    );

///@param [context]
moderationDialog(context) => showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
              backgroundColor: ColorManager.darkGrey,
              content: SizedBox(
                height: 10.h,
                width: 90.w,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Leave without saving',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: ColorManager.eggshellWhite)),
                      const Spacer(),
                      const Text('you cannot undo this action')
                    ]),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onPressed: () => Navigator.pop(context),
                      buttonHeight: 5.h,
                      buttonWidth: 35.w,
                      text: 'CANCEL',
                      textFontSize: 16.sp,
                      textColor: ColorManager.lightGrey,
                      backgroundColor: ColorManager.grey,
                      splashColor: ColorManager.lightGrey,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Button(
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ModTools())),
                      buttonHeight: 5.h,
                      buttonWidth: 35.w,
                      text: 'LEAVE',
                      textFontSize: 16.sp,
                    ),
                  ],
                )
              ],
            )));

///@param [text]
///@param [isSwitched]
///@param [toggle]
RowSwitch(text, isSwitched, toggle) => Row(
      children: [
        Text(text),
        const Spacer(),
        FlutterSwitch(
          key: const Key('create_community_switch'),
          value: isSwitched,
          onToggle: toggle,
          width: 15.w,
          height: 4.h,
          toggleSize: 3.h,
          inactiveColor: ColorManager.darkGrey,
          activeColor: ColorManager.darkBlueColor,
        ),
      ],
    );
