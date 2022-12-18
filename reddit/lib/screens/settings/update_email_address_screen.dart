/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This file contains the Update email address screen.

import 'package:flutter/material.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../cubit/settings_cubit/settings_cubit.dart';
import '../../data/sign_in_And_sign_up_models/validators.dart';
import '../../screens/forget_user_name_and_password/mobile/forget_password_screen.dart';
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
      SettingsCubit.get(context).changeEmailAddress(
          passwordController.text, mailController.text, context);
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

  void buildForgetUserName() {
    final mediaQuery = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController emailController = TextEditingController();
          return AlertDialog(
            title: SizedBox(
                height: mediaQuery.size.height * 0.3,
                width: mediaQuery.size.width,
                child: Form(
                  key: _myKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Recover username',
                                textAlign: TextAlign.left,
                              ),
                              DefaultTextField(
                                labelText: 'Email',
                                formController: emailController,
                                validator: (email) {
                                  if (!Validator.validEmailValidator(email!)) {
                                    return 'opps, you have inserted wrong email formate';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Unfortunately, if you have never given us your email, we cannot help you.',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ColorManager.upvoteRed),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Having trouble?',
                                      style: TextStyle(
                                          color: ColorManager.blue,
                                          fontSize: 12),
                                    ),
                                  )),
                            ]),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: (() {}),
                                child: const Text('Email Me')),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  void buildForgetPass() {
    final mediaQuery = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (context) {
          TextEditingController usernameController = TextEditingController();
          TextEditingController emailController = TextEditingController();
          return AlertDialog(
            title: SizedBox(
                height: mediaQuery.size.height * 0.5,
                width: mediaQuery.size.width,
                child: Form(
                  key: _myKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Forgot your password?',
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DefaultTextField(
                                formController: usernameController,
                                labelText: 'Username',
                                validator: (username) {
                                  if (!Validator.validUserName(username!)) {
                                    return 'opps, you have inserted wrong username formate';
                                  }
                                  return null;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      buildForgetUserName();
                                    },
                                    child: const Text(
                                      'Forgot username?',
                                      textAlign: TextAlign.left,
                                      style:
                                          TextStyle(color: ColorManager.blue),
                                    )),
                              ),
                              DefaultTextField(
                                labelText: 'Email',
                                formController: emailController,
                                validator: (email) {
                                  if (!Validator.validEmailValidator(email!)) {
                                    return 'opps, you have inserted wrong email formate';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Unfortunately, if you have never given us your email, we cannot help you.',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: ColorManager.upvoteRed),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Having trouble?',
                                      style: TextStyle(
                                          color: ColorManager.blue,
                                          fontSize: 12),
                                    ),
                                  )),
                            ]),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: (() {}),
                                child: const Text('Email Me')),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    const myAppBar = SettingsAppBar(title: 'Update email address');
    return Scaffold(
      appBar: myAppBar,
      body: Form(
        key: _myKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: mediaQuery.size.height -
                mediaQuery.padding.top -
                myAppBar.preferredSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HeaderContainsAvatar(
                        usrName: CacheHelper.getData(key: 'username'),
                        email: CacheHelper.getData(key: 'email'),
                      ),
                      DefaultTextField(
                        formController: mailController,
                        labelText: 'New email address',
                        validator: (email) {
                          if (!Validator.validEmailValidator(email!)) {
                            return 'opps, you have inserted wrong email formate';
                          }
                          return null;
                        },
                      ),
                      DefaultTextField(
                        formController: passwordController,
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
                            onPressed: buildForgetPass,
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
      ),
    );
  }
}
