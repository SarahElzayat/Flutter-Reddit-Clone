import 'package:flutter/material.dart';
import './Components/color_manager.dart';
import './Screens/test_screen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.darkGrey,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: ColorManager.greyColor),
          alignLabelWithHint: true,
        ),
      ),
      home: TestScreen(),
    );
  }
}
