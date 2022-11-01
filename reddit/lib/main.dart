import 'package:flutter/material.dart';
import 'package:reddit/screens/testing_screen.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const TestingScreen();
  }
}
