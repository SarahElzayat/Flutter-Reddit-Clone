/// Model Image Widget
/// @author Haitham Mohamed
/// @date 7/11/2022

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/cubit/add_post/cubit/add_post_cubit.dart';
import 'package:reddit/widgets/add_post/add_post_textfield.dart';

import '../../components/helpers/color_manager.dart';

/// Add Captions for Image In Web
class ImageWidgetWeb extends StatefulWidget {
  const ImageWidgetWeb({Key? key}) : super(key: key);

  @override
  State<ImageWidgetWeb> createState() => _ImageWidgetWebState();
}

class _ImageWidgetWebState extends State<ImageWidgetWeb> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);

    double hight = mediaQuery.size.height;
    double width = mediaQuery.size.width;

    return BlocBuilder<AddPostCubit, AddPostState>(
      builder: (context, state) {
        return Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (addPostCubit.images.isNotEmpty)
                        for (int index = 0;
                            index < addPostCubit.images.length;
                            index++)
                          image(addPostCubit, index, width, hight),

                      DottedBorder(
                        strokeWidth: 1.3,
                        dashPattern: const [4, 4],
                        color: ColorManager.eggshellWhite,
                        child: MaterialButton(
                          onPressed: () {
                            addPostCubit.imageFunc(
                                context, ImageSource.gallery);
                          },
                          child: const SizedBox(
                            width: 90,
                            height: 100,
                            child: Icon(
                              Icons.add_outlined,
                              color: ColorManager.blue,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (addPostCubit.images.length > 1)
                  Row(
                    children: [
                      SizedBox(
                        height: 350,
                        width: 250,
                        child: loadImage(selectedImage, addPostCubit),
                      ),
                      SizedBox(
                        width: 300,
                        // height: 100,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: AddPostTextField(
                                  onChanged: ((string) {
                                    addPostCubit
                                        .captionController[selectedImage]
                                        .text = string;
                                  }),
                                  mltiline: true,
                                  isBold: false,
                                  fontSize: 20,
                                  hintText: 'Write a Caption',
                                  controller: addPostCubit
                                      .captionControllerTemp[selectedImage]),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: AddPostTextField(
                                  onChanged: ((string) {
                                    addPostCubit
                                        .imagesLinkController[selectedImage]
                                        .text = string;
                                  }),
                                  mltiline: true,
                                  isBold: false,
                                  fontSize: 20,
                                  hintText: 'Paste a link',
                                  controller: addPostCubit
                                      .imagesLinkControllerTemp[selectedImage]),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              ],
            ));
      },
    );
  }

  Widget loadImage(
    int index,
    AddPostCubit addPostCubit,
  ) {
    return Image.network(
      addPostCubit.images[index].path,
      fit: BoxFit.fill,
    );
  }

  Widget image(
      AddPostCubit addPostCubit, int index, double width, double hight) {
    return InkWell(
      onTap: (() {
        setState(() {
          selectedImage = index;
        });
      }),
      child: Stack(children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            width: 90,
            height: 100,
            child: loadImage(index, addPostCubit)),

        /// Remove Button that remove a certian image from the Selected images
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          width: 90,
          height: 100,
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
                  color: ColorManager.eggshellWhite,
                  size: 20,
                ),
                onTap: () {
                  addPostCubit.removeImage(index: index);
                },
              ),
            ),
          ),
        )
      ]),
    );
  }
}
