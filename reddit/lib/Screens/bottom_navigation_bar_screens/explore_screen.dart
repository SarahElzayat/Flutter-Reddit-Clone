/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the explore.
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  static const routeName = '/explore_screen_route';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Explore SCREEN',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
