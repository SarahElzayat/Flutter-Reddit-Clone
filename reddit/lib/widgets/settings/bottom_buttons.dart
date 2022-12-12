import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';

class BottomButtons extends StatelessWidget {
  final string1;
  final string2;
  final handler1;
  final handler2;
  const BottomButtons(
      {super.key,
      required this.string1,
      required this.string2,
      required this.handler1,
      required this.handler2});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: handler1,
                style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(ColorManager.grey),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(width: 3, color: Colors.black),
                    ),
                  ),
                ),
                child: Text(
                  string1,
                  style: TextStyle(
                      fontSize: mediaQuery.textScaleFactor * 16,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.white),
                ),
              ),
            ),
          ),
          Expanded(
              child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: handler2,
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(ColorManager.blue),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(width: 3, color: Colors.black),
                  ),
                ),
              ),
              child: Text(
                string2,
                style: TextStyle(
                    fontSize: mediaQuery.textScaleFactor * 16,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.white),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
