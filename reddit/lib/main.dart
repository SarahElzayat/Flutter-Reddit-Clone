import 'package:flutter/material.dart';
import 'package:reddit/components/text_fields.dart';

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
        primaryColor: Colors.red,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: backgroundColor,
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: darkBlueColor),
          labelStyle: TextStyle(color: greyColor),
          suffixIconColor: greyColor,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: darkBlueColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greyColor),
          ),
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
                defaultTextField('Normal'),
                defaultTextField('description', maxLength: 5),
                defaultTextField(
                  'Password',
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                ),
                defaultTextField(
                  'New Password',
                  obscureText: true,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye),
                    color: darkBlueColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
