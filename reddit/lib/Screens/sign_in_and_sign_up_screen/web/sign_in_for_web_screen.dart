/// @author Abdelaziz Salah
/// @date 11/11/20222

import 'package:flutter/material.dart';
import 'package:reddit/Components/Button.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:reddit/Components/default_text_field.dart';
import 'package:reddit/Screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';
import 'package:reddit/widgets/sign_in_and_sign_up_widgets/continue_with_fb_or_google_web.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// this is a screen for rendering the app on the web
class SignUpForWebScreen extends StatelessWidget {
  SignUpForWebScreen({super.key});

  static const routeName = '/sign_un_for_web_screen_route';

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: ListView(children: [
            Row(
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
                              const Text(
                                'By continuing, you are setting up a Reddit account and '
                                'agree to our User Agreement and Privace Policy',
                                style: TextStyle(
                                    color: ColorManager.eggshellWhite,
                                    fontSize: 14,
                                    fontFamily: 'Arial',
                                    fontWeight: FontWeight.w100),
                              ),
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
                              formController: emailController,
                              labelText: 'Email',
                            ),
                            Button(
                                text: 'CONTINUE',
                                textColor: ColorManager.white,
                                backgroundColor: ColorManager.hoverOrange,
                                buttonWidth: 25.w,
                                boarderRadius: 5,
                                buttonHeight: 40,
                                textFontSize: 14,
                                onPressed: () {
                                  if (Validator.validEmailValidator(
                                      emailController.text)) {
                                    print('validMail');
                                  } else {
                                    print('inValidMail');
                                  }
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
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
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
          ]),
        );
      },
    );
  }
}
