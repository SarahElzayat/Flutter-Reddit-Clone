/// @author Abdelaziz Salah
/// @date 26/10/2022
/// testing screen to test that the ListTile is working correctly

import 'package:flutter/material.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/mobile/sign_In_screen.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen();
  }
}
