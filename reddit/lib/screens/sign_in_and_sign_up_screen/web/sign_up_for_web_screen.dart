/// @author Abdelaziz Salah
/// @date 11/11/20222

import 'package:flutter/material.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/web/continue_sign_up_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/button.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/default_text_field.dart';
import '../../../screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_fb_or_google_web.dart';

/// this is a screen for rendering the app on the web
class SignUpForWebScreen extends StatefulWidget {
  const SignUpForWebScreen({super.key});

  static const routeName = '/sign_un_for_web_screen_route';

  @override
  State<SignUpForWebScreen> createState() => _SignUpForWebScreenState();
}

class _SignUpForWebScreenState extends State<SignUpForWebScreen> {
  TextEditingController emailController = TextEditingController();

  final _myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: ListView(children: [
            Form(
              key: _myKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// the image box
                  SizedBox(

                      /// in the website it is fixed not relative
                      width: mediaQuery.size.width > 600 ? 140 : 120,
                      height: 100.h,
                      child: Image.asset(
                        'assets/images/WebSideBarBackGroundImage.png',
                        fit: BoxFit.fitHeight,
                      )),

                  /// the main screen
                  Container(
                    margin: const EdgeInsets.only(left: 28),
                    height: mediaQuery.size.height,

                    /// in the website it is fixed
                    width: 295,
                    child: Column(
                      children: [
                        /// the text container
                        Container(
                            margin: const EdgeInsets.only(bottom: 30, top: 160),
                            height: 15.h,
                            width: 295,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: ColorManager.eggshellWhite,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text(
                                    'By continuing, you are setting up a Reddit account and '
                                    'agree to our User Agreement and Privace Policy',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            child: const ContinueWithGoogleOrFbWeb()),
                        const Text(
                          'OR',
                          style: TextStyle(
                            color: ColorManager.eggshellWhite,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DefaultTextField(
                                key: const Key('EmailTextField'),
                                validator: (email) {
                                  if (!Validator.validEmailValidator(email!)) {
                                    return 'email must follow this formate:\nexample@aything.com';
                                  } else {
                                    return null;
                                  }
                                },
                                formController: emailController,
                                labelText: 'Email',
                              ),
                              Button(
                                  key: const Key('ContinueButton'),
                                  textFontWeight: FontWeight.normal,
                                  text: 'CONTINUE',
                                  textColor: ColorManager.white,
                                  backgroundColor: ColorManager.hoverOrange,
                                  buttonWidth: 25.w,
                                  borderRadius: 5,
                                  buttonHeight: 40,
                                  textFontSize: 14,
                                  // TODO: This Logic Should be separated in separate function
                                  onPressed: () {
                                    if (!_myKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('invalid mail'),
                                        backgroundColor: ColorManager.red,
                                      ));
                                    }

                                    if (Validator.validEmailValidator(
                                        emailController.text)) {
                                      print('validMail');
                                    } else {
                                      print('inValidMail');
                                    }
                                    Navigator.of(context).pushReplacementNamed(
                                        ContinueSignUpScreen.routeName);
                                  }),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Already a redditor?',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    TextButton(
                                        key: const Key('LoginButton'),
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context,
                                              SignInForWebScreen.routeName);
                                        },
                                        child: const Text('LOG IN',
                                            style: TextStyle(
                                                color: ColorManager.blue)))
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
          ]),
        );
      },
    );
  }
}
