/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the posts results of the main search
import 'package:flutter/material.dart';


class ResultsPosts extends StatefulWidget {
  const ResultsPosts({super.key});

  @override
  State<ResultsPosts> createState() => _ResultsPostsState();
}

class _ResultsPostsState extends State<ResultsPosts> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Posts',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
