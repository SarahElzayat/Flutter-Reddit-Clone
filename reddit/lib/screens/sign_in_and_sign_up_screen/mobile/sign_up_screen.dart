/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of creating new account for the users.
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/settings/settings_models/user_settings.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/mobile/continue_sign_up_for_mobile.dart';

import 'package:reddit/shared/local/shared_preferences.dart';

import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../data/sign_in_And_sign_up_models/sign_up_model.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_button.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_facebook_or_google.dart';
import '../../to_go_screens/privacy_and_policy.dart';
import '../../to_go_screens/user_agreement_screen.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign_up_route';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEmptyEmail = true;
  bool isEmptyUserName = true;

  /// this function should validate that the input to the textfields
  /// are valid, else it will show a snackbar to the user
  /// telling him that he has inserted something wrong.
  bool validTextFields() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text('email, username or password are invalid')),
      );
      return false;
    }
    return true;
  }

  /// this function should be executed when the user presses continue button
  /// it should validate the textFields and also should should send the request
  /// to the backend if the textfields are valid
  void continueFunction() async {
    // check whether the text fields are filled correctly or not.
    if (!validTextFields()) {
      return;
    }

    // creating a model to be in the shape of json
    final user = SignUpModel(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text);
    await DioHelper.postData(path: signUp, data: user.toJson())
        .then((value) async {
      if (value.statusCode == 201) {
        CacheHelper.putData(key: 'token', value: value.data['token']);
        CacheHelper.putData(key: 'username', value: value.data['username']);
        token = CacheHelper.getData(key: 'token');

        /// here we should request the user settings from the backend
        await DioHelper.getData(path: accountSettings).then((response2) {
          UserSettingsModel user = UserSettingsModel.fromJson(response2.data);
          user.cacheUserSettings();
        }).onError((error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: ColorManager.red,
                content: Text('Something went wrong!, please try again')),
          );
        });
        // navigating to the interests screen
        Navigator.of(context)
            .pushReplacementNamed(ContinueSignUpForMobile.routeName);
      }
    }).catchError((error) {
      // casting the error as a dio error to be able to use its content
      error = error as DioError;
      // checking for our main error, which is that the user trying to insert
      // username which is already taken

      if (error.message.toString() == 'Http status error [400]') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: ColorManager.red,
              content: Text('Username is already in use')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: ColorManager.red,
              content: Text(
                  'Something went wrong!, please change the inputs and try again')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);

    final customAppBar = LogInAppBar(
        key: const Key('LogInButton'),
        sideBarButtonText: 'Log in',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(SignInScreen.routeName);
        });
    final textScaleFactor = mediaQuery.textScaleFactor;

    return Scaffold(
      appBar: customAppBar,
      backgroundColor: ColorManager.darkGrey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            // the height of the screen should be the whole height of the screen
            // but without the height of the app bar and without the padding of
            // the down drag top of the phone itself
            height: mediaQuery.size.height -
                customAppBar.preferredSize.height -
                mediaQuery.padding.top,
            width: mediaQuery.size.width,
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Hello new friend, welcome to Reddit',
                    // style: theme.textTheme.titleMedium,
                    style: TextStyle(
                      fontSize: textScaleFactor * 24,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                      height: mediaQuery.size.height * 0.18,
                      child: ContinueWithGoOrFB(
                        width: mediaQuery.size.width,
                      )),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      DefaultTextField(
                        labelText: 'Email',
                        key: const Key('EmailTextField'),
                        validator: (email) {
                          if (!Validator.validEmailValidator(email!)) {
                            return 'This mail format is incorrect';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) => setState(() {}),
                        formController: emailController,
                        icon: emailController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: (() {
                                  setState(() {
                                    emailController.text = '';
                                  });
                                }))
                            : null,
                      ),
                      DefaultTextField(
                        key: const Key('UsernameTextField'),
                        validator: (username) {
                          if (!Validator.validUserName(username!)) {
                            return 'The username length must be greater than 2 and less than 21';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                        formController: usernameController,
                        labelText: 'Username',
                        icon: usernameController.text.isNotEmpty ||
                                usernameController.text != ''
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: (() {
                                  setState(() {
                                    isEmptyUserName = true;
                                    usernameController.text = '';
                                  });
                                }))
                            : null,
                      ),
                      DefaultTextField(
                        key: const Key('PasswordTextField'),
                        validator: (password) {
                          if (!Validator.validPasswordValidation(password!)) {
                            return 'The password must be at least 8 characters';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                        formController: passwordController,
                        labelText: 'Password',
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // this button is unreasonable but okay
                      // just to be same as the app.
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorManager.darkGrey)),
                        onPressed: () {},
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: 'By continuing, you agree to our ',
                                style: TextStyle(
                                  color: ColorManager.eggshellWhite,
                                  fontSize: 14.5,
                                )),
                            TextSpan(
                              text: 'User Agreement',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  navigator
                                      .pushNamed(UserAgreementScreen.routeName);
                                },
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: ColorManager.primaryColor,
                                fontSize: 14.5,
                              ),
                            ),
                            const TextSpan(
                              text: ' And ',
                              style: TextStyle(
                                color: ColorManager.eggshellWhite,
                                fontSize: 14.5,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  navigator
                                      .pushNamed(PrivacyAndPolicy.routeName);
                                },
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: ColorManager.primaryColor,
                                fontSize: 14.5,
                              ),
                            ),
                          ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ContinueButton(
                        key: const Key('ContinueButton'),
                        isPressable: emailController.text.isNotEmpty &&
                            usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty,
                        appliedFunction: () {
                          continueFunction();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
