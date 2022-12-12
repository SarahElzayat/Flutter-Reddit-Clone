import 'package:flutter/material.dart';
import 'package:reddit/components/default_text_field.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/widgets/settings/bottom_buttons.dart';
import 'package:reddit/widgets/settings/settings_app_bar.dart';

class UpdateEmailAddressScreen extends StatelessWidget {
  static const routeName = 'update_email_address_screen_route';
  UpdateEmailAddressScreen({super.key});

  final _myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: const SettingsAppBar(title: 'Update email address'),
      body: Form(
        key: _myKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mediaQuery.size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundColor: ColorManager.upvoteRed,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          /// TODO: here we will need to use cubit
                          children: const [
                            Text(
                              'UserName',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Email of the user')
                          ],
                        )
                      ],
                    ),
                  ),
                  const DefaultTextField(labelText: 'New email address'),
                  const DefaultTextField(
                    labelText: 'Reddit password',
                    isPassword: true,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: ColorManager.upvoteRed),
                      ))
                ],
              ),
              BottomButtons(
                string1: 'Cancel',
                string2: 'Save',
                handler1: () {
                  navigator.pop();
                },
                handler2: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
