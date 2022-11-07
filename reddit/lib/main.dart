import 'package:flutter/material.dart';
import 'package:reddit/screens/bottom_sheet_test.dart';
import 'package:reddit/components/Button.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SizedBox(
            child: Button(
                text: 'text',
                textColor: Colors.white,
                backgroundColor: Colors.green,
                buttonWidth: 400,
                buttonHeight: 200,
                textFontSize: 20,
                onPressed: () {}),
          ),
        ),
      ),
    );
  }
}
