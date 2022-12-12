///@author Yasmine Ghanem
///@date 06/12/2022

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/scheduler.dart';

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
              textFontSize: 14,
              buttonHeight: 50,
              buttonWidth: 80,
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

///@param [context] mod tools screen context
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
                      splashColor: ColorManager.lightGrey.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Button(
                      onPressed: () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(
                              context,
                              AppRouter.onGenerateRoute(const RouteSettings(
                                  name: '/mod_tools_screen')));
                        });
                      },
                      splashColor: ColorManager.white.withOpacity(0.5),
                      buttonHeight: 5.h,
                      buttonWidth: 35.w,
                      text: 'LEAVE',
                      textFontSize: 16.sp,
                    ),
                  ],
                )
              ],
            )));

dialog(context) => SchedulerBinding.instance.addPostFrameCallback((_) {
      showDialog(
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
                            onPressed: () =>
                                // SchedulerBinding.instance
                                // .addPostFrameCallback((_) {
                                Navigator.push(
                                    context,
                                    AppRouter.onGenerateRoute(
                                        const RouteSettings(
                                            name: '/mod_tools_screen'))),
                            // }),
                            buttonHeight: 5.h,
                            buttonWidth: 35.w,
                            text: 'LEAVE',
                            textFontSize: 16.sp,
                          ),
                        ],
                      )
                    ],
                  )));
    });

///@param [text]
///@param [isSwitched]
///@param [toggle]
Widget rowSwitch(text, isSwitched, toggle) => Row(
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

AppBar userManagementAppBar(context, text, function, enable) => AppBar(
      backgroundColor: ColorManager.darkGrey,
      title: Text(text),
      leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Button(
              onPressed: enable ? function : () {},
              text: 'ADD',
              textFontSize: 16.sp,
              buttonHeight: 20,
              buttonWidth: 80,
              textColor: enable ? ColorManager.blue : ColorManager.darkBlue,
              backgroundColor: ColorManager.darkGrey,
              splashColor: ColorManager.grey,
              disabled: enable,
              borderRadius: 4.0),
        )
      ],
    );
