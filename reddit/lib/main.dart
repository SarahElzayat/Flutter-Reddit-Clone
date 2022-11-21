import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Screens/main_screen.dart';
import 'package:reddit/Screens/sign_in_and_sign_up_screen/mobile/sign_In_screen.dart';
import 'package:reddit/Screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import 'package:reddit/cubit/add_post.dart/cubit/add_post_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'data/routes.dart';
import 'networks/dio_helper.dart';
import 'components/helpers/bloc_observer.dart';
import 'screens/bottom_navigation_bar_screens/home_screen.dart';
import 'shared/local/shared_preferences.dart';
import 'theme/theme_data.dart';
import 'cubit/app_cubit.dart';

Future<void> main() async {
  /// this is used to insure that every thing has been initialized well

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

  /// and this is used to initialized Dio
  DioHelper.init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => AddPostCubit()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return MaterialApp(
                initialRoute: CacheHelper.getData(key: 'isWindows')
                    ? SignInForWebScreen.routeName
                    : SignInScreen.routeName,
                routes: myRoutes,
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
