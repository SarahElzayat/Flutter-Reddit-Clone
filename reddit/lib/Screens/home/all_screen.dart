import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllScreen extends StatelessWidget {
  const AllScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return const Center(
      child: Text(
        'All SCREEN',
        style: TextStyle(fontSize: 50, color: Colors.white),
      ),
    );
  }
}