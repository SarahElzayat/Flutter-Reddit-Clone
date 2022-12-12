/// @author Abdelaziz Salah
/// @date 12/12/2022
/// this file contains the screen of the change password
import 'package:flutter/material.dart';
import 'package:reddit/components/default_text_field.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/main.dart';
import 'package:reddit/widgets/settings/bottom_buttons.dart';
import '../../widgets/settings/header_contains_avatar.dart';
import '../../widgets/settings/settings_app_bar.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/change_password_screen';

  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordtroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: const SettingsAppBar(title: 'Change password'),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              const HeaderContainsAvatar(
                  email: 'Email of the user', usrName: 'UserName'),
              const DefaultTextField(
                labelText: 'Current password',
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(
                          color: ColorManager.upvoteRed,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              const DefaultTextField(
                labelText: 'Current password',
                isPassword: true,
              ),
              const DefaultTextField(
                labelText: 'Current password',
                isPassword: true,
              )
            ]),
            BottomButtons(
                string1: 'Cancel',
                string2: 'Save',
                handler1: () {
                  navigator.pop();
                },
                handler2: () {})
          ],
        ),
      ),
    );
  }
}
