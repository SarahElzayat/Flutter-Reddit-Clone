import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class WholeScreenImageViewer extends StatefulWidget {
  WholeScreenImageViewer({
    super.key,
    required this.imagesUrls,
    this.initialIndex = 0,
    this.backgroundDecoration = const BoxDecoration(
      color: Colors.black,
    ),
  }) : pageController =
            PageController(initialPage: initialIndex, keepPage: true);
  final List<String> imagesUrls;
  final int initialIndex;
  final PageController pageController;
  final BoxDecoration? backgroundDecoration;

  @override
  State<WholeScreenImageViewer> createState() => _WholeScreenImageViewerState();
}

class _WholeScreenImageViewerState extends State<WholeScreenImageViewer> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '${currentIndex + 1}/${widget.imagesUrls.length}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
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
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.imagesUrls[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }
}
