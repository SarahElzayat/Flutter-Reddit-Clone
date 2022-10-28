import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reddit/Components/color_manager.dart';

class InlineImageViewer extends StatefulWidget {
  InlineImageViewer({
    super.key,
    required this.imagesUrls,
    this.initialIndex = 0,
    this.backgroundDecoration = const BoxDecoration(
      color: Colors.black,
    ),
  }) : pageController = PageController(initialPage: initialIndex);
  final List<String> imagesUrls;
  final int initialIndex;
  final PageController pageController;
  final BoxDecoration? backgroundDecoration;

  @override
  State<InlineImageViewer> createState() => _InlineImageViewerState();
}

class _InlineImageViewerState extends State<InlineImageViewer> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildItem,
          itemCount: widget.imagesUrls.length,
          // loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          onPageChanged: onPageChanged,
          scrollDirection: Axis.horizontal,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Opacity(
              opacity: 0.7,
              child: Chip(
                label: Text(
                  '${currentIndex + 1}/${widget.imagesUrls.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
                backgroundColor: ColorManager.darkGrey,
              ),
            ),
          ),
        )
      ],
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.imagesUrls[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      // TODO: Add hero tag to the image
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }
}
