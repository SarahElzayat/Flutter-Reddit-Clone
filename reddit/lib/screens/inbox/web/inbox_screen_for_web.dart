/// @author Abdelaziz Salah
/// @date 23-12-2022
/// This file contains the inbox screen for web.
/// which contains the unread messages and the messages and where
/// you can also send a private message.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/data/messages/messages_model.dart';
import 'package:reddit/screens/inbox/web/message_template_for_web.dart';
import 'package:reddit/widgets/inbox/web/header_for_inbox.dart';

import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';

class InboxScreenforWeb extends StatefulWidget {
  static const routeName = '/inbox_web';
  const InboxScreenforWeb({super.key});

  @override
  State<InboxScreenforWeb> createState() => _InboxScreenStateforWeb();
}

class _InboxScreenStateforWeb extends State<InboxScreenforWeb> {
  List<MessageTemplateWidgetForWeb> messages = [
    MessageTemplateWidgetForWeb(
        isEven: false,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: true,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: false,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: true,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: false,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: true,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: false,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: true,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: false,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: true,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
    MessageTemplateWidgetForWeb(
        isEven: false,
        messageChildren: MessageChildren(
          id: '123',
          data: MessageChild(
            text:
                'November us? We\'re the Snoosletter team, here to wish you a happy November! Looking back through the coming days',
            postTitle: 'The mod Snoosletter is Thankful for you This November',
            subredditName: 'u/ModNewsLetter',
            commentId: '234',
            isRead: false,
            isReceiverUser: false,
            isSenderUser: true,
            numOfComments: 22,
            postId: 'fdd',
            postOwner: 'u/ModNewsLetter',
            receiverUsername: 'zizo',
            sendAt: '2020',
            senderUsername: 'zizo',
            subject: 'The mod Snoosletter is Thankful for you This November',
            type: 'comment',
            vote: 32,
          ),
        )),
  ];

  void fetch() async {
    await DioHelper.getData(path: messagesPoint).then(
      (response) {
        if (response.statusCode == 200) {
          MessageModel msgs = MessageModel.fromJson(response.data);
          for (MessageChildren msg in msgs.children!) {
            // here we should add the message to the list
            messages.add(MessageTemplateWidgetForWeb(
              isEven: ((messages.length + 1) % 2 ==
                  0), // because we are going to add a new message.
              messageChildren: msg,
            ));
          }
        }
      },
    ).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        responseSnackBar(
          message: 'err',
        ),
      );
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: homeAppBar(context, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQuery.size.height,
          child: Column(
            children: [
              // this is always constant for any screen
              const HeaderAppBarForInboxWeb(),
              // the header which contains [send prvt msg, inbox, sent]
              SizedBox(
                height: mediaQuery.size.height * 0.8,
                child: Scaffold(
                  body: Container(
                    height: mediaQuery.size.height * 0.9,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListView(
                        children: messages.map((msg) {
                      return msg;
                    }).toList()),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
