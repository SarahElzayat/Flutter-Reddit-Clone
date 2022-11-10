/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of signing into the own account

import 'package:flutter/material.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';
import '../../../data/sign_in_And_sign_up_models/sign_in_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../screens/forget_user_name_and_password/forget_password_screen.dart';
import '../../../screens/sign_in_and_sign_up_screen/sign_up_screen.dart';
import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_button.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_with_facebook_or_google.dart';

// ignore: must_be_immutable
class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});
  static const routeName = '/sign_in_route';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
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
                    child: const ContinueWithGoOrFB()),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    DefaultTextField(
                      formController: usernameController,
                      labelText: 'Username',
                      icon: usernameController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                usernameController.text = '';
                              },
                            )
                          : null,
                    ),
                    DefaultTextField(
                      formController: passwordController,
                      labelText: 'Password',
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
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
                    const Text(
                      'By continuing, you agree to our '
                      'User Agreement and Privace Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorManager.white),
                    ),
                    ContinueButton(
                      isPressable: (usernameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty),
                      appliedFunction: () async {
                        /// TODO: remove this log out from here it is not its place
                        // await FacebookLoginAPI.logOut();
                        if (Validator.validPasswordValidation(
                                passwordController.text) &&
                            Validator.validUserName(usernameController.text)) {
                          LogInModel user = LogInModel(
                              username: usernameController.text,
                              password: passwordController.text);

                          DioHelper.postData(path: login, data: user.toJson())
                              .then((value) {
                            /// here we want to make sure that we got the correct response
                          });

                          print(user.toJson());
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
    );
  }
}
