/// @author Abdelaziz Salah
/// @date 22/12/2022
/// This  file contains the user settings screen in the web version.

import 'package:flutter/material.dart';
import 'package:reddit/components/default_text_field.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/cubit/settings_cubit/settings_cubit.dart';
import 'package:reddit/data/settings/countries.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

class UserSettings extends StatefulWidget {
  static const String routeName = '/user-settings-for-web';
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  /// This function is responsible for validating the form and
  /// make sure that the user entered the correct password and email.
  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Password or email are invalid'));
      return false;
    }
    return true;
  }

  /// This function is responsible for sending the put request
  /// to update the email of the user.
  void _updateMyMail() {
    if (_validateForm()) {
      SettingsCubit.get(context).changeEmailAddress(
          passwordController.text, emailController.text, context);
    }
  }

  /// this is a utility function used to check whethere
  /// the user has inserted correct formate for the mail and password or not.
  /// @return [True] if the formate of the email is correct
  /// @return [False] otherwise
  bool _validateTextFields() {
    if (!_formKey.currentState!.validate() ||
        (passwordController.text != confirmPasswordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Insert The Same password please 🔑😐'));

      return false;
    }
    return true;
  }

  /// This function is used to send a put request in order
  /// to be able to change the password of the user into new user
  void _updateMyPassword() {
    if (_validateTextFields()) {
      SettingsCubit.get(context).changePasswordReq(passwordController.text,
          confirmPasswordController.text, passwordController.text, context);
    }
  }

  /// This function is responsible for changing the user email.
  void _changeEmail() {
    emailController.text = '';
    passwordController.text = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Row(children: const [
              Icon(
                Icons.mark_email_unread_outlined,
                color: ColorManager.upvoteRed,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Update your Email',
                style: TextStyle(fontSize: 20),
              )
            ]),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 55,
                    width: 300,
                    child: Text(
                      'Update your email below. There will be a new verification email sent that you will need to use to verify this new email.',
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  DefaultTextField(
                    onChanged: (_) => setState(() {
                      emailController.text = emailController.text;
                    }),
                    labelText: 'Current Password',
                    formController: passwordController,
                    isPassword: true,
                    validator: (password) {
                      if (!Validator.validPasswordValidation(password!)) {
                        return 'Incorect Password!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextField(
                    labelText: 'New Email',
                    onChanged: (_) => setState(() {}),
                    formController: emailController,
                    validator: (email) {
                      if (!Validator.validEmailValidator(email!)) {
                        return 'Incorect Email!';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorManager.darkGrey,
                            side: const BorderSide(
                                width: 1, color: ColorManager.upvoteRed),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: _updateMyMail,
                          child: const Text(
                            'Save Email',
                            style: TextStyle(color: ColorManager.upvoteRed),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  /// This function is responsible for changing the user password.
  void _changePassword() {
    oldPasswordController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: SizedBox(
              width: 550,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 100,
                      height: 500,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                            'assets/images/WebSideBarBackGroundImage.png'),
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: SizedBox(
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 70, top: 40),
                            child: Row(children: const [
                              Icon(
                                Icons.password,
                                color: ColorManager.upvoteRed,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Update your Password',
                                style: TextStyle(
                                    fontSize: 20, color: ColorManager.white),
                              )
                            ]),
                          ),
                          const SizedBox(
                            height: 55,
                            width: 300,
                            child: Text(
                              'Update your password below. There will be a new verification email sent that you will need to use to verify this new password!.',
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width: 400,
                            child: DefaultTextField(
                              isPassword: true,
                              onChanged: (_) => setState(() {
                                oldPasswordController.text =
                                    oldPasswordController.text;
                              }),
                              labelText: 'Old Password',
                              formController: oldPasswordController,
                              validator: (password) {
                                if (!Validator.validPasswordValidation(
                                    password!)) {
                                  return 'Incorect Password!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 400,
                            child: DefaultTextField(
                              isPassword: true,
                              labelText: 'New Password',
                              onChanged: (_) => setState(() {}),
                              formController: passwordController,
                              validator: (email) {
                                if (!Validator.validPasswordValidation(
                                    email!)) {
                                  return 'Incorect Password!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 400,
                            child: DefaultTextField(
                              isPassword: true,
                              labelText: 'Confirm New Password',
                              onChanged: (_) => setState(() {}),
                              formController: confirmPasswordController,
                              validator: (email) {
                                if (!Validator.validPasswordValidation(
                                    email!)) {
                                  return 'Incorect Password!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 400,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: ColorManager.darkGrey,
                                      side: const BorderSide(
                                          width: 1,
                                          color: ColorManager.upvoteRed),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    onPressed: _updateMyPassword,
                                    child: const Text(
                                      'Update Password',
                                      style: TextStyle(
                                          color: ColorManager.upvoteRed),
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///

  String dropDownValue = 'Male';
  String dropDownValueCountries = 'Egypt';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
        appBar: homeAppBar(context, 1),
        body: mediaQuery.size.height < 400 || mediaQuery.size.width < 580
            ? const Scaffold(
                body: Center(child: Text('increase the window size please!')),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: mediaQuery.size.width > 800
                      ? mediaQuery.size.width * 0.6
                      : double.infinity,
                  height: mediaQuery.size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User Settings',
                              style: theme.textTheme.titleLarge),
                          const Divider(),
                          SizedBox(
                            height: 20,
                            width: 800,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                TextButton(
                                  child: const Text('Account'),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Profile'),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Safety & Privacy'),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Feed Settings'),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Notifications'),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Emails'),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Subscriptions'),
                                  onPressed: () {},
                                ),
                                TextButton(
                                  child: const Text('Chat & Messaging'),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Settings',
                              style: theme.textTheme.titleLarge),
                          const Divider(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ACCOUNT PREFERENCES',
                                      style: theme.textTheme.titleMedium),
                                  const Divider(
                                    thickness: 5,
                                    height: 5,
                                    color: ColorManager.green,
                                  )
                                ],
                              ),
                              Text('Email address',
                                  style: theme.textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    CacheHelper.getData(key: 'email') ??
                                        'email',
                                    style: theme.textTheme.titleMedium),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorManager.grey,
                                side: const BorderSide(
                                    width: 1, color: ColorManager.upvoteRed),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: _changeEmail,
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text('Change',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorManager.upvoteRed)),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Change password',
                                  style: theme.textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'password must be at least 8 characters',
                                    style: theme.textTheme.titleMedium),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorManager.grey,
                                side: const BorderSide(
                                    width: 1, color: ColorManager.upvoteRed),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: _changePassword,
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text('Change',
                                    style: TextStyle(
                                      color: ColorManager.upvoteRed,
                                      fontSize: 18,
                                    )),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gender', style: theme.textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'Reddit will never share this information and only uses it to improve what content you see.',
                                    overflow: TextOverflow.clip,
                                    style: theme.textTheme.titleMedium),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              alignment: Alignment.center,
                              value: dropDownValue,
                              items: [
                                DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: 'Male',
                                  child: Text(
                                    'Male',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: 'Female',
                                  child: Text(
                                    'Female',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value!;
                                  SettingsCubit.get(context).changeDropValue(
                                      value, 'changeGender', context);
                                });
                              },
                            )),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country',
                            style: theme.textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'This is your primary location.',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 8),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              value: dropDownValueCountries,
                              items: countries.map((country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Text(country),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropDownValueCountries = value!;
                                  SettingsCubit.get(context)
                                      .changeCountry(value, context);
                                });
                              },
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
