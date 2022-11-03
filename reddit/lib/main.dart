import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/screens/forget_user_name_and_password/forget_password_screen.dart';
import 'package:reddit/screens/forget_user_name_and_password/recover_username.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/sign_In_screen.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/sign_up_screen.dart';
import '/screens/testing_screen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        RecoverUserName.routeName: (ctx) => const RecoverUserName(),
        SignUpScreen.routeName: (ctx) => const SignUpScreen(),
        SignInScreen.routeName: (ctx) => const SignInScreen(),
        ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const TestingScreen());
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme(
            onError: ColorManager.white,
            brightness: Brightness.dark,
            primaryContainer: ColorManager.blue,
            secondaryContainer: ColorManager.blue,
            inverseSurface: ColorManager.blue,
            errorContainer: ColorManager.white,
            background: ColorManager.blue,
            onSurface: ColorManager.white,
            primary: ColorManager.white,
            secondary: ColorManager.white,
            surface: ColorManager.white,
            error: ColorManager.white,
            onBackground: ColorManager.white,
            onPrimary: ColorManager.white,
            onSecondary: ColorManager.white,
            outline: ColorManager.white,
          ),
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorManager.eggshellWhite,
              ),
              bodyMedium:
                  TextStyle(fontSize: 16, color: ColorManager.eggshellWhite))),
      home: const TestingScreen(),
    );
  }
}
