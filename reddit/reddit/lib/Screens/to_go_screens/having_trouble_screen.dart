/// @author Abdelaziz Salah
/// @date 6/11/2022
/// this is a screen contianing having trouble notes
import 'package:flutter/material.dart';

/// to be implemented
class TroubleScreen extends StatelessWidget {
  static const routeName = '/trouble_screen_route';
  const TroubleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Having Trouble'),
      ),
    );
  }
}
