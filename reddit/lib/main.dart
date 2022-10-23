import 'package:flutter/material.dart';
import 'package:reddit/components/text_fields.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: defaultTextField(),
        ),
      ),
    );
  }
}
