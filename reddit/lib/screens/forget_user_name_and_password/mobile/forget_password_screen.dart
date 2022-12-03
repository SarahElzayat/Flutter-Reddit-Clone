/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is the screen of recovering the password
///  if the user forgot his own username

import 'package:flutter/material.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';
import '../../../screens/to_go_screens/having_trouble_screen.dart';
import '../../sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/continue_button.dart';
import '../../../data/sign_in_And_sign_up_models/login_forget_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../screens/forget_user_name_and_password/mobile/recover_username.dart';
import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../widgets/sign_in_and_sign_up_widgets/app_bar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static const routeName = '/forget_password_screen_route';

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool isEmptyUsername = true;

  bool isEmptyEmail = true;

  /// this is the key for the implemented form, in order to be able to apply
  /// some validatations in the forms and show some animations.
  final _formKey = GlobalKey<FormState>();

  /// this is a utility function used to check whethere
  /// the user has inserted correct formate for the mail or not
  /// @return [True] if the formate of the email is correct
  /// @return [False] otherwise
  bool _validateTextFields() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text(
                'Try inserting a valid and existing email address and user name.')),
      );
      return false;
    }
    return true;
  }

  /// this method is responsible for sending the request to the backend
  /// to send a mail to the user in order to restore his username.
  void sendRequest() {
    if (!_validateTextFields()) {
      return;
    } else {
      // creating a model
      final user = LogInForgetModel(
        email: emailController.text,
        username: usernameController.text,
        type: 'password',
      );

      // sending a request
      DioHelper.postData(path: loginForgetUserName, data: user.toJson())
          .then((response) {
        // if the request has been sent successfully?
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email has been sent!'),
            backgroundColor: ColorManager.green,
          ));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('this email or username doesn\'t exists'),
          backgroundColor: ColorManager.red,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final theme = Theme.of(context);
    final customAppBar = LogInAppBar(
        key: const Key('LogInButton'),
        sideBarButtonText: 'Log In',
        sideBarButtonAction: () {
          navigator.pushReplacementNamed(SignInScreen.routeName);
        });
    return Scaffold(
      appBar: customAppBar,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                        validator: (username) {
                          if (!Validator.validUserName(username!)) {
                            return 'The username length should be less than 21 and greater than 2 ';
                          }
                          return null;
                        },
                        // here if the controller detected any words i toggle the
                        // boolean
                        onChanged: (myString) {
                          setState(() {
                            if (myString.isNotEmpty) {
                              isEmptyUsername = false;
                            } else {
                              isEmptyUsername = true;
                            }
                          });
                        },
                        icon: isEmptyUsername
                            ? null
                            : IconButton(
                                key: const Key('ClearUsernameButton'),
                                onPressed: () => setState(() {
                                      isEmptyUsername = true;
                                      usernameController.text = '';
                                    }),
                                icon: const Icon(Icons.clear)),
                        formController: usernameController,
                      ),
                      DefaultTextField(
                        key: const Key('EmailTextField'),
                        labelText: 'Email',
                        validator: (email) {
                          if (!Validator.validEmailValidator(email!)) {
                            return 'This mail format is incorrect';
                          }
                          return null;
                        },
                        onChanged: (myString) {
                          setState(() {
                            if (myString.isNotEmpty) {
                              isEmptyEmail = false;
                            } else {
                              isEmptyEmail = true;
                            }
                          });
                        },
                        icon: isEmptyEmail
                            ? null
                            : IconButton(
                                key: const Key('ClearEmailButton'),
                                onPressed: () => setState(() {
                                      isEmptyEmail = true;
                                      emailController.text = '';
                                    }),
                                icon: const Icon(Icons.clear)),
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
                                key: const Key('ForgetUserNameButton'),
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
                                key: const Key('HavingTroubleButton'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(TroubleScreen.routeName);
                                },
                                child: SizedBox(
                                  width: mediaQuery.size.width,
                                  child: Text(
                                    'Having trouble?',
                                    style: TextStyle(
                                        fontSize:
                                            16 * mediaQuery.textScaleFactor,
                                        color: ColorManager.primaryColor),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ContinueButton(
                    buttonContent: 'Email me',
                    key: const Key('EmailMeButton'),
                    isPressable: usernameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty,
                    appliedFunction: sendRequest)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
