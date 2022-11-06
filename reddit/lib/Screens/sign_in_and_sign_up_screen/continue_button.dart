import 'package:flutter/material.dart';

import '../../components/Helpers/color_manager.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.appliedFunction});

  /// this is the function that should be executed
  /// when the user presses continue
  final appliedFunction;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
      child: ElevatedButton(
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(width: 2, color: ColorManager.white))),
              backgroundColor: MaterialStatePropertyAll(ColorManager.blue)),
          onPressed: appliedFunction,
          child: SizedBox(
            width: mediaQuery.size.width,
            child: Text(
              'Continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorManager.white,
                fontSize: (18 * mediaQuery.textScaleFactor),
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
