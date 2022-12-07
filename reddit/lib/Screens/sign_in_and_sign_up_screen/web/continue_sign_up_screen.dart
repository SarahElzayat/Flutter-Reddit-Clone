/// @author Abdelaziz Salah
/// @date 20/11/2022
/// this is the screen which the user navigate to when
/// he enter his email, and to continue the sign up process

import 'package:flutter/material.dart';
import 'package:reddit/screens/main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Components/Helpers/color_manager.dart';
import '../../../Components/default_text_field.dart';
import '../../../Data/sign_in_And_sign_up_models/sign_up_model.dart';
import '../../../Data/sign_in_And_sign_up_models/validators.dart';
import '../../../screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../shared/local/shared_preferences.dart';
import '../../bottom_navigation_bar_screens/home_screen.dart';

class ContinueSignUpScreen extends StatefulWidget {
  final email;
  const ContinueSignUpScreen({super.key, @required this.email});
  static const routeName = '/continue_sign_up_for_web_screen_route';

  @override
  State<ContinueSignUpScreen> createState() => _ContinueSignUpScreenState();
}

class _ContinueSignUpScreenState extends State<ContinueSignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _myKey = GlobalKey<FormState>();

  void selectUsernameFromSuggestions(username) {
    setState(() {
      usernameController.text = username;
    });
  }

  /// this function should validate that the input to the textfields
  /// are valid, else it will show a snackbar to the user
  /// telling him that he has inserted something wrong.
  bool validTextFields() {
    print('Enter Validations');
    if (!_myKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text('username or password are invalid')),
      );
      return false;
    }
    return true;
  }

  /// this function is used to validate that the user has inserted the right
  /// input formate and also send the request to the api
  void loginChecker() async {
    print('checker');

    if (!validTextFields()) return;

    final user = SignUpModel(
        // email: widget.email,
        email: 'widget.email',
        password: passwordController.text,
        username: usernameController.text);

    DioHelper.postData(path: signUp, data: user.toJson()).then((value) {
      print(value);
      if (value.statusCode == 200) {
        CacheHelper.putData(key: 'token', value: value.data['token']);
        CacheHelper.putData(key: 'username', value: value.data['username']);

        // navigating to the main screen
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        // TODO: think what should you do here ....
        /// 1- existing username -> show snackbar
        /// 2-
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return Scaffold(
      body: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return Container(
            constraints: BoxConstraints(minWidth: 1000),
            height: 100.h,
            width: 100.w,
            child: Form(
              key: _myKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: const EdgeInsets.all(30),
                        alignment: Alignment.centerLeft,
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Choose your username'),
                            const Text(
                                '''Your username is how other community members will see you. This name will be used to credit you for things you share on Reddit. What should we call you?'''),
                            const Divider(
                              color: ColorManager.white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30.w,
                                  child: Column(
                                    children: [
                                      DefaultTextField(
                                        validator: (username) {
                                          if (!Validator.validUserName(
                                              username!)) {
                                            return 'username must be greater than 2 characters and less than 21.';
                                          } else {
                                            return null;
                                          }
                                        },
                                        formController: usernameController,
                                        labelText: 'CHOOSE A USERNAME',
                                      ),
                                      DefaultTextField(
                                        validator: (password) {
                                          if (!Validator
                                              .validPasswordValidation(
                                                  password!)) {
                                            return 'password must be greater than 7 characters.';
                                          } else {
                                            return null;
                                          }
                                        },
                                        formController: passwordController,
                                        isPassword: true,
                                        labelText: 'PASSWORD',
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                              'Here are some username suggestions'),
                                          IconButton(
                                              onPressed: () {},
                                              icon:
                                                  const Icon(Icons.restart_alt))
                                        ],
                                      ),
                                      TextButton(
                                          onPressed: () =>
                                              selectUsernameFromSuggestions(
                                                  'Name1'),
                                          child: const Text(
                                            'Name1',
                                            style: TextStyle(
                                                color: ColorManager.blue,
                                                decoration:
                                                    TextDecoration.underline),
                                          )),
                                      TextButton(
                                          onPressed: () =>
                                              selectUsernameFromSuggestions(
                                                  'Name2'),
                                          child: const Text(
                                            'Name2',
                                            style: TextStyle(
                                                color: ColorManager.blue,
                                                decoration:
                                                    TextDecoration.underline),
                                          )),
                                      TextButton(
                                          onPressed: () =>
                                              selectUsernameFromSuggestions(
                                                  'Name3'),
                                          child: const Text(
                                            'Name3',
                                            style: TextStyle(
                                                color: ColorManager.blue,
                                                decoration:
                                                    TextDecoration.underline),
                                          )),
                                      TextButton(
                                          onPressed: () =>
                                              selectUsernameFromSuggestions(
                                                  'Name4'),
                                          child: const Text(
                                            'Name4',
                                            style: TextStyle(
                                                color: ColorManager.blue,
                                                decoration:
                                                    TextDecoration.underline),
                                          )),
                                      TextButton(
                                          onPressed: () =>
                                              selectUsernameFromSuggestions(
                                                  'Name5'),
                                          child: const Text(
                                            'Name5',
                                            style: TextStyle(
                                                color: ColorManager.blue,
                                                decoration:
                                                    TextDecoration.underline),
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Container(
                      width: 100.w,
                      height: 5.h,
                      decoration: const BoxDecoration(color: ColorManager.grey),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  navigator.pushReplacementNamed(
                                      SignUpForWebScreen.routeName);
                                },
                                child: const Text('Back')),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(5),
                              width: 140,
                              child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorManager.blue)),
                                  onPressed: () {
                                    print(
                                        'username = ${usernameController.text} and password = ${passwordController.text}');
                                    print(usernameController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty);
                                    (usernameController.text.isNotEmpty &&
                                            passwordController.text.isNotEmpty)
                                        ? loginChecker()
                                        : () {};
                                  },
                                  child: const Text('SIGN UP')),
                            )
                          ]),
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }
}
