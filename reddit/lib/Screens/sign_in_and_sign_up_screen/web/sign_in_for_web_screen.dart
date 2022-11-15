/// @author Abdelaziz Salah
/// @date 12/11/2022

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reddit/Screens/forget_user_name_and_password/web/forget_password_web_screen.dart';
import 'package:reddit/Screens/forget_user_name_and_password/web/forget_user_name_web_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../Components/Button.dart';
import '../../../Components/Helpers/color_manager.dart';
import '../../../Components/default_text_field.dart';
import '../../../Screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_fb_or_google_web.dart';
import '../../to_go_screens/privacy_and_policy.dart';
import '../../to_go_screens/user_agreement_screen.dart';

/// this screen is built to show the UI in case that the user is using the app through the web
class SignInForWebScreen extends StatelessWidget {
  SignInForWebScreen({super.key});

  static const routeName = '/sign_in_for_web_screen_route';
  TextEditingController passwordController = TextEditingController();
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
                            formController: usernameController,
                            labelText: 'USERNAME',
                          ),
                          DefaultTextField(
                            formController: passwordController,
                            labelText: 'PASSWORD',
                          ),
                          Button(
                              text: 'LOG IN',
                              textColor: ColorManager.white,
                              backgroundColor: ColorManager.hoverOrange,
                              buttonWidth: 25.w,
                              boarderRadius: 5,
                              buttonHeight: 40,
                              textFontSize: 14,
                              onPressed: () {
                                if (Validator.validUserName(
                                        usernameController.text) &&
                                    Validator.validPasswordValidation(
                                        passwordController.text)) {
                                  debugPrint('valid');
                                } else {
                                  debugPrint('Invalid');
                                }
                              }),
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
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context,
                                          SignUpForWebScreen.routeName);
                                    },
                                    child: const Text('SIGN UP',
                                        style: TextStyle(
                                            color: ColorManager.primaryColor)))
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
        );
      },
    );
  }
}
