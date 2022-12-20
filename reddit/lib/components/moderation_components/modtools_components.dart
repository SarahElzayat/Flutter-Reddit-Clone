///@author Yasmine Ghanem
///@date 06/12/2022

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/router.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:reddit/screens/moderation/user_management_screens/add_approved_user.dart';
import 'package:reddit/screens/moderation/user_management_screens/add_banned_user.dart';
import 'package:reddit/screens/moderation/user_management_screens/add_muted_user.dart';
import 'package:reddit/screens/moderation/user_management_screens/invite_moderator.dart';
import 'package:reddit/widgets/moderation/queues_modtools.dart';
import 'package:reddit/widgets/moderation/user_management.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/scheduler.dart';

///@param [selectedItem] the selected tile from the mod tools in web
UserManagementWidget userManagementWidget(ModToolsSelectedItem selectedItem) {
  String finalTitle = (selectedItem == ModToolsSelectedItem.banned)
      ? 'Banned users'
      : (selectedItem == ModToolsSelectedItem.muted)
          ? 'Muted users'
          : (selectedItem == ModToolsSelectedItem.approved)
              ? 'Approved users'
              : 'Moderators';

  UserManagement finalType = (selectedItem == ModToolsSelectedItem.banned)
      ? UserManagement.banned
      : (selectedItem == ModToolsSelectedItem.muted)
          ? UserManagement.muted
          : (selectedItem == ModToolsSelectedItem.approved)
              ? UserManagement.approved
              : UserManagement.moderator;

  return UserManagementWidget(screenTitle: finalTitle, type: finalType);
}

///@param [selectedItem] the selected tile from the mod tools in web
QueuesWidget queuesWidget(ModToolsSelectedItem selectedItem) {
  String finalTitle = (selectedItem == ModToolsSelectedItem.spam)
      ? 'Spam'
      : (selectedItem == ModToolsSelectedItem.edited)
          ? 'Edited'
          : 'Unmoderated';

  return QueuesWidget(title: finalTitle);
}

///@param [context] context of the screen
///@param [title] title of the app bar
///@param [enabledButton] function of the button in appbar when enabled
///@param [isChanged] bool that checks if anything changed to enable or disable button
moderationAppBar(context, title, onPressed, isChanged) => AppBar(
      elevation: 0,
      leading: IconButton(
          onPressed: isChanged
              ? () => moderationDialog(context)
              : () => Navigator.pop(context),
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
              onPressed: isChanged ? onPressed : () {},
              text: 'Save',
              textFontSize: 14,
              buttonHeight: 50,
              buttonWidth: 80,
              textColor: isChanged ? ColorManager.blue : ColorManager.darkBlue,
              backgroundColor: ColorManager.darkGrey,
              splashColor: ColorManager.grey.withOpacity(0.5),
              disabled: isChanged ? false : true,
              borderRadius: 4.0),
        )
      ],
    );

///@param [context]
///@param [type]
userManagementAction(context, type, onPressed) => showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
        builder: ((context, setState) => AlertDialog(
              backgroundColor: ColorManager.darkGrey,
              content: SizedBox(
                  width: 40.w,
                  height: 70.h,
                  child: (type == UserManagement.banned)
                      ? AddBannedUser()
                      : (type == UserManagement.muted)
                          ? AddMutedUser()
                          : (type == UserManagement.approved)
                              ? AddApprovedUser()
                              : InviteModerator()),
              actions: <Widget>[
                Container(
                  height: 10.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: ColorManager.bottomWindowGrey,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.zero, bottom: Radius.circular(5))),
                  child: Row(
                    children: [
                      const Spacer(),
                      Button(
                          text: 'Cancel',
                          textColor: ColorManager.eggshellWhite,
                          backgroundColor: ColorManager.grey,
                          textFontWeight: FontWeight.bold,
                          buttonWidth: 7.w,
                          buttonHeight: 5.h,
                          textFontSize: 13.sp,
                          onPressed: () => Navigator.pop(context, 'Cancel')),
                      SizedBox(width: 1.w),
                      Button(
                          text: (type == UserManagement.banned)
                              ? 'Ban user'
                              : (type == UserManagement.muted)
                                  ? 'Mute user'
                                  : (type == UserManagement.approved)
                                      ? 'Approve user'
                                      : 'Invite user',
                          textColor: ColorManager.deepDarkGrey,
                          backgroundColor: ColorManager.eggshellWhite,
                          buttonWidth: 14.w,
                          buttonHeight: 5.h,
                          textFontSize: 13.sp,
                          textFontWeight: FontWeight.bold,
                          onPressed: onPressed),
                      SizedBox(width: 1.w)
                    ],
                  ),
                )
              ],
            ))));

///@param [context] mod tools screen context
///shows the dialog for action button in web
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
                        Navigator.pop(context);
                        Navigator.pop(context);
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

///@param [text] text displayed in row
///@param [isSwitched] bool that indicates whether switch is on or off
///@param [toggle] function to toggle the switch
Widget rowSwitch(text, isSwitched, toggle) => Row(
      children: [
        Text(text),
        const Spacer(),
        FlutterSwitch(
          key: const Key('create_community_switch'),
          value: isSwitched,
          onToggle: toggle,
          width: 60,
          height: 32,
          toggleSize: 31,
          inactiveColor: ColorManager.darkGrey,
          activeColor: ColorManager.darkBlueColor,
        ),
      ],
    );

///@param [context] user management screen context
///@param [text] the title of the appbar
///@param [function] function of button in actions appbar
///@param [enable] bool to indicate whether button is enabled of not for validation
AppBar userManagementAppBar(context, text, function, enable) => AppBar(
      elevation: (kIsWeb) ? 0 : null,
      backgroundColor: ColorManager.darkGrey,
      title: Text(text),
      leading: (!kIsWeb)
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context))
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: (!kIsWeb)
              ? Button(
                  onPressed: enable ? function : () {},
                  text: 'ADD',
                  textFontSize: 16.sp,
                  buttonHeight: 20,
                  buttonWidth: 80,
                  textColor: enable ? ColorManager.blue : ColorManager.darkBlue,
                  backgroundColor: ColorManager.darkGrey,
                  splashColor: ColorManager.grey,
                  disabled: enable,
                  borderRadius: 4.0)
              : IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close)),
        )
      ],
    );
