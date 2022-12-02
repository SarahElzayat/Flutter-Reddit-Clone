/// @author Abdelaziz Salah
/// @date 12/11/2022
/// this file contains the screen for the forget password in the Web plateform.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../screens/forget_user_name_and_password/web/forget_user_name_web_screen.dart';
import '../../../screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import '../../../screens/to_go_screens/having_trouble_screen.dart';
import '../../../components/Button.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/default_text_field.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';

class ForgetPasswordWebScreen extends StatefulWidget {
  const ForgetPasswordWebScreen({super.key});

  static const routeName = '/forget_password_web_screen_route';

  @override
  State<ForgetPasswordWebScreen> createState() =>
      _ForgetPasswordWebScreenState();
}

class _ForgetPasswordWebScreenState extends State<ForgetPasswordWebScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: Row(
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
                width: 430,
                child: Column(
                  children: [
                    // the text container
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 190),
                        height: 20.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                height: 44,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Image.asset('assets/icons/appIcon.png')),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Reset your password',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            const Text(
                              'Tell us the username and email address associated with your Reddit account, and we’ll send you an email with a link to reset your password. ',
                              style: TextStyle(
                                  height: 1.3,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 35.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DefaultTextField(
                            key: const Key('UsernameTextField'),
                            formController: usernameController,
                            labelText: 'USERNAME',
                          ),
                          DefaultTextField(
                            key: const Key('PasswordTextField'),
                            keyboardType: TextInputType.emailAddress,
                            formController: emailController,
                            labelText: 'PASSWORD',
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            alignment: Alignment.centerLeft,
                            child: Button(
                                key: const Key('ResetPasswordButton'),
                                text: 'Reset Password',
                                textColor: ColorManager.white,
                                backgroundColor: ColorManager.hoverOrange,
                                buttonWidth: 13.5.w,
                                borderRadius: 5,
                                textFontWeight: FontWeight.bold,
                                buttonHeight: 4.h,
                                textFontSize: 16,
                                onPressed: () {
                                  if ((Validator.validUserName(
                                          usernameController.text) &&
                                      Validator.validEmailValidator(
                                          emailController.text))) {
                                    debugPrint('valid');
                                  } else {
                                    debugPrint('Invalid');
                                  }
                                }),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                key: const Key('ForgetPasswordButton'),
                                style: const ButtonStyle(
                                    foregroundColor: MaterialStatePropertyAll(
                                        ColorManager.primaryColor)),
                                onPressed: () {
                                  navigator.pushReplacementNamed(
                                      ForgetUserNameWebScreen.routeName);
                                },
                                child: const Text(
                                  'FORGOT USERNAME?',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                    text:
                                        'Don\'t have an email or need assistance logging in?',
                                    style: TextStyle(
                                      color: ColorManager.eggshellWhite,
                                      fontSize: 14.5,
                                    )),
                                TextSpan(
                                  text: '  GET HELP',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      navigator
                                          .pushNamed(TroubleScreen.routeName);
                                    },
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primaryColor,
                                    fontSize: 14.5,
                                  ),
                                ),
                              ]),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: 430,
                            margin: const EdgeInsets.only(top: 10),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'LOG IN .',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        navigator.pushReplacementNamed(
                                            SignInForWebScreen.routeName);
                                      },
                                    style: const TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: 14.5,
                                    )),
                                TextSpan(
                                  text: ' SIGN UP',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      navigator.pushNamed(
                                          SignUpForWebScreen.routeName);
                                    },
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primaryColor,
                                    fontSize: 14.5,
                                  ),
                                ),
                              ]),
                              textAlign: TextAlign.left,
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
        );
      },
    );
  }
}
