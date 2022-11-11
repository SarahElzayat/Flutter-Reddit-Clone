/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the comments results of the main search
import 'package:flutter/material.dart';


class ResultsComments extends StatefulWidget {
  const ResultsComments({super.key});

  @override
  State<ResultsComments> createState() => _ResultsCommentsState();
}

class _ResultsCommentsState extends State<ResultsComments> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Comments',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
