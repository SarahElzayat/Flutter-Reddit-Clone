/// Modle Add Post Function
/// @author Haitham Mohamed
/// @date 7/11/2022

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/Screens/add_post/image_screen.dart';
import 'package:reddit/Screens/add_post/video_trimmer.dart';
import '../Components/Button.dart';
import '../Components/Helpers/color_manager.dart';
import '../cubit/add_post.dart/cubit/add_post_cubit.dart';

/// This function allow you to choose images
/// if the number of images is one so it will navigate to Preview Screen that can make edit in image
/// else it will add images and navigate back
imageFunc(BuildContext context, ImageSource source) async {
  List<XFile> images = <XFile>[];
  if (source == ImageSource.gallery) {
    images = await ImagePicker().pickMultiImage();
  } else {
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) images.add(image);
  }
  final addPostCubit = BlocProvider.of<AddPostCubit>(context);
  if (images.length == 1) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return ImageScreen(image: image[0], imageKey: imageKey);
    //   },
    // ));
    addPostCubit.editableImage = images[0];

    /// TODO: This should be removed from the async
    Navigator.of(context).pushNamed(ImageScreen.routeName);
  } else if (images.length > 1) {
    addPostCubit.addImages(images: images);
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

/// This function allow you to choose video
/// you are allowed to choose one video only after that it will navigate to Video Trimmer Screen
videoFunc(BuildContext context) async {
  XFile? result = await ImagePicker().pickVideo(
    source: ImageSource.gallery,
  );
  if (result != null) {
    File file = File(result.path);
    Navigator.of(context).pushNamed(TrimmerView.routeName, arguments: file);
  }
}

/// Make User Choose The Source of Image that Want to Add
/// Note He Choose in Image Post Only in Video will be implement later
void chooseSourceWidget(
    BuildContext context, MediaQueryData mediaQuery, NavigatorState navigator) {
  showDialog(
      context: context,
      builder: ((context2) => AlertDialog(
            backgroundColor: ColorManager.grey,
            insetPadding: EdgeInsets.zero,
            title: const Text('Choose The Source'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    ImageSource source = ImageSource.gallery;
                    Navigator.of(context2).pop();
                    imageFunc(context, source);
                    return;
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.image_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                            fontSize: 20 * mediaQuery.textScaleFactor),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    ImageSource source = ImageSource.camera;
                    Navigator.of(context2).pop();
                    imageFunc(context, source);
                    return;
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Camera',
                          style: TextStyle(
                              fontSize: 20 * mediaQuery.textScaleFactor)),
                    ],
                  ),
                )
              ],
            ),
            actions: [
              SizedBox(
                width: mediaQuery.size.width * 0.42,
                child: Button(
                  onPressed: () {
                    navigator.pop();
                    return;
                  },
                  text: ('Cancel'),
                  textColor: ColorManager.white,
                  backgroundColor: Colors.transparent,
                  buttonWidth: mediaQuery.size.width * 0.3,
                  buttonHeight: 40,
                  textFontSize: 15,
                  boarderRadius: 20,
                ),
              ),
            ],
          )));
}
