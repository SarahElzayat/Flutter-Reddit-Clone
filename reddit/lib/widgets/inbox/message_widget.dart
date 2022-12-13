import 'package:flutter/material.dart';
import '../../components/bottom_sheet.dart';
import '../../components/helpers/color_manager.dart';

class MessageWidget extends StatefulWidget {
  final messageTitle;
  final messageBody;
  final time;
  final subredditName;

  const MessageWidget(
      {super.key,
      required this.messageBody,
      required this.messageTitle,
      required this.subredditName,
      required this.time});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    final textFactor = MediaQuery.of(context).textScaleFactor;
    return ListTile(
        onTap: () {
          setState(() {
            isOpened = true;
          });
        },
        isThreeLine: true,
        minLeadingWidth: 20,
        leading: Icon(
          Icons.mail_outline_rounded,
          color: !isOpened ? ColorManager.blue : ColorManager.grey,
          size: 20,
        ),
        title: Text(
          widget.messageTitle,
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
                  widget.messageBody,
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
                      widget.subredditName,
                      style: TextStyle(
                        fontSize: 12 * textFactor,
                        color: ColorManager.red,
                      ),
                    ),
                    Text(
                      widget.time,
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
