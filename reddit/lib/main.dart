import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import './screens/forget_user_name_and_password/forget_password_screen.dart';
import './screens/forget_user_name_and_password/recover_username.dart';
import './screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import './screens/sign_in_and_sign_up_screen/mobile/sign_up_screen.dart';
import './screens/to_go_screens/having_trouble_screen.dart';
import './screens/to_go_screens/privacy_and_policy.dart';
import '/screens/testing_screen.dart';
import 'networks/dio_helper.dart';

void main() {
  /// this is used to insure that every thing has been initialized well
  WidgetsFlutterBinding.ensureInitialized();

  /// and this is used to initialized Dio
  DioHelper.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        PrivacyAndPolicy.routeName: (ctx) => const PrivacyAndPolicy(),
        TroubleScreen.routeName: (ctx) => const TroubleScreen(),
        RecoverUserName.routeName: (ctx) => RecoverUserName(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        SignInScreen.routeName: (ctx) => SignInScreen(),
        ForgetPasswordScreen.routeName: (ctx) => ForgetPasswordScreen(),
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
