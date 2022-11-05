import 'dart:math';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reddit/components/Helpers/color_manager.dart';
import 'package:reddit/posts/post_data.dart';

import 'post_lower_bar.dart';

class WholeScreenImageViewer extends StatefulWidget {
  WholeScreenImageViewer({
    super.key,
    required this.post,
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
  State<WholeScreenImageViewer> createState() => _WholeScreenImageViewerState();
}

class _WholeScreenImageViewerState extends State<WholeScreenImageViewer> {
  late int currentIndex = widget.initialIndex;
  double aspectRatio = 1.0;
  double initialInDragging = 0.0;
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    for (var i = 0; i < widget.post.images!.length; i++) {
      Image(image: NetworkImage(widget.post.images![i]))
          .image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((info, call) {
        setState(() {
          aspectRatio = max(aspectRatio, info.image.height / info.image.width);
          // print(aspectRatio);
        });
      }));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${widget.post.subredditId} •',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    debugPrint('joined');
                  },
                  child: Text(
                    'Join',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.blue,
                        ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  ' •  u/${widget.post.userId}  •',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '8h',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            Text(
              widget.post.title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GestureDetector(
        onVerticalDragStart: (details) {
          initialInDragging = details.globalPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          // double diff = details.globalPosition.dy - diffInDragging;
          // debugPrint('diff:' + diff.toString());
        },
        onVerticalDragEnd: (details) {
          // debugPrint('speed: ' + details.primaryVelocity.toString());
        },
        child: Container(
          decoration: widget.backgroundDecoration,
          // alignment: Alignment.center,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
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
                scrollDirection: Axis.horizontal,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: postLowerBar(
                  context,
                  widget.post,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  iconColor: ColorManager.eggshellWhite,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.post.images![index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * 0.5,
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
    );
  }
}
