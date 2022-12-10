import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';
import 'package:reddit/screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import 'constants/constants.dart';
import 'cubit/post_notifier/post_notifier_cubit.dart';
import 'screens/main_screen.dart';

import 'package:reddit/screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'components/helpers/mocks/mock_functions.dart';

import 'cubit/add_post/cubit/add_post_cubit.dart';
import 'data/routes.dart';
import 'networks/dio_helper.dart';
import 'components/helpers/bloc_observer.dart';
import 'cubit/app_cubit.dart';
import 'shared/local/shared_preferences.dart';
import 'theme/theme_data.dart';

Future<void> main() async {
  /// it defines the mocks APIS endpoints
  prepareMocks();

  /// this is used to insure that every thing has been initialized well
  // enableFlutterDriverExtension();
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

  /// and this is used to initialize Dio
  DioHelper.init();
  token = CacheHelper.getData(key: 'token');

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => PostNotifierCubit(),
        ),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => AddPostCubit()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return MaterialApp(
                /// TODO: this should be changed to be checked automatically

                initialRoute:
                    CacheHelper.getData(key: 'token')?.toString().isNotEmpty ??
                            false
                        ? kIsWeb
                            ? HomeScreen.routeName
                            : HomeScreenForMobile.routeName
                        : !kIsWeb
                            ? SignInScreen.routeName
                            : SignInForWebScreen.routeName,

                routes: myRoutes,
                onUnknownRoute: (settings) {
                  return MaterialPageRoute(
                      builder: (ctx) => kIsWeb
                          ? const HomeScreen()
                          : const HomeScreenForMobile());
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
