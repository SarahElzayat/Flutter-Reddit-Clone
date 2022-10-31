import 'package:flutter/material.dart';
import 'package:reddit/Components/color_manager.dart';
import 'package:reddit/posts/post_screen.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.black,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: ColorManager.greyColor),
          alignLabelWithHint: true,
        ),
      ),
      home: PostScreen(),
    );
  }
}
