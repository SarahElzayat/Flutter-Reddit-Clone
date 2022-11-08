/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of recovering the username
///  if the user forgot his own username

import 'package:flutter/material.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/continue_button.dart';
import 'package:reddit/screens/to_go_screens/having_trouble_screen.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../data/sign_in_And_sign_up_models/login_forget_model.dart';
import '../sign_in_and_sign_up_screen/sign_in_screen.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';

// ignore: must_be_immutable
class RecoverUserName extends StatelessWidget {
  RecoverUserName({super.key});

  TextEditingController emailController = TextEditingController();

  static const routeName = '/recover_user_name_route';
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final textScaleFactor = mediaQuery.textScaleFactor;
    final customAppBar = LogInAppBar(
        sideBarButtonText: 'Log In',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(
            SignInScreen.routeName,
          );
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
                    DefaultTextField(
                        formController: emailController, labelText: 'Email'),
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
                                navigator.pushNamed(TroubleScreen.routeName);
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
                  child: ContinueButton(appliedFunction: () {
                    final user = LogInForgetModel(
                      email: emailController.text,
                      type: 'username',
                    );

                    DioHelper.postData(
                        path: loginForgetUserName, data: user.toJson());
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
