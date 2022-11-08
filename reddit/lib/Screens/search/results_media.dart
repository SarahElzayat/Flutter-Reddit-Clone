import 'package:flutter/material.dart';


class ResultsMedia extends StatefulWidget {
  const ResultsMedia({super.key});

  @override
  State<ResultsMedia> createState() => _ResultsMediaState();
}

class _ResultsMediaState extends State<ResultsMedia> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'MEDIA',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
