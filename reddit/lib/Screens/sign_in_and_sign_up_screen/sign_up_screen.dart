/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of creating new account for the users.

import 'package:flutter/material.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/sign_up_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import '../../screens/sign_in_and_sign_up_screen/sign_In_screen.dart';
import '../../components/default_text_field.dart';
import '../../components/button.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';
import 'package:dio/dio.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  static const routeName = '/sign_up_route';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final customAppBar = LogInAppBar(
        sideBarButtonText: 'Log in',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(SignInScreen.routeName);
        });
    final theme = Theme.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;
    final user = signUpModel(
        email: 'Abdelaziz132001@gmail.com',
        password: '1023',
        username: 'Abdelaziz');
    return Scaffold(
      appBar: customAppBar,
      backgroundColor: ColorManager.darkGrey,
      body: SingleChildScrollView(
        child: Container(
          /// the height of the screen should be the whole height of the screen
          /// but without the height of the app bar and without the padding of
          /// the down drag top of the phone itself
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Button(
                          text: 'Continue with Google',
                          textColor: ColorManager.white,
                          backgroundColor: ColorManager.darkGrey,
                          buttonWidth: mediaQuery.size.width * 0.9,
                          buttonHeight: mediaQuery.size.height * 0.05,
                          textFontSize: textScaleFactor * 18,
                          onPressed: () {
                            print('Continue with google');
                          },
                          boarderRadius: 20,
                          borderColor: ColorManager.white,
                          textFontWeight: FontWeight.bold),
                      Button(
                          text: 'Continue with Facebook',
                          textColor: ColorManager.white,
                          backgroundColor: ColorManager.darkGrey,
                          buttonWidth: mediaQuery.size.width * 0.9,
                          buttonHeight: mediaQuery.size.height * 0.05,
                          textFontSize: textScaleFactor * 18,
                          onPressed: () {
                            print('Continue with facebook');
                          },
                          boarderRadius: 20,
                          borderColor: ColorManager.white,
                          textFontWeight: FontWeight.bold),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: ColorManager.greyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: textScaleFactor * 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    DefaultTextField(
                      formController: emailController,
                      labelText: 'Email',
                    ),
                    DefaultTextField(
                      formController: usernameController,
                      labelText: 'Username',
                    ),
                    DefaultTextField(
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
                    const Text(
                      textAlign: TextAlign.center,
                      'By continuing, you agree to our '
                      'User Agreement and Privace Policy',
                      style: TextStyle(color: ColorManager.white),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 1),
                      child: Button(
                          text: 'Continue',
                          boarderRadius: 20,
                          borderColor: ColorManager.white,
                          textFontWeight: FontWeight.bold,
                          textColor: ColorManager.white,
                          backgroundColor: ColorManager.blue,
                          buttonWidth: mediaQuery.size.width,
                          buttonHeight: mediaQuery.size.height * 0.05,
                          textFontSize: textScaleFactor * 14,
                          onPressed: () {
                            DioHelper.postData(
                                path: signUp, data: user.toJson());

                            print(user.toJson());
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
