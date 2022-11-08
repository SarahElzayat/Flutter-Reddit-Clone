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
