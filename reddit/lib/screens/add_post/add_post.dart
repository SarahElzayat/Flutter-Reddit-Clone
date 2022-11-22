/// Model Add Post Screen
/// @author Haitham Mohamed
/// @date 4/11/2022

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_painter/image_painter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/helpers/color_manager.dart';
import '../../../variable/global_varible.dart';
import '../../../widgets/add_post/add_post_textfield.dart';
import '../../../widgets/add_post/post_type_widget.dart';

import '../../widgets/add_post/post_type_buttons.dart';

/// This is the main screen in Add Post

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  /// [titleController] Title textField controller
  TextEditingController titleController = TextEditingController();

  /// [textController] Optional Text controller
  TextEditingController textController = TextEditingController();

  /// [pollTextController] Options poll Text controller
  TextEditingController pollTextController = TextEditingController();

  /// [urlController] URL textField controller
  TextEditingController urlController = TextEditingController();

  /// [pollController] Controller for each option in poll <List> (min 2 options)
  List<TextEditingController> pollController = <TextEditingController>[
    TextEditingController(),
    TextEditingController()
  ];

  /// [picker] Image Picker use to get image from gallery or Camera
  final ImagePicker picker = ImagePicker();

  /// [imageKey] Used to get image after editing
  final imageKey = GlobalKey<ImagePainterState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.of(context).pop();
                // because this is the first screen this button exit the app
                // when mearge this it will not be the first screen so
                // remove the previous line code and uncomment the next line
                // Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
          actions: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: Button(
                  pollController: pollController,
                  textController: textController,
                  pollTextController: pollTextController,
                  urlController: urlController,
                  titleController: titleController,
                ))
          ],
        ),
        body: SizedBox(
          height: mediaQuery.size.height,
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AddPostTextField(
                    isTitle: true,
                    controller: titleController,
                    mltiline: false,
                    isBold: true,
                    fontSize: (23 * mediaQuery.textScaleFactor).toInt(),
                    hintText: 'An intereting title')),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ValueListenableBuilder(
                  valueListenable: GlobalVarible.postType,
                  builder:
                      (BuildContext context2, dynamic value, Widget? child) {
                    return PostTypeWidget(
                      pollTextController: pollTextController,
                      pollController: pollController,
                      textController: textController,
                      urlController: urlController,
                      keyboardIsOpened: (mediaQuery.viewInsets.bottom > 0),
                      picker: picker,
                      imageKey: imageKey,
                    );
                  },
                )),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: GlobalVarible.postType,
              builder:
                  (BuildContext contextBuilder, dynamic value, Widget? child) {
                return PostTypeButtons(
                  keyboardIsOpened: (mediaQuery.viewInsets.bottom > 0),
                  imageKey: imageKey,
                  picker: picker,
                );
              },
            ),
          ]),
        ));
  }
}

/// This function takes the Image and Navigate to the crop Screen
/// It returns the image even if you do not make any change

/// [image] The Image That you want to make edit on it

Future<XFile> cropFunc(XFile image, BuildContext context) async {
  File file = File(image.path);
  CroppedFile? croppedImage = await ImageCropper().cropImage(
    sourcePath: file.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio16x9,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio4x3,
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          showCropGrid: false,
          activeControlsWidgetColor: ColorManager.darkGrey,
          toolbarColor: ColorManager.darkGrey,
          toolbarWidgetColor: ColorManager.eggshellWhite,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
      WebUiSettings(
        context: context,
      ),
    ],
  );
  if (croppedImage != null) {
    return XFile(croppedImage.path);
  } else {
    return image;
  }
}
