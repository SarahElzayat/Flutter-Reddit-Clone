/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of creating new account for the users.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reddit/Screens/sign_in_and_sign_up_screen/mobile/sign_up_screen.dart';
import '../../forget_user_name_and_password/forget_password_screen.dart';
import '../../main_screen.dart';
import '../../to_go_screens/privacy_and_policy.dart';
import '../../to_go_screens/user_agreement_screen.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_button.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_facebook_or_google.dart';
import '../../../data/sign_in_And_sign_up_models/sign_up_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign_in_route';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  /// this function should validate that the input to the textfields
  /// are valid, else it will show a snackbar to the user
  /// telling him that he has inserted something wrong.
  bool validTextFields() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text('Password or username are invalid')),
      );
      return false;
    }
    return true;
  }

  /// this function should be executed when the user presses continue button
  /// it should validate the textFields and also should should send the request
  /// to the backend if the textfields are valid
  void continueToTheHomePage() async {
    if (!validTextFields()) return;

    final user = SignUpModel(
        email: usernameController.text,
        password: passwordController.text,
        username: usernameController.text);

    DioHelper.postData(path: login, data: user.toJson()).then((value) {
      print(value);

      /// here we want to make sure that we got the correct response

      // navigating to the main screen
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    });
  }

  void textChanger(myString) {
    setState(() {
      if (myString.isNotEmpty) {
        isEmptyEmail = false;
      } else {
        isEmptyEmail = true;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool isEmptyEmail = true;
  bool isEmptyUserName = true;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);

    final customAppBar = LogInAppBar(
        sideBarButtonText: 'SIGN UP',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(SignUpScreen.routeName);
        });
    final textScaleFactor = mediaQuery.textScaleFactor;

    return Scaffold(
      appBar: customAppBar,
      backgroundColor: ColorManager.darkGrey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    'Login To Reddit',
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
                      child: ContinueWithGoOrFB(width: mediaQuery.size.width)),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      DefaultTextField(
                        validator: (username) {
                          if (!Validator.validUserName(username!)) {
                            return 'The username length should be less than 21 and greater than 2 ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (myString) => textChanger(myString),
                        formController: usernameController,
                        labelText: 'Username',
                        icon: usernameController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                onPressed: (() {
                                  setState(() {
                                    usernameController.text = '';
                                    isEmptyEmail = true;
                                  });
                                }))
                            : null,
                      ),
                      DefaultTextField(
                        validator: (password) {
                          if (!Validator.validPasswordValidation(password!)) {
                            return 'The password must be at least 8 characters';
                          } else {
                            return null;
                          }
                        },
                        formController: passwordController,
                        labelText: 'Password',
                        isPassword: true,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: TextButton(
                            onPressed: () {
                              navigator.pushReplacementNamed(
                                  ForgetPasswordScreen.routeName);
                            },
                            child: Text(
                              'Forgot password',
                              style: TextStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 14 * mediaQuery.textScaleFactor),
                            )),
                      ),
                    ],
                  ),
                ),

                /// the bottom part of the code
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
                          isPressable: usernameController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty,
                          appliedFunction: continueToTheHomePage)
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
