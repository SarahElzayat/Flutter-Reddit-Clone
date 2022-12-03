import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/add_post/video_trimmer.dart';

import 'Screens/add_post/image_screen.dart';
import 'Screens/add_post/paint_screen.dart';
import 'cubit/add_post/cubit/add_post_cubit.dart';
import 'screens/add_post/add_post.dart';
import 'screens/add_post/post.dart';

class AppRouter {
  static final AddPostCubit _addPostCubit = AddPostCubit();
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

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
