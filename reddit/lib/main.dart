
import 'dart:io';

import 'package:flutter/material.dart';

import './components/helpers/color_manager.dart';
import './screens/forget_user_name_and_password/forget_password_screen.dart';
import './screens/forget_user_name_and_password/recover_username.dart';
import './screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import './screens/sign_in_and_sign_up_screen/mobile/sign_up_screen.dart';
import './screens/to_go_screens/having_trouble_screen.dart';
import './screens/to_go_screens/privacy_and_policy.dart';
import '/screens/testing_screen.dart';
import 'networks/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Components/helpers/color_manager.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/forget_user_name_and_password/recover_username.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'components/helpers/bloc_observer.dart';
import 'cubit/app_cubit.dart';
import 'screens/forget_user_name_and_password/forget_password_screen.dart';
import 'screens/main_screen.dart';
import 'screens/sign_in_and_sign_up_screen/sign_In_screen.dart';
import 'screens/sign_in_and_sign_up_screen/sign_up_screen.dart';
import 'screens/testing_screen.dart';
import 'shared/local/shared_preferences.dart';
import 'theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  } catch (e) {
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
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return MaterialApp(
                initialRoute: '/',
                routes: {
                  RecoverUserName.routeName: (ctx) => RecoverUserName(),
                  SignUpScreen.routeName: (ctx) => SignUpScreen(),
                  SignInScreen.routeName: (ctx) => SignInScreen(),
                  ForgetPasswordScreen.routeName: (ctx) =>
                      ForgetPasswordScreen(),
                },
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(
                      builder: (ctx) => const MainScreen());
                },
                debugShowCheckedModeBanner: false,
                theme: appTheme(),
              );
            },
          );
        },
      ),
    );
  }
}
