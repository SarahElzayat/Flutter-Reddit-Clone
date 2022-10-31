import 'package:flutter/material.dart';
import 'package:reddit/Screens/bottom_sheet_test.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TestScreen();
  }
}
