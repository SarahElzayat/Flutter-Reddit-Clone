import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/data/notifications/notification_model.dart';
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
    await DioHelper.getData(path: notificationPoint).then(
      (response) {
        if (response.statusCode == 200) {
          NotificationModel allNotifications =
              NotificationModel.fromJson(response.data);
          for (NotificationItSelf notification in allNotifications.children!) {
            notifications.add(NotificationWidget(notification: notification));
          }

          ScaffoldMessenger.of(context).showSnackBar(
              responseSnackBar(message: response.statusMessage, error: false));
        }
      },
    ).catchError((err) {
      err = err as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: err.message, error: true));
    });
  }

  @override
  void initState() {
    // fetching the data
    fetch();
    super.initState();
  }

  List<NotificationWidget> notifications = [
    NotificationWidget(
        notification: NotificationItSelf(
            id: '1',
            isRead: false,
            link: 'fnkjas',
            sendAt: '2019-08-24T14:15:22',
            title: 'Hellooooooooooooooooooooooo',
            type: 'comment')),
    NotificationWidget(
        notification: NotificationItSelf(
            id: '1',
            isRead: false,
            link: 'fnkjas',
            sendAt: '2019-08-24T14:15:22',
            title: 'Hellooooooooooooooooooooooo2',
            type: 'comment')),
    NotificationWidget(
        notification: NotificationItSelf(
            id: '1',
            isRead: false,
            link: 'fnkjas',
            sendAt: '2019-08-24T14:15:22',
            title: 'Hellooooooooooooooooooooooo2',
            type: 'comment')),
    NotificationWidget(
        notification: NotificationItSelf(
            id: '1',
            isRead: false,
            link: 'fnkjas',
            sendAt: '2019-08-24T14:15:22',
            title: 'Hellooooooooooooooooooooooo2',
            type: 'comment')),
    NotificationWidget(
        notification: NotificationItSelf(
            id: '1',
            isRead: false,
            link: 'fnkjas',
            sendAt: '2019-08-24T14:15:22',
            title: 'Hellooooooooooooooooooooooo2',
            type: 'comment')),
    NotificationWidget(
        notification: NotificationItSelf(
            id: '1',
            isRead: false,
            link: 'fnkjas',
            sendAt: '2019-08-24T14:15:22',
            title: 'Hellooooooooooooooooooooooo2',
            type: 'comment')),
    NotificationWidget(
        notification: NotificationItSelf(
            id: '1',
            isRead: false,
            link: 'fnkjas',
            sendAt: '2019-08-24T14:15:22',
            title: 'Hellooooooooooooooooooooooo2',
            type: 'comment')),
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
