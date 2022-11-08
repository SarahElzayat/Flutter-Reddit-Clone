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
