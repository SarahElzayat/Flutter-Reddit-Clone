/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen of the inbox.
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const routeName = '/inbox_screen_route';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Expanded(
      child: SizedBox(
        child: Center(
          child: Image.asset('assets/images/Empty.jpg'),
        ),
      ),
    ));
  }
}
