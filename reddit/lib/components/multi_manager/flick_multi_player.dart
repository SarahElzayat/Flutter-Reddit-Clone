import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reddit/components/multi_manager/portrait_controls.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import './flick_multi_manager.dart';
import 'fullscreen_controls.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer(
      {Key? key,
      required this.url,
      this.image,
      required this.post,
      this.isFull = false,
      this.alreadyflickManager,
      required this.flickMultiManager})
      : super(key: key);

  final String url;
  final String? image;
  final PostModel post;
  final bool isFull;
  final FlickManager? alreadyflickManager;
  final FlickMultiManager flickMultiManager;

  @override
  State<FlickMultiPlayer> createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = widget.alreadyflickManager ??
        FlickManager(
          videoPlayerController: VideoPlayerController.network(widget.url)
            ..setLooping(true),
          autoPlay: false,
        );

    if (widget.alreadyflickManager == null) {
      widget.flickMultiManager.init(flickManager);
    }

    super.initState();
  }

  @override
  void dispose() {
    // only if this is not a manager from the prev page
    if (widget.alreadyflickManager == null) {
      widget.flickMultiManager.remove(flickManager);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction > 0.9) {
          widget.flickMultiManager.play(flickManager);
        }
        // if less than 90% visible pause video.
        if (visiblityInfo.visibleFraction < 0.9) {
          widget.flickMultiManager.pause();
        }
      },
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          videoFit: widget.isFull ? BoxFit.contain : BoxFit.cover,
          playerLoadingFallback: Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.image!,
                    fit: widget.isFull ? BoxFit.fitWidth : BoxFit.cover,
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          iconThemeData: widget.isFull
              ? const IconThemeData(
                  size: 40,
                  color: Colors.white,
                )
              : const IconThemeData(
                  color: Colors.white,
                  size: 20,
                ),
          textStyle: widget.isFull
              ? const TextStyle(fontSize: 16, color: Colors.white)
              : const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
          controls: widget.isFull
              ? FullScreenPortraitControls(
                  flickMultiManager: widget.flickMultiManager,
                  flickManager: flickManager,
                  post: widget.post,
                )
              : FeedPlayerPortraitControls(
                  flickMultiManager: widget.flickMultiManager,
                  flickManager: flickManager,
                  post: widget.post),
        ),
        preferredDeviceOrientationFullscreen: const [
          DeviceOrientation.portraitUp,
        ],
        // flickVideoWithControlsFullscreen: FlickVideoWithControls(
        //   playerLoadingFallback: Center(
        //       child: Image.network(
        //     widget.image!,
        //     fit: BoxFit.fitWidth,
        //   )),
        //   controls: FullScreenPortraitControls(
        //     flickMultiManager: widget.flickMultiManager,
        //     flickManager: flickManager,
        //     post: widget.post,
        //   ),
        //   videoFit: BoxFit.contain,
        //   iconThemeData: const IconThemeData(
        //     size: 40,
        //     color: Colors.white,
        //   ),
        //   textStyle: const TextStyle(fontSize: 16, color: Colors.white),
        // ),
      ),
    );
  }
}
