/// Model Paint Screen
/// @author Haitham Mohamed
/// @date 12/11/2022
import 'dart:io';
import 'dart:typed_data';

import '../../Components/Helpers/color_manager.dart';
import 'package:flutter/material.dart';

import 'package:image_painter/image_painter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../variable/global_varible.dart';

// ignore: must_be_immutable
class PaintScreen extends StatefulWidget {
  /// [image] images that you are selecting <List>
  List<XFile> image;
  BuildContext context;

  /// [imageKey] The key That used when editing
  GlobalKey<ImagePainterState> imageKey;
  PaintScreen({
    Key? key,
    required this.image,
    required this.context,
    required this.imageKey,
  }) : super(key: key);

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  @override
  Widget build(BuildContext context) {
    File file = File(widget.image[0].path);
    return SafeArea(
      child: Scaffold(
        /// Button to save the editing in file
        floatingActionButton: MaterialButton(
          onPressed: () async {
            Uint8List? byteArray =
                await widget.imageKey.currentState!.exportImage();
            if (byteArray != null) {
              final image = byteArray;
              final path = (await getApplicationDocumentsDirectory()).path;
              await Directory('$path/sample').create(recursive: true);
              final fullPath =
                  '$path/sample/${DateTime.now().millisecondsSinceEpoch}.png';
              final paintedImage = File(fullPath);
              paintedImage.writeAsBytesSync(image);
              setState(() {
                widget.image[0] = XFile(paintedImage.path);
                GlobalVarible.isPainted.value = true;
                GlobalVarible.isPainted.notifyListeners();
              });
            } else {
              GlobalVarible.isPainted.value = false;
            }
            Navigator.of(context).pop();
          },
          color: ColorManager.blueGrey,
          child: const Text('Done'),
        ),
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ImagePainter.file(file,
                clearAllIcon: null, key: widget.imageKey, scalable: false),
          ),
        ),
      ),
    );
  }
}
