/// Model Image Widget
/// @author Haitham Mohamed
/// @date 7/11/2022
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Screens/add_post/image_captions.dart';
import 'package:reddit/cubit/add_post/cubit/add_post_cubit.dart';

import '../../components/helpers/color_manager.dart';

/// This Widget Shows the images after selected
///  shows them in row (in main add post Screen)
class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    final navigator = Navigator.of(context);

    double hight = mediaQuery.size.height;
    double width = mediaQuery.size.width;

    return BlocBuilder<AddPostCubit, AddPostState>(
      builder: (context, state) {
        return Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (addPostCubit.images.length == 1)
                        for (int index = 0;
                            index < addPostCubit.images.length;
                            index++)
                          image(addPostCubit, index, width, hight),
                      if (addPostCubit.images.length > 1)
                        for (int index = 0;
                            index < addPostCubit.images.length;
                            index++)
                          InkWell(
                              onTap: (() {
                                navigator.push(MaterialPageRoute(
                                    builder: ((context) => AddImageCaption(
                                          initialIndex: index,
                                        ))));
                              }),
                              child: image(addPostCubit, index, width, hight)),

                      /// The button that allow you to add image
                      /// Note It will be added the option that allow user to choose
                      /// if you want to pick image from gallery or Camera
                      /// for Now you can Choose from gallery Only
                      DottedBorder(
                        strokeWidth: 1.3,
                        dashPattern: const [4, 4],
                        color: ColorManager.eggshellWhite,
                        child: MaterialButton(
                          onPressed: () {
                            addPostCubit.chooseSourceWidget(
                                context, mediaQuery, navigator);
                          },
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
                if (addPostCubit.images.length > 1)
                  Align(
                    alignment: Alignment.topLeft,
                    child: MaterialButton(
                      onPressed: () {
                        navigator.push(MaterialPageRoute(
                            builder: ((context) => AddImageCaption())));
                      },
                      child: Text('Add Captions & Links',
                          style: TextStyle(
                              color: ColorManager.eggshellWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 18 * mediaQuery.textScaleFactor)),
                    ),
                  )
              ],
            ));
      },
    );
  }

  Widget image(
      AddPostCubit addPostCubit, int index, double width, double hight) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        width: width * 0.38,
        height: hight * 0.2,
        child: Image.file(
          (addPostCubit.images.length > 1)
              ? File(addPostCubit.images[index].path)
              : File(addPostCubit.images[0].path),
          fit: BoxFit.fill,
        ),
      ),

      /// Remove Button that remove a certian image from the Selected images
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        width: width * 0.38,
        height: hight * 0.2,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
                color: Color.fromARGB(130, 0, 0, 0),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: InkWell(
              child: Icon(
                Icons.close,
                color: ColorManager.eggshellWhite,
                size: width * 0.07,
              ),
              onTap: () {
                addPostCubit.removeImage(index: index);
              },
            ),
          ),
        ),
      )
    ]);
  }
}
