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
  List<MessageWidget> messages = [];

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
