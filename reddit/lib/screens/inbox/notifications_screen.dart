import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/widgets/inbox/notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification_screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationWidget> notifications = [
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'comment',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
    const NotificationWidget(
      bodyContent: 'helloMyBrotherWelcomHere',
      date: '28d',
      subredditName: 'r/TestSW',
      type: 'post',
      userImage: 'fdsa',
      userWhoReplied: 'Abdelaziz',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return notifications.isEmpty
        ? Expanded(
            child: SizedBox(
              child: Center(
                child: Image.asset('assets/images/Empty.jpg'),
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                color: ColorManager.black,
                child: notifications[index],
              );
            },
            itemCount: notifications.length,
          );
  }
}
