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
