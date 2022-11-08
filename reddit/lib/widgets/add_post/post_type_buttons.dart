/// Model Post Buttons Type
/// @author Haitham Mohamed
/// @date 4/11/2022

import '../../Components/Helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';

import '../../functions/add_post.dart';
import '../../variable/constants.dart';
import '../../variable/global_varible.dart';

/// Post Type Buttons is the Widget that can select the post type
/// That on the Bottom of the add post Screeen
// ignore: must_be_immutable
class PostTypeButtons extends StatefulWidget {
  /// [keyboardIsOpened]Boolen to Know if the keyboard is opened or not
  /// because if it is opened the Buttons will change to be smaller
  bool keyboardIsOpened;

  /// [picker] Image Picker use to get image from gallery or Camera
  ImagePicker picker;

  /// [imageKey] Used to get image after editing
  GlobalKey<ImagePainterState> imageKey;
  PostTypeButtons({
    Key? key,
    required this.keyboardIsOpened,
    required this.picker,
    required this.imageKey,
    // required this.result,
  }) : super(key: key);

  @override
  State<PostTypeButtons> createState() => _PostTypeButtonsState();
}

class _PostTypeButtonsState extends State<PostTypeButtons> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      color: ColorManager.textFieldBackground,
      child: widget.keyboardIsOpened
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  for (int index = 0; index < icons.length; index++)
                    InkWell(
                      onTap: (() {
                        if (index == 0 &&
                            GlobalVarible.postType.value != index) {
                          imageFunc(
                            context,
                            widget.picker,
                            widget.imageKey,
                          );
                        } else if (index == 1 &&
                            GlobalVarible.postType.value != index) {
                          videoFunc(context, widget.picker);
                        }
                        GlobalVarible.postType.value = index;
                        GlobalVarible.postType.notifyListeners();
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Icon(
                          icons[index],
                          size: 32 * mediaQuery.textScaleFactor,
                          color: (index == GlobalVarible.postType.value)
                              ? Colors.blue
                              : Colors.white,
                        ),
                      ),
                    )
                ],
              ),
            )
          : Column(
              children: [
                for (int index = 0; index < labels.length; index++)
                  InkWell(
                    onTap: (() async {
                      if (index == 0 && GlobalVarible.postType.value != index) {
                        imageFunc(
                          context,
                          widget.picker,
                          widget.imageKey,
                        );
                      } else if (index == 1 &&
                          GlobalVarible.postType.value != index) {
                        videoFunc(context, widget.picker);
                      }
                      GlobalVarible.postType.value = index;
                      GlobalVarible.postType.notifyListeners();
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              icons[index],
                              size: 25 * mediaQuery.textScaleFactor,
                            ),
                          ),
                          Text(
                            labels[index],
                            style: TextStyle(
                                fontSize: 20 * mediaQuery.textScaleFactor),
                          ),
                          const Spacer(),
                          if (GlobalVarible.postType.value == index)
                            const Icon(
                              Icons.done,
                              color: Colors.blue,
                            )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
