import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/snack_bar.dart';
import '../../data/notifications/notification_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../comments/add_comment_screen.dart';
import '../../widgets/inbox/notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification_screen';
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int after = 0;
  int before = 0;

  final scroller = ScrollController();
  List<NotificationWidget> notifications = [];

  @override
  void dispose() {
    // TODO: implement dispose
    scroller.dispose();
    super.dispose();
  }

  /// this is a utility function used to fetch the notifications.
  void fetch() async {
    await DioHelper.getData(path: notificationPoint, query: {'after': after})
        .then(
      (response) {
        logger.e(response.data);
        if (response.statusCode == 200) {
          NotificationModel allNotifications =
              NotificationModel.fromJson(response.data);
          after = allNotifications.after ?? 0;
          for (NotificationItSelf notification in allNotifications.children!) {
            setState(() {
              notifications.add(NotificationWidget(notification: notification));
            });
          }
        }
      },
    ).catchError((err) {
      // err = err as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: err, error: true));
    });
  }

  void _scrollListener() {
    if (scroller.offset == scroller.position.maxScrollExtent) {
      fetch();
    }
  }

  @override
  void initState() {
    // fetching the data
    scroller.addListener(_scrollListener);
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return notifications.isEmpty
        ? Center(
            child: Image.asset('assets/images/Empty.jpg'),
          )
        : ListView.builder(
            controller: scroller,
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
