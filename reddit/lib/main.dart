/// this is a scrollable screen contains some posts
/// @author Abdelaziz Salah
/// @date 14/10/2022

import 'package:flutter/material.dart';
import 'Widgets/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(
          textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(
                fontSize: 18,
              ),
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        blurRadius: 100,
                        color: Colors.black,
                        offset: Offset(10, 10))
                  ]))),
    );
  }
}
