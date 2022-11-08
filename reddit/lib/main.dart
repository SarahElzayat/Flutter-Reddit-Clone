import 'package:flutter/material.dart';
import 'package:reddit/Components/helpers/color_manager.dart';
import 'package:reddit/posts/post_test_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:reddit/screens/testing_screen.dart';

import 'components/helpers/color_manager.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
              ),
              bodyMedium:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      home: ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorManager.black,
            inputDecorationTheme: const InputDecorationTheme(
              hintingStyle: TextStyle(color: ColorManager.grey),
              alignLabelWithHint: true,
            ),
          ),
          home: const PostTestScreen(),
        );
      },
    ),
    );
    ;
  }
}
