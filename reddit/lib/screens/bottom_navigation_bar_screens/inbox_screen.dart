/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen of the inbox.
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});
  static const routeName = '/inbox_screen_route';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'INBOX SCREEN',
        style: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
}
