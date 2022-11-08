/// Modle Add Post Function
/// @author Haitham Mohamed
/// @date 7/11/2022

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../screens/add_post/image_screen.dart';
import '../screens/add_post/video_trimmer.dart';
import '../variable/global_varible.dart';

/// This function allow you to choose images
/// if the number of images is one so it will navigate to Preview Screen that can make edit in image
/// else it will add images and navigate back
///
/// [picker] Image Picker use to get image from gallery or Camera
/// [imageKey] Used to get image after editing
imageFunc(BuildContext context, ImagePicker picker,
    GlobalKey<ImagePainterState> imageKey) async {
  List<XFile> image = <XFile>[];
  image = await picker.pickMultiImage();
  if (image.length == 1) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ImageScreen(image: image, imageKey: imageKey);
      },
    ));
  } else if (image.length > 1) {
    for (var element in image) {
      GlobalVarible.images.value.add(element);
    }

    GlobalVarible.images.notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lenght = ${GlobalVarible.images.value.length}')));
  }
}

/// This function allow you to choose video
/// you are allowed to choose one video only after that it will navigate to Video Trimmer Screen
///
/// [picker] Image Picker use to get image from gallery or Camera
videoFunc(BuildContext context, ImagePicker picker) async {
  XFile? result = await picker.pickVideo(
    source: ImageSource.gallery,
  );
  if (result != null) {
    File file = File(result.path);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return TrimmerView(file);
      }),
    );
  }
}

/// This Function get the Video Thumbnail that will be used to show the video in add post screen
getThumbnail() async {
  if (GlobalVarible.video != null) {
    final videothumbnail = await VideoThumbnail.thumbnailData(
      video: GlobalVarible.video.value!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    GlobalVarible.videoThumbnail.value = videothumbnail;
    GlobalVarible.videoThumbnail.notifyListeners();
  }
}
