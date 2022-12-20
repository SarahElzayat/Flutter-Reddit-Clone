/// Model Paint Screen
/// @author Haitham Mohamed
/// @date 12/11/2022
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../components/helpers/color_manager.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';

/// Paint Screen

class PaintScreen extends StatelessWidget {
  /// [imageKey] The key That used when editing
  final GlobalKey<ImagePainterState> imageKey = GlobalKey<ImagePainterState>();
  static const routeName = '/paint_screen_route';

  PaintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    File file = File(addPostCubit.editableImage.path);
    return SafeArea(
      child: Scaffold(
        /// Button to save the editing in file
        floatingActionButton: MaterialButton(
          onPressed: () async {
            Uint8List? byteArray = await imageKey.currentState!.exportImage();
            if (byteArray != null) {
              final image = byteArray;
              final path = (await getApplicationDocumentsDirectory()).path;
              await Directory('$path/sample').create(recursive: true);
              final fullPath =
                  '$path/sample/${DateTime.now().millisecondsSinceEpoch}.png';
              final paintedImage = File(fullPath);
              paintedImage.writeAsBytesSync(image);

              addPostCubit.editableImage = XFile(paintedImage.path);

              addPostCubit.imagePaintedOrCropped();
            }
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          color: ColorManager.blueGrey,
          child: const Text('Done'),
        ),
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImagePainter.file(file,
                clearAllIcon: null, key: imageKey, scalable: false),
          ),
        ),
      ),
    );
  }
}
