/// The inline image viewer
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/widgets/posts/image_page_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/helpers/color_manager.dart';
import '../../components/helpers/enums.dart';
import '../../components/helpers/posts/helper_funcs.dart';

class InlineImageViewer extends StatefulWidget {
  const InlineImageViewer({
    required this.post,
    super.key,
    this.initialIndex = 0,
    this.backgroundDecoration = const BoxDecoration(
      color: ColorManager.black,
    ),
    this.postView = PostView.card,
  }) :
        // it asserts the passed Values and images can't be null
        assert(initialIndex >= 0); // the initial index can't be less than 0

  /// The initial page to show when first creating the [InlineImageViewer].
  final int initialIndex;

  /// The decoration to paint behind the child if the is a gap.
  ///
  /// defaults to [BoxDecoration] with [Colors.black]
  final BoxDecoration? backgroundDecoration;

  /// The post to show
  final PostModel post;

  /// it's either a card or a classic view
  /// defaults to [PostView.card]
  final PostView postView;
  @override
  State<InlineImageViewer> createState() => _InlineImageViewerState();
}

class _InlineImageViewerState extends State<InlineImageViewer> {
  late int currentIndex = widget.initialIndex;
  double aspectRatio = 0;

  /// The controller for the page view.
  late PageController pageController;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    pageController =
        PageController(initialPage: widget.initialIndex, keepPage: true);

    if (imagesExists) {
      Image(image: NetworkImage(widget.post.images![0].path!))
          .image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((info, call) {
        setState(() {
          aspectRatio = info.image.height / info.image.width;
        });
      }));
    }
    super.initState();
  }

  bool get imagesExists => widget.post.images?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: imagesExists,
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              openImage(context, currentIndex);
            },
            child: SizedBox(
              // expand the image to the width of the screen with max height of 60% of the screen
              height: min(70.h, aspectRatio * constraints.maxWidth),
              child: Stack(
                children: [
                  PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: _buildItem,
                    wantKeepAlive: true,

                    itemCount: widget.post.images!.length,
                    // loadingBuilder: widget.loadingBuilder,
                    backgroundDecoration: widget.backgroundDecoration,
                    pageController: pageController,
                    onPageChanged: onPageChanged,
                    // allowImplicitScrolling: true,

                    scrollDirection: Axis.horizontal,
                  ),
                  if (widget.post.images!.length > 1)
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Opacity(
                          opacity: 0.7,
                          child: Chip(
                            label: Text(
                              '${currentIndex + 1}/${widget.post.images!.length}',
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
                  if (kIsWeb && currentIndex != widget.post.images!.length - 1)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          backgroundColor: ColorManager.darkGrey,
                          radius: min(5.5.w, 30),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_outlined),
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              // if (widget.pageController.hasClients) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                              // }
                            },
                          ),
                        ),
                      ),
                    ),
                  if (kIsWeb && currentIndex != 0)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          backgroundColor: ColorManager.darkGrey,
                          radius: min(5.5.w, 30),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (pageController.hasClients) {
                                pageController.previousPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (defaultTargetPlatform == TargetPlatform.android &&
                            widget.post.images!.length > 1)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: DotsIndicator(
                                dotsCount: _dotsCount(),
                                position: min(
                                    currentIndex.toDouble(), _dotsCount() - 1),
                                decorator: const DotsDecorator(
                                  color: Colors.transparent,
                                  spacing: EdgeInsets.all(5),
                                  activeColor: ColorManager.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      side: BorderSide(
                                          width: 1.1,
                                          color: ColorManager.white)),
                                )),
                          ),
                        if (_haveCaptions() && widget.postView == PostView.card)
                          Container(
                              constraints: const BoxConstraints(
                                minHeight: 40,
                              ),
                              color: ColorManager.betterDarkGrey,
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.post.images![currentIndex].caption ??
                                        '',
                                    style: const TextStyle(
                                      color: ColorManager.eggshellWhite,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (widget.post.images![currentIndex].link !=
                                      null)
                                    linkRow(
                                        widget.post.images![currentIndex].link!,
                                        ColorManager.blue)
                                ],
                              )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      fallback: (context) => Container(),
    );
  }

  bool _haveCaptions() {
    for (var image in widget.post.images!) {
      if (image.caption != null) {
        return true;
      }
    }
    return false;
  }

  int _dotsCount() {
    if (widget.postView == PostView.card) return widget.post.images!.length;
    return min(widget.post.images!.length, 3);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.post.images![index].path!;
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item),
      //NOTE - i changed this to covered so that the image fits small containers
      initialScale: PhotoViewComputedScale.covered,
      minScale: PhotoViewComputedScale.contained * (0.5),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      // heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }

  /// Opens the image in a new screen
  ///
  /// [index] is the index of the image to be opened
  void openImage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WholeScreenImageViewer(
          post: widget.post,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
        ),
      ),
    );
  }
}
