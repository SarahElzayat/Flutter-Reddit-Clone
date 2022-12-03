import 'package:flutter/material.dart';
import 'package:reddit/Components/button.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommunityType extends StatefulWidget {
  const CommunityType({super.key});

  @override
  State<CommunityType> createState() => _CommunityTypeState();
}

class _CommunityTypeState extends State<CommunityType> {
  bool isChanged = false;
  double change = 0;
  _enabledButton() {
    //do something
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                size: 24.sp,
              )),
          backgroundColor: ColorManager.darkGrey,
          title: const Text('Community type'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Button(
                  onPressed: isChanged
                      ? () {}
                      : () {
                          _enabledButton();
                        },
                  text: 'Save',
                  textFontSize: 16.sp,
                  buttonHeight: 5.h,
                  buttonWidth: 8.w,
                  textColor: isChanged
                      ? ColorManager.darkBlue
                      : ColorManager.darkBlueColor,
                  backgroundColor: ColorManager.darkGrey,
                  splashColor: ColorManager.grey,
                  disabled: isChanged,
                  borderRadius: 4.0),
            )
          ],
        ),
        body: Container(
          color: ColorManager.darkGrey,
          child: Column(
            children: [
              SliderTheme(
                data: SliderThemeData(),
                child: Slider(
                  thumbColor: ColorManager.green,
                  value: change,
                  onChanged: (changed) {
                    setState(() {
                      change = changed;
                    });
                  },
                  divisions: 2,
                  max: 2,
                ),
              )
            ],
          ),
        ));
  }
}
