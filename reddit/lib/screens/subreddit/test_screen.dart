import 'package:flutter/material.dart';
import 'subreddit_screen_web.dart';
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
      home: const SubredditWeb(),
      // home: BlocProvider(
      //     create: ((context) => AddPostCubit()), child: const AddPost()),
    );
  }
}
