/// @author Abdelaziz Salah
/// @date 23-12-2022
/// This file contains the header bar for the inbox screen for web.

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';

class HeaderAppBarForInboxWeb extends StatelessWidget {
  final decideTheTypeHandler;
  final decideTheHeaderTypeHandler;
  final String type;
  final String headerType;
  const HeaderAppBarForInboxWeb(
      {super.key,
      required this.decideTheTypeHandler,
      required this.decideTheHeaderTypeHandler,
      required this.type,
      required this.headerType});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: ColorManager.greyColor,
      ),
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          /// the upper part which contains the inbox and sent
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          decideTheHeaderTypeHandler('Private');
                        },
                        child: Text(
                          'Send a Private Message',
                          style: TextStyle(
                              color: headerType == 'Private'
                                  ? ColorManager.blue
                                  : ColorManager.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          decideTheHeaderTypeHandler('Inbox');
                          decideTheTypeHandler('all');
                        },
                        child: Text(
                          'Inbox',
                          style: TextStyle(
                              color: headerType == 'Inbox'
                                  ? ColorManager.blue
                                  : ColorManager.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          decideTheTypeHandler('sent');
                          decideTheHeaderTypeHandler('Sent');
                        },
                        child: Text(
                          'Sent',
                          style: TextStyle(
                              color: headerType == 'Sent'
                                  ? ColorManager.blue
                                  : ColorManager.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
          ),

          /// the lower part which contains the unread messages and all messages.
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => decideTheTypeHandler('all'),
                  child: Text(
                    'All',
                    style: TextStyle(
                        color: type == 'all'
                            ? ColorManager.upvoteRed
                            : ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () => decideTheTypeHandler('unread'),
                  child: Text(
                    'Unread',
                    style: TextStyle(
                        color: type == 'unread'
                            ? ColorManager.upvoteRed
                            : ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () => decideTheTypeHandler('messages'),
                  child: Text(
                    'Messages',
                    style: TextStyle(
                        color: type == 'messages'
                            ? ColorManager.upvoteRed
                            : ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Comment Replies',
                    style: TextStyle(
                        color: type == 'comment'
                            ? ColorManager.upvoteRed
                            : ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Post Replies',
                    style: TextStyle(
                        color: type == 'post'
                            ? ColorManager.upvoteRed
                            : ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Username Mentions',
                    style: TextStyle(
                        color: type == 'mentions'
                            ? ColorManager.upvoteRed
                            : ColorManager.grey),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
