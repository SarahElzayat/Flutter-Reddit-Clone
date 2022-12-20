/// @author Abdelaziz Salah
/// @date 12/12/2022
/// this file contains the screen of the change password
import 'package:flutter/material.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../cubit/settings_cubit/settings_cubit.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../data/sign_in_And_sign_up_models/validators.dart';
import '../../widgets/settings/bottom_buttons.dart';
import '../../widgets/settings/header_contains_avatar.dart';
import '../../widgets/settings/settings_app_bar.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = '/change_password_screen';

  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordtroller = TextEditingController();

  /// this is a utility function used to check whethere
  /// the user has inserted correct formate for the mail and password or not.
  /// @return [True] if the formate of the email is correct
  /// @return [False] otherwise
  bool _validateTextFields() {
    if (!_formKey.currentState!.validate() ||
        (newPasswordController.text != confirmPasswordtroller.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text('Insert The Same password please')),
      );
      return false;
    }
    return true;
  }

  /// This function is used to send a put request in order
  /// to be able to change the password of the user into new user
  void requestChangePassword() {
    if (_validateTextFields()) {
      SettingsCubit.get(context).changePasswordReq(passwordController.text,
          confirmPasswordtroller.text, newPasswordController.text, context);
    }
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
                  key: _formKey,
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

  /// TODO: Fix what happens when the keyboard raises.

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
                  key: _formKey,
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
    final navigator = Navigator.of(context);
    final mediaQuery = MediaQuery.of(context);
    const myappBar = SettingsAppBar(title: 'Change password');
    return Scaffold(
      appBar: myappBar,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            // I made it in that way in order to avoid the overflow
            height: mediaQuery.size.height -
                mediaQuery.padding.top -
                myappBar.preferredSize.height,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      HeaderContainsAvatar(
                        usrName: CacheHelper.getData(key: 'username'),
                        email: CacheHelper.getData(key: 'email'),
                      ),
                      DefaultTextField(
                        formController: passwordController,
                        labelText: 'Current password',
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
                              'Forget password?',
                              style: TextStyle(
                                  color: ColorManager.upvoteRed,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      DefaultTextField(
                        formController: newPasswordController,
                        labelText: 'New Password',
                        isPassword: true,
                        validator: (password) {
                          if (!Validator.validPasswordValidation(password!)) {
                            return 'opps, you have inserted wrong password formate';
                          }
                          return null;
                        },
                      ),
                      DefaultTextField(
                        formController: confirmPasswordtroller,
                        labelText: 'Confirm New Password',
                        isPassword: true,
                        validator: (password) {
                          if (!Validator.validPasswordValidation(password!)) {
                            return 'opps, you have inserted wrong password formate';
                          }
                          return null;
                        },
                      )
                    ]),
                  ),
                ),
                BottomButtons(
                    string1: 'Cancel',
                    string2: 'Save',
                    handler1: () {
                      navigator.pop();
                    },
                    handler2: requestChangePassword)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
