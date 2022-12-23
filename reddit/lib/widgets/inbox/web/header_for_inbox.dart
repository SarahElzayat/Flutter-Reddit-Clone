/// @author Abdelaziz Salah
/// @date 23-12-2022
/// This file contains the header bar for the inbox screen for web.

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';

class HeaderAppBarForInboxWeb extends StatelessWidget {
  const HeaderAppBarForInboxWeb({super.key});

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
                        child: const Text(
                          'Send a Private Message',
                          style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Inbox',
                          style: TextStyle(
                              color: ColorManager.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Sent',
                          style: TextStyle(
                              color: ColorManager.grey,
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
                  onPressed: () {},
                  child: const Text(
                    'All',
                    style: TextStyle(color: ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Unread',
                    style: TextStyle(color: ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Messages',
                    style: TextStyle(color: ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Comment Replies',
                    style: TextStyle(color: ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Post Replies',
                    style: TextStyle(color: ColorManager.grey),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Username Mentions',
                    style: TextStyle(color: ColorManager.grey),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
