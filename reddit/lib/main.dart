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
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorManager.white,
              ),
              bodyMedium:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      home: const TestingScreen(),
    );
  }
}
