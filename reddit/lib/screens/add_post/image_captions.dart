// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/widgets/add_post/add_post_textfield.dart';

import '../../cubit/add_post/cubit/add_post_cubit.dart';

class AddImageCaption extends StatefulWidget {
  AddImageCaption({
    super.key,
    this.initialIndex = 0,
    this.backgroundDecoration = const BoxDecoration(
      color: ColorManager.black,
    ),
  }) : pageController =
            PageController(initialPage: initialIndex, keepPage: true);

  /// The initial page to show when first creating the [InlineImageViewer].
  final int initialIndex;

  /// The controller for the page view.
  final PageController pageController;

  /// defaults to [BoxDecoration] with [Colors.black]
  final BoxDecoration? backgroundDecoration;

  @override
  State<AddImageCaption> createState() => _AddImageCaptionState();
}

class _AddImageCaptionState extends State<AddImageCaption> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Captions & Links'),
          leading: IconButton(
              onPressed: () {
                onTapFunc(isEdited, addPostCubit, navigator, mediaquery);
                // navigator.pop();
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            BlocBuilder<AddPostCubit, AddPostState>(
              buildWhen: (previous, current) {
                if (current is ImageCaptionOrLinkEdited) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is ImageCaptionOrLinkEdited) {
                  isEdited = state.isChange;
                }
                return Button(
                    text: 'Save',
                    textColor: isEdited ? ColorManager.blue : ColorManager.grey,
                    backgroundColor: Colors.black,
                    buttonWidth: 70,
                    buttonHeight: 20,
                    textFontSize: 20,
                    onPressed: isEdited
                        ? (() {
                            addPostCubit.editCaptions(true);
                            navigator.pop();
                          })
                        : () {});
              },
            )
          ],
        ),
        body: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.55,
              child: Stack(children: [
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: ((context, index) {
                    return _buildItem(
                        context: context,
                        index: index,
                        addPostCubit: addPostCubit);
                  }),
                  itemCount: addPostCubit.images.length,
                  // loadingBuilder: widget.loadingBuilder,
                  backgroundDecoration: widget.backgroundDecoration,
                  pageController: widget.pageController,
                  onPageChanged: onPageChanged,

                  // allowImplicitScrolling: true,
                  scrollDirection: Axis.horizontal,
                ),
                if (addPostCubit.images.length > 1)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Opacity(
                        opacity: 0.7,
                        child: Chip(
                          label: Text(
                            '${currentIndex + 1}/${addPostCubit.images.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                            ),
                          ),
                          backgroundColor: ColorManager.darkGrey,
                        ),
                      ),
                    ),
                  ),
                if (defaultTargetPlatform == TargetPlatform.android &&
                    addPostCubit.images.length > 1)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DotsIndicator(
                        dotsCount: addPostCubit.images.length,
                        position: currentIndex.toDouble(),
                        decorator: const DotsDecorator(
                          color: Colors.transparent,
                          activeColor: ColorManager.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              side: BorderSide(
                                  width: 1.1, color: ColorManager.white)),
                        )),
                  ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: AddPostTextField(
                  onChanged: ((string) {
                    addPostCubit.imageCaptionEdited();
                  }),
                  mltiline: true,
                  isBold: false,
                  fontSize: 20,
                  hintText: 'Write a Caption',
                  controller: addPostCubit.captionControllerTemp[currentIndex]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: AddPostTextField(
                  onChanged: ((string) {
                    addPostCubit.imageCaptionEdited();
                  }),
                  mltiline: true,
                  isBold: false,
                  fontSize: 20,
                  hintText: 'Paste a link',
                  controller:
                      addPostCubit.imagesLinkControllerTemp[currentIndex]),
            )
          ],
        ));
  }

  PhotoViewGalleryPageOptions _buildItem(
      {required BuildContext context,
      required int index,
      required AddPostCubit addPostCubit}) {
    final File item = File(addPostCubit.images[index].path);
    return PhotoViewGalleryPageOptions(
      imageProvider: FileImage(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      // TODO: Add hero tag to the image
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }

  onTapFunc(bool isEdited, AddPostCubit addPostCubit, NavigatorState navigator,
      MediaQueryData mediaQuery) {
    if (isEdited) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: ColorManager.grey,
                insetPadding: EdgeInsets.zero,
                title: const Text('Discard changes?'),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      navigator.pop();
                    },
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(color: ColorManager.blue),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      addPostCubit.editCaptions(false);
                      navigator.pop();
                      navigator.pop();
                    },
                    child: const Text(
                      'DICARD',
                      style: TextStyle(color: ColorManager.blue),
                    ),
                  ),
                ],
              )));
    } else {
      navigator.pop();
    }
  }
}
