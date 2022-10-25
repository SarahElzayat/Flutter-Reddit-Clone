import 'package:flutter/material.dart';
import 'package:reddit/Components/color_manager.dart';
import 'package:reddit/components/default_text_field.dart';
import 'package:reddit/components/square_text_field.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.darkGrey,
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: ColorManager.greyColor),
          alignLabelWithHint: true,
        ),
      ),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const DefaultTextField(labelText: 'Normal'),
                    const SizedBox(height: 30),
                    const DefaultTextField(
                        labelText: 'Description',
                        maxLength: 500,
                        multiLine: true),
                    const SizedBox(height: 30),
                    DefaultTextField(
                      labelText: 'Password',
                      formController: _controller,
                      icon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: ColorManager.darkBlueColor,
                        ),
                      ),
                    ),
                    DefaultTextField(
                      labelText: 'New Password',
                      obscureText: true,
                      icon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye_outlined),
                        color: ColorManager.greyColor,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SquareTextField(
                      labelText: 'r/Comunity_name',
                      maxLength: 21,
                    ),
                    const SquareTextField(
                      labelText: 'Add Comment',
                      showSuffix: false,
                    ),
                    const SizedBox(height: 30),
                    //Elevated Button to validate the form
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                            color: ColorManager.darkBlueColor, width: 2),
                      ),
                      onPressed: () {
                        _formKey.currentState!.validate();
                      },
                      child: const Text('Validate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
