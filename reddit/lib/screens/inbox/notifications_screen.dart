import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/widgets/inbox/notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification_screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void fetch() async {
    print('fetching notifications');
    await DioHelper.getData(path: notificationPoint).then(
      (response) {
        if (response.statusCode == 200) {
          print('success');

          /// TODO : add here the notificatios which were fetched to the notifications list.
          print(response.data);
        }
      },
    ).catchError((err) {
      err = err as DioError;
      print('error');
      print(err.response!.data);
    });
  }

  @override
  void initState() {
    // fetching the data
    fetch();
    super.initState();
  }

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
