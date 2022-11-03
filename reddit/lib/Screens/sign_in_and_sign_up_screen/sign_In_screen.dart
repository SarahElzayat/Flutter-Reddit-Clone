import 'package:flutter/material.dart';
import 'package:reddit/screens/forget_user_name_and_password/forget_password_screen.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/sign_up_screen.dart';
import '../../components/default_text_field.dart';
import '../../components/button.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const routeName = '/sign_in_route';
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
              const Expanded(
                child: Text(
                  textAlign: TextAlign.center,
                  'Log in to Reddit',
                  // style: theme.textTheme.titleMedium,
                  style: TextStyle(
                    fontSize: 24,
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
                          textFontSize: 18,
                          onPressed: () {},
                          boarderRadius: 20,
                          borderColor: ColorManager.white,
                          textFontWeight: FontWeight.bold),
                      Button(
                          text: 'Continue with Facebook',
                          textColor: ColorManager.white,
                          backgroundColor: ColorManager.darkGrey,
                          buttonWidth: mediaQuery.size.width * 0.9,
                          buttonHeight: mediaQuery.size.height * 0.05,
                          textFontSize: 18,
                          onPressed: () {},
                          boarderRadius: 20,
                          borderColor: ColorManager.white,
                          textFontWeight: FontWeight.bold),
                      const Text(
                        'OR',
                        style: TextStyle(
                          color: ColorManager.greyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const DefaultTextField(
                      labelText: 'Username',
                    ),
                    const DefaultTextField(
                      labelText: 'Password',
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
                          child: const Text(
                            'Forgot password',
                            style: TextStyle(
                                color: ColorManager.primaryColor, fontSize: 14),
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
                          textFontSize: 14,
                          onPressed: () {}),
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

// buttonHeight:
// buttonWidth: ,
// onPressed: () {},
// text: 'Continue with Google',
// textColor: ColorManager.white,
// textFontSize: 18,
// boarderRadius: 2,
// borderColor: ColorManager.white,
// textFontWeight: FontWeight.bold,
