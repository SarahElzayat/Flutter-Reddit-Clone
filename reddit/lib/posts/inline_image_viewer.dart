import 'dart:math';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// import 'package:reddit/Components/color_manager.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:reddit/posts/image_page_view.dart';
import 'package:reddit/posts/post_data.dart';
import '../components/helpers/color_manager.dart';

class InlineImageViewer extends StatefulWidget {
  InlineImageViewer({
    required this.post,
    super.key,
    this.initialIndex = 0,
    this.backgroundDecoration = const BoxDecoration(
      color: Colors.black,
    ),
  }) : pageController =
            PageController(initialPage: initialIndex, keepPage: true);
  final int initialIndex;
  final PageController pageController;
  final BoxDecoration? backgroundDecoration;
  final Post post;

  @override
  State<InlineImageViewer> createState() => _InlineImageViewerState();
}

class _InlineImageViewerState extends State<InlineImageViewer> {
  late int currentIndex = widget.initialIndex;
  double aspectRatio = 1.0;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    Image(image: NetworkImage(widget.post.images![0]))
        .image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, call) {
      setState(() {
        aspectRatio = info.image.height / info.image.width;
        print(aspectRatio);
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            openImage(context, currentIndex);
          },
          child: SizedBox(
            height: min(MediaQuery.of(context).size.height * .4,
                aspectRatio * constraints.maxWidth),
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: _buildItem,
                  itemCount: widget.post.images!.length,
                  // loadingBuilder: widget.loadingBuilder,
                  backgroundDecoration: widget.backgroundDecoration,
                  pageController: widget.pageController,
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
                if (defaultTargetPlatform == TargetPlatform.android &&
                    widget.post.images!.length > 1)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DotsIndicator(
                        dotsCount: widget.post.images!.length,
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
                if (kIsWeb && currentIndex != widget.post.images!.length - 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        backgroundColor: ColorManager.darkGrey,
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
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
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            widget.pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.post.images![index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item),
      initialScale: PhotoViewComputedScale.contained / aspectRatio,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      // TODO: Add hero tag to the image
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }

  void openImage(BuildContext context, final int index) {
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
