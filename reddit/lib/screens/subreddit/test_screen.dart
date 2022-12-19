import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';
import 'package:reddit/screens/subreddit/subreddit_screen_web.dart';
import '../../router.dart';
import '../../theme/theme_data.dart';

void main() {
  runApp(const AddPostTestScreen());
}

class AddPostTestScreen extends StatelessWidget {
  const AddPostTestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Subreddit Test Screen',
      theme: appTheme(),
      // onGenerateRoute: AppRouter.onGenerateRoute,
      home: SubredditWeb(),
      // home: BlocProvider(
      //     create: ((context) => AddPostCubit()), child: const AddPost()),
    );
  }
}
