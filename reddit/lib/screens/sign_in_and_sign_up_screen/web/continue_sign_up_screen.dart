/// @author Abdelaziz Salah
/// @date 20/11/2022
/// this is the screen which the user navigate to when
/// he enter his email, and to continue the sign up process
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/settings/settings_models/user_settings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../data/sign_in_And_sign_up_models/sign_up_model.dart';
import '../../../data/sign_in_And_sign_up_models/validators.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';
import '../../../shared/local/shared_preferences.dart';
import '../../main_screen.dart';

class ContinueSignUpScreen extends StatefulWidget {
  const ContinueSignUpScreen({super.key});
  static const routeName = '/continue_sign_up_for_web_screen_route';

  @override
  State<ContinueSignUpScreen> createState() => _ContinueSignUpScreenState();
}

class _ContinueSignUpScreenState extends State<ContinueSignUpScreen> {
  @override
  void initState() {
    getRandomNames();
    super.initState();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _myKey = GlobalKey<FormState>();

  /// this function is used to select the username from the suggestions
  /// and put it in the textfield.
  /// @param [username]: the username which the user has selected from the suggestions
  void selectUsernameFromSuggestions(username) {
    setState(() {
      usernameController.text = username;
    });
  }

  /// this function should validate that the input to the textfields
  /// are valid, else it will show a snackbar to the user
  /// telling him that he has inserted something wrong.
  bool validTextFields() {
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
  void loginChecker(_myMail) async {
    if (!validTextFields()) return;

    final user = SignUpModel(
        email: _myMail, // we get it from the navigation
        password: passwordController.text,
        username: usernameController.text);

    await DioHelper.postData(path: signUp, data: user.toJson()).then((value) {
      if (value.statusCode == 201) {
        CacheHelper.putData(key: 'token', value: value.data['token']);
        CacheHelper.putData(key: 'username', value: value.data['username']);
        UserSettingsModel.fromJson(value.data);
        UserSettingsModel.cacheUserSettings();
        token = CacheHelper.getData(key: 'token');
        // navigating to the main screen
        Navigator.of(context)
            .pushReplacementNamed(HomeScreenForMobile.routeName);
      }
    }).catchError((error) {
      // casting the error as a dio error to be able to use its content
      error = error as DioError;
      // checking for our main error, which is that the user trying to insert
      // username which is already taken
      if (error.message.toString() == 'Http status error [400]') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: ColorManager.red,
              content: Text('Username is already in use')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: ColorManager.red,
              content: Text(
                  'Something went wrong!, please change the inputs and try again')),
        );
      }
    });
  }

  /// this function is used to get random names from the backend.
  void getRandomNames() async {
    await DioHelper.getData(path: getRandom, query: {'count': 5})
        .then((response) {
      if (response.statusCode == 200) {
        setState(() {
          List<String> myList = [];
          for (String name in response.data['usernames']) {
            myList.add(name);
          }
          dummyNames.clear();
          dummyNames.addAll(myList);
        });
      }
    }).catchError((error) {
      error = error as DioError;
    });
  }

  List<String> dummyNames = [
    'Name1',
    'Name2',
    'Name3',
    'Name4',
    'Name5',
  ];

  @override
  Widget build(BuildContext context) {
    final _myMail = ModalRoute.of(context)!.settings.arguments as String;
    final navigator = Navigator.of(context);
    return Scaffold(
      body: MediaQuery.of(context).size.height < 400
          ? const Center(
              child: Scaffold(
                  body: Center(
                      child: Text('Increse the size of the window please'))),
            )
          : ResponsiveSizer(
              builder: (context, orientation, screenType) {
                return Container(
                  constraints: const BoxConstraints(minWidth: 1000),
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
                                  const Text(
                                    'Choose your username',
                                    style: TextStyle(
                                        color: ColorManager.upvoteRed),
                                  ),
                                  const Text(
                                    '''Your username is how other community members will see you. This name will be used to credit you for things you share on Reddit. What should we call you?''',
                                    style: TextStyle(
                                      color: ColorManager.blue,
                                    ),
                                  ),
                                  const Divider(
                                    color: ColorManager.white,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 30.w,
                                        child: Column(
                                          children: [
                                            DefaultTextField(
                                              onChanged: (p0) =>
                                                  setState(() {}),
                                              key: const Key(
                                                  'UsernameTextField'),
                                              validator: (username) {
                                                if (!Validator.validUserName(
                                                    username!)) {
                                                  return 'username must be greater than 2 characters and less than 21.';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              formController:
                                                  usernameController,
                                              labelText: 'CHOOSE A USERNAME',
                                            ),
                                            DefaultTextField(
                                              onChanged: (p0) =>
                                                  setState(() {}),
                                              key: const Key(
                                                  'PasswordTextField'),
                                              validator: (password) {
                                                if (!Validator
                                                    .validPasswordValidation(
                                                        password!)) {
                                                  return 'password must be greater than 7 characters.';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              formController:
                                                  passwordController,
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
                                                    onPressed: getRandomNames,
                                                    icon: const Icon(
                                                        Icons.restart_alt))
                                              ],
                                            ),
                                            ...dummyNames.map((item) {
                                              return TextButton(
                                                onPressed: () =>
                                                    selectUsernameFromSuggestions(
                                                        item),
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      color: ColorManager.blue,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                              );
                                            }).toList(),
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
                            decoration:
                                const BoxDecoration(color: ColorManager.grey),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      key: const Key('BackButton'),
                                      onPressed: () {
                                        navigator.pushReplacementNamed(
                                            SignUpForWebScreen.routeName);
                                      },
                                      child: const Text(
                                        'Back',
                                        style:
                                            TextStyle(color: ColorManager.blue),
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.all(5),
                                      width: 140,
                                      child: ElevatedButton(
                                        key: const Key('SignUpButton'),
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStatePropertyAll(
                                              (usernameController
                                                          .text.isNotEmpty &&
                                                      passwordController
                                                          .text.isNotEmpty)
                                                  ? ColorManager.white
                                                  : ColorManager.eggshellWhite,
                                            ),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              (usernameController
                                                          .text.isNotEmpty &&
                                                      passwordController
                                                          .text.isNotEmpty)
                                                  ? ColorManager.blue
                                                  : ColorManager.grey,
                                            )),
                                        onPressed: () {
                                          (usernameController.text.isNotEmpty &&
                                                  passwordController
                                                      .text.isNotEmpty)
                                              ? loginChecker(_myMail)
                                              : () {};
                                        },
                                        child: const Text('SIGN UP',
                                            style: TextStyle(
                                                color: ColorManager
                                                    .eggshellWhite)),
                                      ))
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
