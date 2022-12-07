import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Screens/history/history_screen.dart';
import 'package:reddit/Screens/history/history_screen_for_web.dart';
import 'package:reddit/cubit/app_cubit.dart';
import 'screens/add_post/video_trimmer.dart';

import 'cubit/add_post/cubit/add_post_cubit.dart';
import 'screens/add_post/add_post.dart';
import 'screens/add_post/post.dart';
import 'screens/add_post/image_screen.dart';
import 'screens/add_post/paint_screen.dart';

class AppRouter {
  static final AddPostCubit _addPostCubit = AddPostCubit();
  static final AppCubit _appCubit = AppCubit();
  // late InternetCubit _internetCubit;
  // late CounterCubit _counterCubit;

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addPostCubit,
                  child: const AddPost(),
                ));
      case '/image_screen_route':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addPostCubit,
                  child: ImageScreen(),
                ));

      case '/paint_screen_route':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addPostCubit,
                  child: PaintScreen(),
                ));

      case '/trimmerView_screen_route':
        return MaterialPageRoute(builder: (_) {
          print('Go to Video Trimeer');
          return BlocProvider.value(
            value: _addPostCubit,
            child: const TrimmerView(),
          );
        });

      case '/postSimpleScreen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _addPostCubit,
            child: const PostSimpleScreen(),
          );
        });

      case '/history_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _appCubit,
            child: const HistoryScreen(bottomNavBarScreenIndex: 0),
          );
        });

      case '/history_screen_web':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _appCubit,
            child: const HistoryScreenForWeb(),
          );
        });
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
