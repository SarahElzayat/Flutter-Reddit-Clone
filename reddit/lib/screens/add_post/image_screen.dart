/// Modle Image Screen
/// @author Haitham Mohamed
/// @date 6/11/2022

import 'dart:io';
import 'paint_screen.dart';
import '../../../variable/global_varible.dart';

import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';

import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as p;

import 'add_post.dart';

/// Image Screen that Perview the Image After Select it

class ImageScreen extends StatefulWidget {
  /// [image] images that you are selecting <List>
  List<XFile> image;

  /// [imageKey] The key That used when editing
  GlobalKey<ImagePainterState> imageKey;
  ImageScreen({
    Key? key,
    required this.image,
    required this.imageKey,
  }) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Remove Image and Go back
              IconButton(
                  onPressed: () {
                    widget.image.removeAt(0);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
              ),

              /// The button that navigate to Paint Screen
              IconButton(
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => PaintScreen(
                              context: context,
                              image: widget.image,
                              imageKey: widget.imageKey,
                            ))));
                  },
                  icon: const Icon(Icons.draw_rounded)),

              /// The button that navigate to Crop Screen
              IconButton(
                  onPressed: () async {
                    XFile croppedImage =
                        await cropFunc(widget.image[0], context);
                    setState(() {
                      widget.image[0] = croppedImage;
                    });
                  },
                  icon: const Icon(Icons.crop))
            ],
          ),

          /// Preview image (rebuild widget if any edit in image)
          ValueListenableBuilder(
              valueListenable: GlobalVarible.isPainted,
              builder: (context, value, child) {
                return Expanded(
                    child: Image(image: FileImage(File(widget.image[0].path))));
              }),
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
                        File image = File(widget.image[0].path);
                        image.copy(
                            '${path.path}/${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}');
                      } else {
                        path.create();
                        File image = File(widget.image[0].path);
                        image.copy(
                            '${path.path}/${DateTime.now().millisecondsSinceEpoch}${p.extension(image.path)}');
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Image Saved Successful')));
                    },
                    icon: const Icon(Icons.download)),
              ),

              /// Add Image To List
              MaterialButton(
                  onPressed: () {
                    for (var element in widget.image) {
                      GlobalVarible.images.value.add(element);
                    }

                    GlobalVarible.images.notifyListeners();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add')),
            ],
          )
        ]),
      ),
    );
  }
}
