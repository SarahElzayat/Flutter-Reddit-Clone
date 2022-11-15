/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of signing into the own account

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reddit/Screens/to_go_screens/privacy_and_policy.dart';
import 'package:reddit/Screens/to_go_screens/user_agreement_screen.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../../data/sign_in_And_sign_up_models/sign_in_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../screens/forget_user_name_and_password/mobile/forget_password_screen.dart';
import '../../../screens/sign_in_and_sign_up_screen/mobile/sign_up_screen.dart';
import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_button.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_facebook_or_google.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const routeName = '/sign_in_route';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isEmptyText = true;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final _formKey = GlobalKey<FormState>();
    final customAppBar = LogInAppBar(
        sideBarButtonText: 'Sign Up',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(SignUpScreen.routeName);
        });
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppBar,
      backgroundColor: ColorManager.darkGrey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
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
                    'Log in to Reddit',
                    style: theme.textTheme.titleMedium,
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
                  flex: 3,
                  child: Column(
                    children: [
                      DefaultTextField(
                        onChanged: (myString) {
                          setState(() {
                            if (myString.isNotEmpty) {
                              isEmptyText = false;
                            } else {
                              isEmptyText = true;
                            }
                          });
                        },
                        validator: (username) {
                          if (Validator.validUserName(username!)) {
                            return 'The username length must be greater than 2 and less than 21';
                          }
                          return null;
                        },
                        formController: usernameController,
                        labelText: 'Username',
                        icon: !isEmptyText
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    usernameController.text = '';
                                    isEmptyText = true;
                                  });
                                },
                              )
                            : null,
                      ),
                      DefaultTextField(
                        formController: passwordController,
                        labelText: 'Password',
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (password) {
                          if (!Validator.validPasswordValidation(password!)) {
                            return 'password length must be greater 7';
                          }
                        },
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
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                        isPressable: (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty),
                        appliedFunction: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password invalid')),
                            );
                          }

                          /// TODO: remove this log out from here it is not its place
                          // await FacebookLoginAPI.logOut();
                          if (Validator.validPasswordValidation(
                                  passwordController.text) &&
                              Validator.validUserName(
                                  usernameController.text)) {
                            LogInModel user = LogInModel(
                                username: usernameController.text,
                                password: passwordController.text);
                            DioHelper.postData(path: login, data: user.toJson())
                                .then((value) {
                              print(value);
                              // print(value['token'].toString());
                              // CacheHelper.putData(
                              //     key: 'token', value: value.data[0]);
                              // print(CacheHelper.getData(key: 'token'));
                            });
                          } else {
                            /// here we should  print
                            print('SomeThing Went Wrong');
                          }
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
