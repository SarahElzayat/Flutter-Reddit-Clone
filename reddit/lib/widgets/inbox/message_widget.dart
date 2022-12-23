/// @Author: Abdelaziz Salah
/// @date 20/12/2022
/// This widget is used to display a single message in the inbox screen.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../data/messages/messages_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../screens/inbox/single_message_screen.dart';
import '../../components/bottom_sheet.dart';
import '../../components/helpers/color_manager.dart';

class MessageWidget extends StatefulWidget {
  final MessageChildren myMessage;

  const MessageWidget({
    super.key,
    required this.myMessage,
  });

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  /// This variable is used to check if the message is opened or not.
  bool isOpened = false;

  void markAsReadMessage() async {
    setState(() {
      isOpened = true;
    });

    await DioHelper.patchData(
        // token: token,
        path: markMessageAsRead,
        data: {'id': widget.myMessage.id ?? '12'}).then((response) {
      if (response.statusCode == 200) {}
    }).catchError((error) {
      error = error as DioError;
    });
  }

  /// This method is used to open the message in a new screen.
  void prepareMessage() {
    // mark the message as read then navigate to the message screen.
    markAsReadMessage();

    Navigator.of(context)
        .pushNamed(SingleMessageScreen.routeName, arguments: widget.myMessage);
  }

  @override
  Widget build(BuildContext context) {
    final textFactor = MediaQuery.of(context).textScaleFactor;
    return ListTile(
        onTap: prepareMessage,
        isThreeLine: true,
        minLeadingWidth: 20,
        leading: Icon(
          Icons.mail_outline_rounded,
          color: !isOpened ? ColorManager.blue : ColorManager.grey,
          size: 20,
        ),
        title: Text(
          widget.myMessage.data!.postTitle ?? '',
          style: TextStyle(
              fontSize: 16 * textFactor,
              color: ColorManager.white,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Container(
          padding: const EdgeInsets.only(top: 4),
          height: 35,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.myMessage.data!.text ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14 * textFactor,
                    color: ColorManager.eggshellWhite,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.myMessage.data!.subredditName ?? '',
                      style: TextStyle(
                        fontSize: 12 * textFactor,
                        color: ColorManager.red,
                      ),
                    ),
                    Text(
                      widget.myMessage.data!.sendAt ?? '',
                      style: TextStyle(
                        fontSize: 12 * textFactor,
                        color: ColorManager.eggshellWhite,
                      ),
                    ),
                  ],
                )
              ]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            modalBottomSheet(
                context: context,
                title: 'Manage Notification',
                text: ['Don\'t get updates on this.'],
                selectedItem: 1,
                selectedIcons: [Icons.do_disturb_off]);
          },
        ));
  }
}
