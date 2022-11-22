/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the people results of the main search
import 'package:flutter/material.dart';

class ResultsPeople extends StatefulWidget {
  const ResultsPeople({super.key});

  @override
  State<ResultsPeople> createState() => _ResultsPeopleState();
}

class _ResultsPeopleState extends State<ResultsPeople> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'People',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
