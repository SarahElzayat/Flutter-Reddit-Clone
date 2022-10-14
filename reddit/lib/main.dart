import 'package:flutter/material.dart';
import 'package:reddit/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',

      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18 
          )
        ),
        primarySwatch: Colors.deepPurple,
      ),
      home:  PostsScreen()
    );
  }
}

