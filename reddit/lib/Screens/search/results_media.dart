/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the media results of the main search
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
