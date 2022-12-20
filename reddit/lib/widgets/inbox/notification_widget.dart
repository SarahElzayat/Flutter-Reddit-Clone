import 'package:flutter/material.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/cubit/user_profile/cubit/user_profile_cubit.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/posts/post_screen.dart';
import '../../components/bottom_sheet.dart';
import '../../data/notifications/notification_model.dart';
import '../../screens/inbox/single_notification_screen.dart';
import '../../components/helpers/color_manager.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationItSelf notification;
  // final deleteThis;
  const NotificationWidget({
    super.key,
    required this.notification,
    // required this.deleteThis
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  String setItem = '';
  bool delete = false;

  /// this is a utility function used to mark certain notification as hidden
  void hideTheNotifcation() async {
    await DioHelper.patchData(
            path: '$hideNotification/${widget.notification.id}',
            data: {},
            token: token)
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Message has been sent 😊', error: false));
      }
    }).onError((error, stackTrace) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: '${error.response} 😔'));
      print(error.response);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final fontScale = mediaQuery.textScaleFactor;
    return ListTile(
      onTap: () {
        if (widget.notification.type == 'Comment') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PostScreen(
              post: PostModel(id: widget.notification.postId!),
            );
          }));
        } else if (widget.notification.type == 'Follow') {
          // UserProfileCubit.get(context).showPopupUserWidget(
          //     context, widget.notification.followingUsername!);
        }
        Navigator.of(context).pushNamed(SignleNotificationScreen.routeName);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      horizontalTitleGap: 10,
      leading: const CircleAvatar(
        backgroundColor: ColorManager.upvoteRed,
        child: widget.notification.photo == null
            ? Image.network(unknownAvatar)
            : Image.network('$baseUrl/${widget.notification.photo!}'),

      ),
      title: Row(
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: mediaQuery.size.width - 150,
              child: Text(
                '$userWhoReplied replied to your $type in $subredditName $date',
                softWrap: true,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 16 * fontScale,
                ),
              ),
            ),
          ),
        ],
      ),
      subtitle: Text(
        bodyContent,
        style:
            TextStyle(color: ColorManager.greyColor, fontSize: 13 * fontScale),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          modalBottomSheet(
              context: context,
              title: 'Manage Notification',
              text: [
                'Hide this notification',
                'Disable updates from this community',
                'Turn off this notification'
              ],
              selectedItem: 'Disable updates from this community',
              selectedIcons: [
                Icons.visibility_off,
                Icons.notifications_off_outlined,
                Icons.notifications_off_outlined,
              ],
              unselectedIcons: [
                Icons.visibility_off,
                Icons.notifications_off_outlined,
                Icons.notifications_off_outlined,
              ],
              items: [
                'Hide this notification',
                'Disable updates from this community',
                'Turn off this notification'
              ]);
        },
      ),
    );
  }
}
