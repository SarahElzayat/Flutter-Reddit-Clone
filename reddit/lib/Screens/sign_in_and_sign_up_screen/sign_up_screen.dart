/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of creating new account for the users.

import 'package:flutter/material.dart';
import 'continue_with_facebook_or_google.dart';
import 'sign_in_screen.dart';
import '../../data/sign_in_And_sign_up_models/sign_up_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';

// ignore: must_be_immutable
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
    final textScaleFactor = mediaQuery.textScaleFactor;

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
                    child: const ContinueWithGoOrFB()),
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
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      side: BorderSide(
                                          width: 2,
                                          color: ColorManager.white))),
                              backgroundColor:
                                  MaterialStatePropertyAll(ColorManager.blue)),
                          onPressed: () async {
                            /// TODO: remove this log out from here it is not its place
                            // await FacebookLoginAPI.logOut();
                            final user = SignUpModel(
                                email: emailController.text,
                                password: passwordController.text,
                                username: usernameController.text);

                            DioHelper.postData(path: login, data: user.toJson())
                                .then((value) {
                              /// here we want to make sure that we got the correct response
                            });
                          },
                          child: SizedBox(
                            width: mediaQuery.size.width,
                            child: Text(
                              'Continue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: (18 * mediaQuery.textScaleFactor),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
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
