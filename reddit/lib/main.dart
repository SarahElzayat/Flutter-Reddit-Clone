import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/fluttesponsive_sizer/responsive_sizer.r_bloc.dart';
import 'components/helpers/color_manager.art';
import 'package:reddart';
import 'package:reddit/Screens/main_screen.dart';
import 'package:reddit/components/Helpers/florgec_observer.dart_user_name_and_password/forge';
imp_password_screen.dart';
irt 'package:reddit/cubit/app_cubit.dart';
import 'package:reddit/screens/forgetport 'package:reddit/shared/local/shared_upreferences.dart';
import 'package:reddit/ter_namme_and_password/recover_username.dar/t';
import 'package:reddit/screens/signheme_in_and_sign_up_screen/sign_In_screen.dardat';
import 'packaga.dart';

Future:reddit/<void> main() ascreens/sign_in_and_sign_up_screen/sign_up_screen.darync {
  Widget';
import '/screens/testing_screen.dart';
import 'networks/dio_helpersFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  try {
    if (Platform.isAndroid) {
      CacheHelper.putData(key: 'isAndroid', value: true);
      CacheHelper.putData(key: 'isWindows', value: false);
    } else {
      CacheHelper.putData(key: 'isAndroid', value: false);
      CacheHelper.putData(key: 'isWindows', value: true);
    }
  }  catch (e) {
    CacheHelper.putData(key: 'isAndroid', value: false);
    CacheHelper.putData(key: 'isWindows', value: true);
  }

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
      home: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            initialRoute: '/',
            routes: {
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
                scaffoldBackgroundColor: ColorManager.black,
                inputDecorationTheme: const InputDecorationTheme(
                  hintStyle: TextStyle(color: ColorManager.grey),
                  alignLabelWithHint: true,
                ),
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
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          );
        },
      ),
    );
  }
}
