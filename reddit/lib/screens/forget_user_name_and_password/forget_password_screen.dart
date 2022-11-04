/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of recovering the password
///  if the user forgot his own username

import 'package:flutter/material.dart';
import '../../data/sign_in_And_sign_up_models/login_forget_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../screens/forget_user_name_and_password/recover_username.dart';
import '../../screens/sign_in_and_sign_up_screen/sign_In_screen.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';
import '../../components/button.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  static const routeName = '/forget_password_screen_route';

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);
    final customAppBar = LogInAppBar(
        sideBarButtonText: 'Log In',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(SignInScreen.routeName);
        });
    return Scaffold(
      appBar: customAppBar,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(color: ColorManager.darkGrey),
          height: mediaQuery.size.height -
              mediaQuery.padding.top -
              customAppBar.preferredSize.height,
          width: mediaQuery.size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.7 -
                    mediaQuery.padding.top -
                    customAppBar.preferredSize.height,
                width: mediaQuery.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Forgot your password?',
                      style: theme.textTheme.titleMedium,
                    ),
                    DefaultTextField(
                      labelText: 'Username',
                      formController: usernameController,
                    ),
                    DefaultTextField(
                      labelText: 'Email',
                      formController: emailController,
                    ),
                    Text(
                      'Unfortunately, if you have never given us your email,'
                      'we will not be able to reset your password.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          TextButton(
                              onPressed: () {
                                navigator.pushReplacementNamed(
                                    RecoverUserName.routeName);
                              },
                              child: SizedBox(
                                width: mediaQuery.size.width,
                                child: Text(
                                  'Forget username?',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize:
                                          16 * mediaQuery.textScaleFactor),
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                print('Having trouble');
                              },
                              child: SizedBox(
                                width: mediaQuery.size.width,
                                child: Text(
                                  'Having trouble?',
                                  style: TextStyle(
                                      fontSize: 16 * mediaQuery.textScaleFactor,
                                      color: ColorManager.primaryColor),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Button(
                      text: 'Email me',
                      boarderRadius: 50,
                      textColor: ColorManager.greyColor,
                      backgroundColor: ColorManager.blue,
                      buttonWidth: mediaQuery.size.width,
                      buttonHeight: mediaQuery.size.height * 0.08,
                      textFontSize: 18 * mediaQuery.textScaleFactor,
                      onPressed: () {
                        final user = LogInForgetModel(
                            type: 'password',
                            username: usernameController.text,
                            email: emailController.text);
                        DioHelper.postData(
                            path: loginForget, data: user.toJson());
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
