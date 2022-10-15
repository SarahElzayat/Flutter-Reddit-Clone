// fen el comments wl @author wl date ya hanem ?

import 'package:flutter/material.dart';

/// always make the path relative not the absolute path

/// don't
// import 'package:first_task/posts.dart';

/// do
import './posts.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.purple[50],
      ),
      home: Posts(),
    );
  }
}
