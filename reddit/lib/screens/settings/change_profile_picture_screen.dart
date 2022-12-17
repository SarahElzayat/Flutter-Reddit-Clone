import 'package:flutter/material.dart';

class ChangeProfilePicutre extends StatefulWidget {
  const ChangeProfilePicutre({super.key});

  @override
  State<ChangeProfilePicutre> createState() => _ChangeProfilePicutreState();
}

class _ChangeProfilePicutreState extends State<ChangeProfilePicutre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change profile picture'),
        centerTitle: true,
      ),
    );
  }
}
