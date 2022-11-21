import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Screens/create_community_screen.dart';
import 'package:reddit/Screens/moderation/general_screens/description.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'networks/dio_helper.dart';
import 'components/helpers/bloc_observer.dart';
import 'cubit/app_cubit.dart';
import 'shared/local/shared_preferences.dart';
import 'theme/theme_data.dart';

import 'screens/forget_user_name_and_password/forget_password_screen.dart';
import 'screens/forget_user_name_and_password/recover_username.dart';
import 'screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import 'screens/sign_in_and_sign_up_screen/mobile/sign_up_screen.dart';
import 'screens/main_screen.dart';

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
                  RecoverUserName.routeName: (ctx) => const RecoverUserName(),
                  SignUpScreen.routeName: (ctx) => SignUpScreen(),
                  SignInScreen.routeName: (ctx) => const SignInScreen(),
                  ForgetPasswordScreen.routeName: (ctx) =>
                      const ForgetPasswordScreen(),
                },
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(
                      builder: (ctx) => const CreateCommunityScreen());
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
