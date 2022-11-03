/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of recovering the username
///  if the user forgot his own username

import 'package:flutter/material.dart';
import '../../screens/sign_in_and_sign_up_screen/sign_In_screen.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';
import '../../components/button.dart';

class RecoverUserName extends StatelessWidget {
  const RecoverUserName({super.key});
  static const routeName = '/recover_user_name_route';
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final customAppBar = LogInAppBar(
        sideBarButtonText: 'Log In',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(
            SignInScreen.routeName,
          );
        });

    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;
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
                height: mediaQuery.size.height * 0.55 -
                    mediaQuery.padding.top -
                    customAppBar.preferredSize.height,
                width: mediaQuery.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Recover username',
                      style: theme.textTheme.titleMedium,
                    ),
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
                                print('Having trouble');
                              },
                              child: SizedBox(
                                width: mediaQuery.size.width,
                                child: Text(
                                  'Having trouble?',
                                  style: TextStyle(
                                      fontSize: 16 * textScaleFactor,
                                      color: ColorManager.primaryColor),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: mediaQuery.size.height * 0.21 -
                    mediaQuery.padding.top -
                    customAppBar.preferredSize.height,
                width: mediaQuery.size.width,
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Button(
                          text: 'Email me',
                          boarderRadius: 50,
                          textColor: ColorManager.greyColor,

                          /// lets see how to fix that color later
                          backgroundColor: ColorManager.darkBlue,
                          buttonWidth: mediaQuery.size.width,
                          buttonHeight: mediaQuery.size.height * 0.08,
                          textFontSize: 18 * textScaleFactor,
                          onPressed: () {
                            print('Email Me');
                          }),
                    ),
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
