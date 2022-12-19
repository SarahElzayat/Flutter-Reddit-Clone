import 'package:flutter/material.dart';
import 'package:reddit/widgets/settings/settings_app_bar.dart';
import 'package:reddit/widgets/sign_in_and_sign_up_widgets/app_bar.dart';

class DiaLog extends StatelessWidget {
  static const routeName = '/dialog_route';
  const DiaLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: ElevatedButton(
                child: const Text('Show',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                onPressed: () {})));
  }
}
