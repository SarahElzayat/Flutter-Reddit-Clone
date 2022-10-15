/// where are the author and date and description comments ya hanem ??

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

        /// remove these comments if you are not gonna use it again
        // title: 'Flutter Demo',

        theme: ThemeData(
          textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 18)),
          primarySwatch: Colors.deepPurple,
        ),

        /// use routes instead of home b3d keda ahsan
        home: PostsScreen());
  }
}
