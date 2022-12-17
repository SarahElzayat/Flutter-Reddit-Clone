import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';

class SingleMessageScreen extends StatelessWidget {
  static const routeName = '/single_message_screen';
  const SingleMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fontScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reply to message'),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Post',
                style: TextStyle(
                    color: ColorManager.blue, fontSize: 18 * fontScale),
              ))
        ],
      ),
      body: Center(child: Text('messageDetails')),
    );
  }
}
