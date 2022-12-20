/// Modle Image Screen
/// @author Haitham Mohamed
/// @date 6/11/2022
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:reddit/cubit/add_post/cubit/add_post_cubit.dart';
import 'package:reddit/screens/add_post/paint_screen.dart';

import '../../components/helpers/color_manager.dart';

/// Image Screen that Perview the Image After Select it

// ignore: must_be_immutable
class ImageScreen extends StatelessWidget {
  static const routeName = '/image_screen_route';
  ImageScreen({Key? key}) : super(key: key);

  /// [imageKey] The key That used when editing
  GlobalKey<ImagePainterState> imageKey = GlobalKey<ImagePainterState>();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    navigator.pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
              SizedBox(
                width: mediaQuery.size.width * 0.25,
              ),

              /// The button that navigate to Paint Screen
              IconButton(
                  onPressed: () async {
                    navigator.pushNamed(
                      PaintScreen.routeName,
                    );
                  },
                  icon: const Icon(Icons.draw_rounded)),

              /// The button that navigate to Crop Screen
              IconButton(
                  onPressed: () async {
                    XFile croppedImage =
                        await cropFunc(addPostCubit.editableImage, context);
                    addPostCubit.editableImage = croppedImage;
                    addPostCubit.imagePaintedOrCropped();
                  },
                  icon: const Icon(Icons.crop))
            ],
          ),

          /// Preview image (rebuild widget if any edit in image)
          BlocBuilder<AddPostCubit, AddPostState>(
            builder: (context, state) {
              return Expanded(
                  child: Image(
                      image: FileImage(File(addPostCubit.editableImage.path))));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Save Image in local Storage In Pictures folder
              /// Pictures folder is exist already in the device
              /// but if this folder not exist for any reason the app will throw an error
              /// And this error related to access permission and it not handled yet
              Container(
                margin: const EdgeInsets.all(8),
                child: IconButton(
                    onPressed: () async {
                      const folderName = 'Pictures';
                      final path = Directory('storage/emulated/0/$folderName');
                      if ((await path.exists())) {
                        File image = File(addPostCubit.editableImage.path);
                        image.copy(
                            '${path.path}/${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}');
                      } else {
                        path.create();
                        File image = File(addPostCubit.editableImage.path);
                        image.copy(
                            '${path.path}/${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}');
                      }
                    },
                    icon: const Icon(Icons.download)),
              ),

              /// Add Image To List
              MaterialButton(
                  onPressed: () {
                    addPostCubit.addImage(image: addPostCubit.editableImage);
                    navigator.pop();
                  },
                  child: const Text('Add')),
            ],
          )
        ]),
      ),
    );
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
}
