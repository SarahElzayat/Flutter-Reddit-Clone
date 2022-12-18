import 'package:flutter/material.dart';

class SignleNotificationScreen extends StatelessWidget {
  static const routeName = '/single_notification_screen';

  const SignleNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('subreddit name'),
      ),
      body: const Center(child: Text('Notifications Details')),
    );
  }
}
