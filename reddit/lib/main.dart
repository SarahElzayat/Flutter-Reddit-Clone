import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/cubit/user_profile/cubit/user_profile_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../cubit/settings_cubit/settings_cubit.dart';
import '../../screens/bottom_navigation_bar_screens/home_screen.dart';
import '../../screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import '../../theme/theme_data.dart';
import '../../cubit/subreddit/cubit/subreddit_cubit.dart';
import '../../data/routes.dart';
import '../../screens/create_community_screen/cubit/create_community_cubit.dart';
import '../../screens/moderation/cubit/moderation_cubit.dart';

import 'constants/constants.dart';
import 'cubit/comment_notifier/comment_notifier_cubit.dart';
import 'screens/main_screen.dart';
import 'cubit/videos_cubit/videos_cubit.dart';

import 'cubit/post_notifier/post_notifier_cubit.dart';
import 'components/helpers/mocks/mock_functions.dart';
import 'cubit/add_post/cubit/add_post_cubit.dart';
import 'networks/dio_helper.dart';
import 'components/helpers/bloc_observer.dart';
import 'cubit/app_cubit/app_cubit.dart';
import 'screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import 'shared/local/shared_preferences.dart';

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

  CacheHelper.putData(key: 'SortHome', value: HomeSort.best.index);

  /// and this is used to initialize Dio
  DioHelper.init();
  // CacheHelper.putData(
  //     key: 'token',
  //     value:
  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MzlkY2Y3YzY2M2I3YmVhY2JmZDc3ZmYiLCJ1c2VybmFtZSI6InNhcmFoIiwiaWF0IjoxNjcxNTIwOTIxfQ.luFT51sAWl1kJr26xxsMAyoote3wV-3fWi0iCnvGuz0');
  token = CacheHelper.getData(key: 'token');

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => PostNotifierCubit()),
        BlocProvider(create: (context) => CommentNotifierCubit()),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => AddPostCubit()),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => CreateCommunityCubit()),
        BlocProvider(create: (context) => ModerationCubit()),
        BlocProvider(
          create: (context) => SubredditCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => UserProfileCubit(),
          lazy: false,
        ),
        BlocProvider(create: (context) => VideosCubit()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return MaterialApp(
                navigatorKey: navigatorKey,
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
