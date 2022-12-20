import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../inbox/messages_screen.dart';
import '../inbox/notifications_screen.dart';

class InboxScreen extends StatelessWidget {
  static const routeName = '/inbox_screen';

  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            indicatorColor: ColorManager.upvoteRed,
            tabs: [
              Tab(
                // text: 'hello',
                // icon: Icon(Icons.abc),
                child: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'Messages',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [NotificationScreen(), MessagesScreen()],
        ),
      ),
    );
  }
}
