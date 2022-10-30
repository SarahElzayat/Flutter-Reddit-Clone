import 'package:flutter/material.dart';
import '../Components/Helpers/color_manager.dart';
import 'package:reddit/components/search_field.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.darkGrey,
        // inputDecorationTheme: const InputDecorationTheme(
        //   hintStyle: TextStyle(color: greyColor),
        //   alignLabelWithHint: true,
        // ),
      ),
      // iconTheme: IconThemeData(color: ColorManager.lightGrey, size: 20)),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchFiled(
                    textEditingController: TextEditingController(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SearchFiled(
                    textEditingController: _controller,
                    isProfile: true,
                    labelText: 'u/sarsora',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
