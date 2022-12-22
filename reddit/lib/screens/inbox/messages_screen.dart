import 'package:flutter/material.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
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
  String after = '';
  String before = '';

  final scroller = ScrollController();

  List<MessageWidget> messages = [];

  void _scrollListener() {
    if (scroller.offset == scroller.position.maxScrollExtent) {
      fetch();
    }
  }

  void fetch() async {
    await DioHelper.getData(
        path: messagesPoint, query: {'after': after, 'limit': 2}).then(
      (response) {
        if (response.statusCode == 200) {
          MessageModel msgs = MessageModel.fromJson(response.data);

          for (MessageChildren msg in msgs.children!) {
            setState(() {
              messages.add(MessageWidget(
                myMessage: msg,
              ));
            });
            after = msgs.after ?? '';
          }
        }
      },
    ).catchError((err) {
      logger.w(err);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //  here we should send a request to the backend to get the messages
    scroller.addListener(_scrollListener);
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? Center(
            child: Image.asset('assets/images/Empty.jpg'),
          )
        : ListView.builder(
            controller: scroller,
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
