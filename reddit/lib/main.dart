import 'package:flutter/material.dart';

import 'components/default_text_field.dart';
import 'components/square_text_field.dart';
import 'consts/colors.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: greyColor),
          alignLabelWithHint: true,
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DefaultTextField(labelText: 'Normal'),
                const SizedBox(height: 30),
                const DefaultTextField(
                    labelText: 'Description', maxLength: 500, multiLine: true),
                const SizedBox(height: 30),
                DefaultTextField(
                  labelText: 'Password',
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: darkBlueColor,
                    ),
                  ),
                ),
                DefaultTextField(
                  labelText: 'New Password',
                  obscureText: true,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    color: greyColor,
                  ),
                ),
                const SizedBox(height: 30),
                const SquareTextField(
                    labelText: 'r/Comunity_name', maxLength: 21),
                const SquareTextField(
                  labelText: 'Add Comment',
                  showSuffix: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
