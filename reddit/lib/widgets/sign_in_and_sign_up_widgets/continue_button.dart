/// @author Abdelaziz Salah
/// @date 6/11/2022
/// utility button to press continue and apply certain function
import 'package:flutter/material.dart';

import '../../components/helpers/color_manager.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton(
      {super.key, required this.appliedFunction, required this.isPressable});

  /// this is the function that should be executed
  /// when the user presses continue
  final appliedFunction;

  /// this is a bool to detect whether the button should be pressed or not.
  final isPressable;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(
                      width: 2,
                      color: isPressable == false
                          ? ColorManager.grey
                          : ColorManager.upvoteRed))),
              backgroundColor: MaterialStatePropertyAll(isPressable == false
                  ? ColorManager.grey
                  : ColorManager.upvoteRed)),
          onPressed: isPressable == false ? null : appliedFunction,
          child: SizedBox(
            width: mediaQuery.size.width,
            child: Text(
              'Continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isPressable == false
                    ? ColorManager.greyColor
                    : ColorManager.white,
                fontSize: (18 * mediaQuery.textScaleFactor),
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
    );
  }
}
