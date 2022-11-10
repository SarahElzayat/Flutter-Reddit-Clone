/// Model Video Widget
/// @author Haitham Mohamed
/// @date 8/11/2022
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Components/Helpers/color_manager.dart';
import '../../functions/add_post.dart';
import '../../variable/global_varible.dart';

/// This widget Show video (video Thumbnail) in Add post Screen
/// You allow to add one video only

/// ignore: must_be_immutable
class VideoPost extends StatelessWidget {
  /// [picker] Image Picker use to get image or video from gallery or Camera
  ImagePicker picker;
  VideoPost({
    Key? key,
    required this.picker,
  }) : super(key: key);

  Widget buildDotted(context) {
    return Align(
      alignment: Alignment.topLeft,
      child: DottedBorder(
        strokeWidth: 1.3,
        dashPattern: const [4, 4],
        color: ColorManager.eggshellWhite,
        child: MaterialButton(
          onPressed: () => videoFunc(context, picker),
          child: const SizedBox(
            height: 150,
            width: 130,
            child: Icon(
              Icons.add_outlined,
              color: ColorManager.blue,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStack(context, width, height, value) {
    return Align(
      alignment: Alignment.topLeft,
      child: Stack(children: [
        SizedBox(
          width: width * 0.4,
          height: height * 0.23,
          child: Image.memory(
            value,
            fit: BoxFit.fill,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            right: 10,
          ),
          width: width * 0.4,
          height: height * 0.23,
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(130, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: InkWell(
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  GlobalVarible.video.value = null;
                  GlobalVarible.videoThumbnail.value = null;
                  GlobalVarible.video.notifyListeners();

                  GlobalVarible.videoThumbnail.notifyListeners();
                },
              ),
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return ValueListenableBuilder(
        valueListenable: GlobalVarible.video,
        builder: (context, value, child) {
          if (value != null) {
            getThumbnail();
          }

          return ValueListenableBuilder(
              valueListenable: GlobalVarible.videoThumbnail,
              builder: (context, value, child) => Container(
                  child: (value == null)
                      ? buildDotted(context)
                      : buildStack(context, width, height, value)));
        });
  }
}
