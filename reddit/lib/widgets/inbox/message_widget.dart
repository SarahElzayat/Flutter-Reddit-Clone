import 'package:flutter/material.dart';
import 'package:reddit/main.dart';
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
    return InkWell(
      onTap: () {
        setState(() {
          isOpened = true;

          // here we should navigate to the message.
        });
      },
      child: ListTile(
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
              fontSize: 14 * textFactor,
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
                    fontSize: 12 * textFactor,
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
        trailing: PopupMenuButton(
          onSelected: (option) {},
          itemBuilder: (context) {
            return [
              // const PopupMenuItem(
              //   value: FilterOptions.all,
              //   child: Text('All'),
              // ),
              // const PopupMenuItem(
              //   value: FilterOptions.isFavorites,
              //   child: Text('Only Favorite'),
              // ),
            ];
          },
        ),
      ),
    );
  }
}
