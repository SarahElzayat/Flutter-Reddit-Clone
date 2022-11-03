import 'package:flutter/material.dart';
import 'package:reddit/screens/forget_user_name_and_password/recover_username.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/sign_In_screen.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';
import '../../components/button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  static const routeName = '/forget_password_screen_route';
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
                    const DefaultTextField(labelText: 'Username'),
                    const DefaultTextField(labelText: 'Email'),
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
                                child: const Text(
                                  'Having trouble?',
                                  style: TextStyle(
                                      fontSize: 16,
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
                      textFontSize: 18,
                      onPressed: () {
                        print('Email Me');
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
