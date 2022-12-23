/// @author Abdelaziz Salah
/// @date 23-12-2022
/// This file contains the message template for web.

import 'package:flutter/material.dart';
import '/components/helpers/color_manager.dart';
import '/data/messages/messages_model.dart';

class MessageTemplateWidgetForWeb extends StatefulWidget {
  /// this is the message object by which we can show the data.
  MessageChildren messageChildren;

  /// this is a bool by which we can decide the background color of the message.
  final bool isEven;

  MessageTemplateWidgetForWeb({
    super.key,
    required this.messageChildren,
    required this.isEven,
  });

  @override
  State<MessageTemplateWidgetForWeb> createState() =>
      _MessageTemplateWidgetForWebState();
}

class _MessageTemplateWidgetForWebState
    extends State<MessageTemplateWidgetForWeb> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.isEven ? ColorManager.darkGrey : ColorManager.grey,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            child: Text(widget.messageChildren.data!.postTitle ?? ''),
          ),
          Container(
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 8),
                    child: RichText(
                      textScaleFactor: mediaQuery.textScaleFactor,
                      text: TextSpan(children: [
                        const TextSpan(
                            text: 'from ',
                            style: TextStyle(color: ColorManager.upvoteRed)),
                        TextSpan(
                            text:
                                '/u/${widget.messageChildren.data!.senderUsername}',
                            style: const TextStyle(
                                color: ColorManager.darkBlueColor)),
                        const TextSpan(
                            text: ' via ',
                            style: TextStyle(color: ColorManager.upvoteRed)),
                        TextSpan(
                            text:
                                '/r/${widget.messageChildren.data!.subredditName} ',
                            style: const TextStyle(
                                color: ColorManager.darkBlueColor)),
                        TextSpan(
                            text:
                                ' sent ${widget.messageChildren.data!.sendAt} ago ',
                            style: const TextStyle(
                                color: ColorManager.greyColor,
                                fontSize: 11,
                                fontWeight: FontWeight.normal)),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                    child: Text(widget.messageChildren.data!.text ?? ''),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text('Permalink',
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                ))),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Delete',
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                ))),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Report',
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                ))),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Mark Unread',
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                ))),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Reply',
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                ))),
                      ]),
                ],
              ))
        ],
      ),
    );
  }
}
