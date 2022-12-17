/// @author Abdelaziz Salah
/// @date 12/11/2022
/// this screen is built to show the UI in case that the user is using the app through the web

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reddit/screens/main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../data/sign_in_And_sign_up_models/sign_in_model.dart';
import '../../../screens/bottom_navigation_bar_screens/home_screen.dart';
import '../../../screens/forget_user_name_and_password/web/forget_password_web_screen.dart';
import '../../../screens/forget_user_name_and_password/web/forget_user_name_web_screen.dart';
import '../../../components/button.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/default_text_field.dart';
import '../../../screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../shared/local/shared_preferences.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_fb_or_google_web.dart';
import '../../to_go_screens/privacy_and_policy.dart';
import '../../to_go_screens/user_agreement_screen.dart';

class SignInForWebScreen extends StatefulWidget {
  const SignInForWebScreen({super.key});

  static const routeName = '/sign_in_for_web_screen_route';

  @override
  State<SignInForWebScreen> createState() => _SignInForWebScreenState();
}

class _SignInForWebScreenState extends State<SignInForWebScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  final _myKey = GlobalKey<FormState>();

  /// this function should validate that the input to the textfields
  /// are valid, else it will show a snackbar to the user
  /// telling him that he has inserted something wrong.
  bool validTextFields() {
    if (!_myKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text('username or password are invalid')),
      );
      return false;
    }
    return true;
  }

  /// this function is used to validate that the user has inserted the right
  /// input formate and also send the request to the api
  void loginChecker() async {
    if (!validTextFields()) return;

    final user = LogInModel(
        password: passwordController.text, username: usernameController.text);

    DioHelper.postData(path: login, data: user.toJson()).then((value) {
      print('Im here');

      // if valid request then we can navigate to another screen after sending the data to the backend
      if (value.statusCode == 200) {
        CacheHelper.putData(key: 'token', value: value.data['token']);
        CacheHelper.putData(key: 'username', value: value.data['username']);

        // navigating to the main screen
        kIsWeb
            ? Navigator.of(context).pushReplacementNamed(HomeScreen.routeName)
            : Navigator.of(context)
                .pushReplacementNamed(HomeScreenForMobile.routeName);
      }
    }).catchError((error) {
      // casting the error as a dio error to be able to use its content
      error = error as DioError;
      // checking for our main error, which is that the user trying to insert
      // username which is already taken
      // if (error.message.toString() == 'Http status error [400]') {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //         backgroundColor: ColorManager.red,
      //         content: Text('Username is already in use')),
      //   );
      // } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text(
                'Something went wrong!, please change the inputs and try again')),
      );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: Form(
            key: _myKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // the image box
                SizedBox(

                    // in the website it is fixed not relative
                    width: mediaQuery.size.width > 600 ? 140 : 120,
                    height: 100.h,
                    child: Image.asset(
                      'assets/images/WebSideBarBackGroundImage.png',
                      fit: BoxFit.fitHeight,
                    )),

                // the main screen.
                Container(
                  margin: const EdgeInsets.only(left: 28),
                  height: 100.h,

                  // in the website it is fixed
                  width: 295,
                  child: Column(
                    children: [
                      // the text container
                      Container(
                          margin: const EdgeInsets.only(bottom: 30, top: 120),
                          height: 15.h,
                          width: 295,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              RichText(
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
                                        navigator.pushNamed(
                                            UserAgreementScreen.routeName);
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
                                        navigator.pushNamed(
                                            PrivacyAndPolicy.routeName);
                                      },
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ColorManager.primaryColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ]),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: const ContinueWithGoogleOrFbWeb()),
                      const Text('OR'),
                      SizedBox(
                        height: 30.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DefaultTextField(
                              key: const Key('UsernameTextField'),
                              validator: (username) {
                                if (!Validator.validUserName(username!)) {
                                  return 'username length must be less than 21 and greater 2';
                                } else {
                                  return null;
                                }
                              },
                              formController: usernameController,
                              onChanged: (string) {
                                setState(
                                    () {}); // this empty set state to be able to change the color of the button
                                // whenever the user enter any string in the field
                              },
                              labelText: 'USERNAME',
                            ),
                            DefaultTextField(
                              isPassword: true,
                              key: const Key('passwordTextField'),
                              validator: (password) {
                                if (!Validator.validPasswordValidation(
                                    password!)) {
                                  return 'password length must more than 7 characters';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (string) {
                                setState(
                                    () {}); // this empty set state to be able to change the color of the button
                                // whenever the user enter any string in the field
                              },
                              formController: passwordController,
                              labelText: 'PASSWORD',
                            ),
                            Button(
                                key: const Key('LoginButton'),
                                textFontWeight: FontWeight.normal,
                                text: 'LOG IN',
                                isPressable:
                                    usernameController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty,
                                textColor:
                                    (usernameController.text.isNotEmpty &&
                                            passwordController.text.isNotEmpty)
                                        ? ColorManager.white
                                        : ColorManager.eggshellWhite,
                                backgroundColor: ColorManager.upvoteRed,
                                borderColor:
                                    usernameController.text.isNotEmpty &&
                                            passwordController.text.isNotEmpty
                                        ? ColorManager.upvoteRed
                                        : ColorManager.grey,
                                buttonWidth: 25.w,
                                borderRadius: 5,
                                buttonHeight: 40,
                                textFontSize: 14,
                                onPressed: loginChecker),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(children: [
                                  const TextSpan(
                                      text: 'Forgot your ',
                                      style: TextStyle(
                                        color: ColorManager.eggshellWhite,
                                        fontSize: 14.5,
                                      )),
                                  TextSpan(
                                    text: 'username',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigator.pushNamed(
                                            ForgetUserNameWebScreen.routeName);
                                      },
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ColorManager.primaryColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' or ',
                                    style: TextStyle(
                                      color: ColorManager.eggshellWhite,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'password',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigator.pushNamed(
                                            ForgetPasswordWebScreen.routeName);
                                      },
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: ColorManager.primaryColor,
                                      fontSize: 14.5,
                                    ),
                                  ),
                                ]),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    'New to Reddit?',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200),
                                  ),
                                  TextButton(
                                      key: const Key('SignUpButton'),
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
                                            SignUpForWebScreen.routeName);
                                      },
                                      child: const Text('SIGN UP',
                                          style: TextStyle(
                                              color:
                                                  ColorManager.primaryColor)))
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
