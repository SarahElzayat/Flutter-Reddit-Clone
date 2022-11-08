/// Model Image Widget
/// @author Haitham Mohamed
/// @date 7/11/2022
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';

import '../../Components/Helpers/color_manager.dart';
import '../../functions/add_post.dart';
import '../../variable/global_varible.dart';

/// This Widget Shows the images after selected shows them in row (in main add post Screen)
// ignore: must_be_immutable
class ImageWidget extends StatelessWidget {
  /// [picker] Image Picker use to get image from gallery or Camera
  ImagePicker picker;

  /// [imageKey] The key That used when editing
  GlobalKey<ImagePainterState> imageKey;

  ImageWidget({
    Key? key,
    required this.picker,
    required this.imageKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double hight = mediaQuery.size.height;
    double width = mediaQuery.size.width;

    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ValueListenableBuilder(
          valueListenable: GlobalVarible.images,
          builder: (context, value, child) => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int index = 0; index < value.length; index++)
                Stack(children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    width: width * 0.38,
                    height: hight * 0.2,
                    child: Image.file(
                      File(value[index].path),
                      fit: BoxFit.fill,
                    ),
                  ),

                  /// Remove Button that remove a certian image from the Selected images
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    width: width * 0.38,
                    height: hight * 0.2,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(130, 0, 0, 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: InkWell(
                          child: Icon(
                            Icons.close,
                            color: ColorManager.eggshellWhite,
                            size: width * 0.07,
                          ),
                          onTap: () {
                            GlobalVarible.images.value.removeAt(index);
                            GlobalVarible.images.notifyListeners();
                          },
                        ),
                      ),
                    ),
                  )
                ]),

              /// The button that allow you to add image
              /// Note It will be added the option that allow user to choose
              /// if you want to pick image from gallery or Camera
              /// for Now you can Choose from gallery Only
              DottedBorder(
                strokeWidth: 1.3,
                dashPattern: const [4, 4],
                color: ColorManager.eggshellWhite,
                child: MaterialButton(
                  onPressed: () => imageFunc(context, picker, imageKey),
                  child: SizedBox(
                    width: width * 0.38,
                    height: hight * 0.2,
                    child: Icon(
                      Icons.add_outlined,
                      color: ColorManager.blue,
                      size: width * 0.1,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
