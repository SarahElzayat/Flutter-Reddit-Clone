///@author Sarah Elzayat
///@date 16/11/2022
///@description this file has some reusable components to use in the home screen
import 'package:flutter/material.dart';
import 'package:reddit/Screens/create_community_screen/create_community_screen.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/Screens/to_be_done_screen.dart';

/// a reusable button with a dropdown list to use in drawer
/// @param [text] is the name of the list
/// @param [list] is the items to be displayed
/// @param [onPressed] is the function that controls the list
/// @param [isOpen] is the state of the list
Widget listButton(context, text, list, onPressed, isOpen,
    {isCommunity = false, isModerating = false}) {
  return Container(
    decoration: const BoxDecoration(
        border: BorderDirectional(
            end: BorderSide.none,
            start: BorderSide.none,
            top: BorderSide.none,
            bottom: BorderSide(width: 2, color: ColorManager.darkGrey))),
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
              Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold)),
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (isCommunity)
              genericTextButton(context, Icons.add, 'Create a community',
                  const CreateCommunityScreen()),
            if (isModerating)
              genericTextButton(
                  context,
                  Icons.shield_outlined,
                  'Mod Feed',
                  const ToBeDoneScreen(
                    text: 'Mod Feed',
                  )),
            if (isModerating)
              genericTextButton(
                  context,
                  Icons.queue,
                  'Mod Queue',
                  const ToBeDoneScreen(
                    text: 'Mod Queue',
                  )),
            if (isModerating)
              genericTextButton(
                  context,
                  Icons.mail_outline_rounded,
                  'Modmail',
                  const ToBeDoneScreen(
                    text: 'Modmail',
                  )),
            if (isCommunity)
              genericTextButton(
                  context,
                  Icons.dynamic_feed_outlined,
                  'Custom Feeds',
                  const ToBeDoneScreen(
                    text: 'Custom Feeds',
                  )),
            ListView(
              padding: const EdgeInsets.only(left: 10),
              children: list,
              shrinkWrap: true,
            ),
          ]),
      ],
    ),
  );
}

/// resuable text button with a prefix icon to navigate to another route
Widget genericTextButton(context, icon, text, route) => TextButton(
    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => route,
        )),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: ColorManager.eggshellWhite,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        )
      ],
    ));
