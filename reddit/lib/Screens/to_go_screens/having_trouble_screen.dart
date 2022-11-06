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
