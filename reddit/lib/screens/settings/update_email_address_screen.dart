/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This file contains the Update email address screen.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/data/settings_models/update_email_model.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/forget_user_name_and_password/mobile/forget_password_screen.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/settings/bottom_buttons.dart';
import '../../widgets/settings/header_contains_avatar.dart';
import '../../widgets/settings/settings_app_bar.dart';

class UpdateEmailAddressScreen extends StatefulWidget {
  static const routeName = 'update_email_address_screen_route';
  const UpdateEmailAddressScreen({super.key});

  @override
  State<UpdateEmailAddressScreen> createState() =>
      _UpdateEmailAddressScreenState();
}

class _UpdateEmailAddressScreenState extends State<UpdateEmailAddressScreen> {
  final _myKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// This function is responsible for sending the put request
  /// to update the email of the user.
  void updateMyMail() {
    if (_validateTextFields()) {
      final update = UpdateEmail(
          currentPassword: passwordController.text,
          newEmail: mailController.text);

      DioHelper.putData(path: changeEmail, data: update.toJson())
          .then((response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Email has been sent!'),
              backgroundColor: ColorManager.green));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The inserted password is incorrect'),
          backgroundColor: ColorManager.red,
        ));
      });
    }
  }

  /// this is a utility function used to check whethere
  /// the user has inserted correct formate for the mail and password or not.
  /// @return [True] if the formate of the email is correct
  /// @return [False] otherwise
  bool _validateTextFields() {
    if (!_myKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text(
                'Try inserting a valid and existing email address and user name.')),
      );
      return false;
    }
    return true;
  }

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
              SizedBox(
                height: mediaQuery.size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const HeaderContainsAvatar(
                      usrName: 'UserName',
                      email: 'Email of the user',
                    ),
                    DefaultTextField(
                      labelText: 'New email address',
                      validator: (email) {
                        if (!Validator.validEmailValidator(email!)) {
                          return 'opps, you have inserted wrong email formate';
                        }
                        return null;
                      },
                    ),
                    DefaultTextField(
                      labelText: 'Reddit password',
                      isPassword: true,
                      validator: (password) {
                        if (!Validator.validPasswordValidation(password!)) {
                          return 'opps, you have inserted wrong password formate';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            navigator.pushNamed(ForgetPasswordScreen.routeName);
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: ColorManager.upvoteRed),
                          )),
                    )
                  ],
                ),
              ),
              BottomButtons(
                string1: 'Cancel',
                string2: 'Save',
                handler1: () {
                  navigator.pop();
                },
                handler2: updateMyMail,
              )
            ],
          ),
        ),
      ),
    );
  }
}
