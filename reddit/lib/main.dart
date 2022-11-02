import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import '/screens/testing_screen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
              titleMedium: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: ColorManager.eggshellWhite,
              ),
              bodyMedium:
                  TextStyle(fontSize: 16, color: ColorManager.eggshellWhite))),
      home: const TestingScreen(),
    );
  }
}
