// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';

import '../../components/Button.dart';
import '../../components/helpers/color_manager.dart';

class SubredditOpion extends StatelessWidget {
  SubredditOpion({
    Key? key,
  }) : super(key: key);

  final List<String> itemsText = [
    'Mute',
    'Change user flair',
    'Contact mods',
    'Manage Mod Notification'
  ];
  final List<IconData> itemsIcons = [
    Icons.volume_mute,
    Icons.sell_outlined,
    Icons.mail_outline,
    Icons.notifications_none_outlined
  ];

  @override
  Widget build(BuildContext context) {
    final subredditCubit = SubredditCubit.get(context);
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return BlocBuilder<SubredditCubit, SubredditState>(
      buildWhen: (previous, current) => (current is leaveSubredditState),
      builder: (context, state) {
        return PopupMenuButton(
            itemBuilder: (_) => [
                  if (subredditCubit.subreddit.isModerator!)
                    PopupMenuItem(
                        onTap: () {
                          Future.delayed(
                            const Duration(seconds: 0),
                            () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: ColorManager.grey,
                                insetPadding: EdgeInsets.zero,
                                content: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Are you sure you want to leave the r/${subredditCubit.subredditName} community',
                                        style: TextStyle(
                                            fontSize: 17 *
                                                mediaQuery.textScaleFactor),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Button(
                                      onPressed: () {
                                        navigator.pop();
                                        return;
                                      },
                                      text: ('Cancel'),
                                      textColor: ColorManager.white,
                                      backgroundColor: Colors.transparent,
                                      buttonWidth: mediaQuery.size.width * 0.3,
                                      buttonHeight: 40,
                                      textFontSize: 15,
                                      splashColor: Color.fromARGB(40, 0, 0, 0)),
                                  Button(
                                      onPressed: () {
                                        subredditCubit.leaveCommunity();
                                        navigator.pop();
                                      },
                                      text: ('Leave'),
                                      textColor: ColorManager.white,
                                      backgroundColor: Colors.red,
                                      buttonWidth: mediaQuery.size.width * 0.3,
                                      buttonHeight: 40,
                                      textFontSize: 15,
                                      splashColor: Color.fromARGB(40, 0, 0, 0))
                                ],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(Icons.remove_circle),
                            ),
                            Text(
                              'Leave',
                              style: TextStyle(
                                  fontSize: 15 * mediaQuery.textScaleFactor),
                            )
                          ],
                        )),
                  for (int index = 0; index < itemsIcons.length; index++)
                    PopupMenuItem(
                        child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(itemsIcons[index])),
                        Expanded(
                          child: Text(
                            (index == 0)
                                ? '${itemsText[index]} r/${subredditCubit.subreddit.nickname}'
                                : itemsText[index],
                            style: TextStyle(
                                fontSize: 15 * mediaQuery.textScaleFactor),
                          ),
                        )
                      ],
                    )),
                ]);
      },
    );
  }
}
