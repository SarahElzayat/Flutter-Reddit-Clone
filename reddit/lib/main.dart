import 'package:flutter/material.dart';
import 'package:reddit/Components/helpers/color_manager.dart';
import 'package:reddit/posts/post_test_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: ColorManager.black,
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: ColorManager.grey),
              alignLabelWithHint: true,
            ),
          ),
          home: const PostTestScreen(),
        );
      },
    );
  }
}
