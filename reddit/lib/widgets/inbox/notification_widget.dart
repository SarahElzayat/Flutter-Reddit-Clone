import 'package:flutter/material.dart';
import 'package:reddit/components/bottom_sheet.dart';
import 'package:reddit/screens/inbox/single_notification_screen.dart';
import '../../components/helpers/color_manager.dart';

class NotificationWidget extends StatelessWidget {
  final String userImage;
  final date;
  final bodyContent;
  final userWhoReplied;
  final subredditName;
  final type;
  const NotificationWidget(
      {super.key,
      required this.userImage,
      required this.type,
      required this.date,
      required this.subredditName,
      required this.userWhoReplied,
      required this.bodyContent});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final fontScale = mediaQuery.textScaleFactor;
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(SignleNotificationScreen.routeName);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      horizontalTitleGap: 10,
      leading: const CircleAvatar(
        backgroundColor: ColorManager.upvoteRed,
        // child: userImage.isEmpty
        //     ? Image.network(unknownAvatar)
        //     : Image.network(userImage),
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
              selectedItem: 0,
              selectedIcons: [
                Icons.visibility_off,
                Icons.notifications_off_outlined
              ]);
        },
      ),

      // PopupMenuButton(
      //   onSelected: (option) {},
      //   itemBuilder: (context) {
      //     return [
      //       /// TODO: add here the pop items
      //       // const PopupMenuItem(
      //       //   value: FilterOptions.all,
      //       //   child: Text('All'),
      //       // ),
      //       // const PopupMenuItem(
      //       //   value: FilterOptions.isFavorites,
      //       //   child: Text('Only Favorite'),
      //       // ),
      //     ];
      //   },
      // ),
    );
  }
}
