import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Components/helpers/color_manager.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/add_post_screen.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/explore_screen.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/inbox_screen.dart';
import 'package:reddit/Screens/search/search_results_main_screen.dart';
import 'package:reddit/Screens/search/search_screen.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/forget_user_name_and_password/recover_username.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Screens/bottom_navigation_bar_screens/notifications_screen.dart';
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
                initialRoute: '/main_screen_route',
                routes: {
                  RecoverUserName.routeName: (ctx) => RecoverUserName(),
                  SignUpScreen.routeName: (ctx) => SignUpScreen(),
                  SignInScreen.routeName: (ctx) => SignInScreen(),
                  ForgetPasswordScreen.routeName: (ctx) =>
                      ForgetPasswordScreen(),

                  MainScreen.routeName: (ctx) => const MainScreen(),
                  //bottom navigation bar screens
                  HomeScreen.routeName: (ctx) => const HomeScreen(),
                  InboxScreen.routeName: (ctx) => const InboxScreen(),
                  AddPostScreen.routeName: (ctx) => const AddPostScreen(),
                  ExploreScreen.routeName: (ctx) => const ExploreScreen(),
                  NotificationsScreen.routeName: (ctx) =>
                      const NotificationsScreen(),

                  SearchScreen.routeName: (ctx) => const SearchScreen(),
                  SearchResults.routeName: (ctx) => const SearchResults(
                        searchWord: '',
                      ),
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
