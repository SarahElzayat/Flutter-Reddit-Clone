import 'package:flutter/material.dart';
import 'package:reddit/screens/settings/settings_main_screen.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Settings'),
            ),
            body: const SettingsMainScreen()));
  }
}
