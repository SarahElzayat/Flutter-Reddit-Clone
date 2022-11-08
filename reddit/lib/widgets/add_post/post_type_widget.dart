/// Model Post Type widget
/// @author Haitham Mohamed
/// @date 4/11/2022
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';

import '../../variable/global_varible.dart';
import 'add_post_textfield.dart';
import 'image.dart';
import 'poll_widget.dart';
import 'video.dart';

/// This widget is used to show the widget in post screen
/// according to its type
/// Is just Inteface (No Implementation here)

// ignore: must_be_immutable
class PostTypeWidget extends StatelessWidget {
  /// [textController] Optional Text controller
  TextEditingController textController;

  /// [urlController] URL textField controller
  TextEditingController urlController;

  /// [pollTextController] Options poll Text controller
  TextEditingController pollTextController;

  /// [pollController] Controller for each option in poll <List> (min 2 options)
  List<TextEditingController> pollController = <TextEditingController>[
    TextEditingController(),
    TextEditingController()
  ];

  /// [picker] Image Picker use to get image from gallery or Camera
  ImagePicker picker;

  /// [imageKey] Used to get image after editing
  GlobalKey<ImagePainterState> imageKey;

  /// [keyboardIsOpened]Boolen to Know if the keyboard is opened or not
  /// because if it is opened the Buttons will change to be smaller
  bool keyboardIsOpened;
  PostTypeWidget({
    Key? key,
    required this.textController,
    required this.urlController,
    required this.pollTextController,
    required this.pollController,
    required this.picker,
    required this.imageKey,
    required this.keyboardIsOpened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (GlobalVarible.postType.value) {
      case 0:
        return ImageWidget(picker: picker, imageKey: imageKey);
      case 1:
        return VideoPost(picker: picker);

      case 2:
        return AddPostTextField(
            isTitle: false,
            controller: textController,
            mltiline: true,
            isBold: false,
            fontSize: 18,
            hintText: 'Add optional body text');
      case 3:
        return AddPostTextField(
            isTitle: false,
            controller: urlController,
            mltiline: true,
            isBold: false,
            fontSize: 18,
            hintText: 'URL');
      case 4:
        return Poll(
            isOpen: keyboardIsOpened,
            pollController: pollController,
            textController: pollTextController);
      default:
        return const SizedBox();
    }
  }
}
