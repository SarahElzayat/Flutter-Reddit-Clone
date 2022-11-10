/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the communities results of the main search
import 'package:flutter/material.dart';


class ResultsCommunities extends StatefulWidget {
  const ResultsCommunities({super.key});

  @override
  State<ResultsCommunities> createState() => _ResultsCommunitiesState();
}

class _ResultsCommunitiesState extends State<ResultsCommunities> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Communities',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
