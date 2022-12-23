import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/comments/add_comment_screen.dart';
import '../../data/messages/messages_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/inbox/message_widget.dart';

class MessagesScreen extends StatefulWidget {
  static const routeName = '/messages_screen';
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<MessageWidget> messages = [
    MessageWidget(
        myMessage: MessageChildren(
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
          logger.i(response.data);
          MessageModel msgs = MessageModel.fromJson(response.data);
          for (MessageChildren msg in msgs.children!) {
            print(msg == null);
            setState(() {
              messages.add(MessageWidget(
                myMessage: msg,
              ));
            });
          }
        }
      },
    ).catchError((err) {
      err = err as DioError;
    });
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? Expanded(
            child: SizedBox(
              child: Center(
                child: Image.asset('assets/images/Empty.jpg'),
              ),
            ),
          )
        : ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Card(
                color: ColorManager.black,
                child: messages[index],
              );
            },
          );
  }
}
