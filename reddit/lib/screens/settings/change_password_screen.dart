/// @author Abdelaziz Salah
/// @date 12/12/2022
/// this file contains the screen of the change password
import 'package:flutter/material.dart';
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
                  child: Column(children: [
                    const HeaderContainsAvatar(
                        email: 'Email of the user', usrName: 'UserName'),
                    DefaultTextField(
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
                          onPressed: () {},
                          child: const Text(
                            'Forget password?',
                            style: TextStyle(
                                color: ColorManager.upvoteRed,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    DefaultTextField(
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
