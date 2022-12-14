import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import './flick_multi_manager.dart';
import 'portrait_controls.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer(
      {Key? key,
      required this.url,
      this.image,
      required this.flickMultiManager})
      : super(key: key);

  final String url;
  final String? image;
  final FlickMultiManager flickMultiManager;

  @override
  State<FlickMultiPlayer> createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url)
        ..setLooping(true),
      autoPlay: false,
    );
    widget.flickMultiManager.init(flickManager);

    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager.remove(flickManager);
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
          playerLoadingFallback: Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.image!,
                    fit: BoxFit.cover,
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
          
          controls: FeedPlayerPortraitControls(
            flickMultiManager: widget.flickMultiManager,
            flickManager: flickManager,
          ),
        ),
        flickVideoWithControlsFullscreen: FlickVideoWithControls(
          playerLoadingFallback: Center(
              child: Image.network(
            widget.image!,
            fit: BoxFit.fitWidth,
          )),
          controls: FlickLandscapeControls(),
          iconThemeData: IconThemeData(
            size: 40,
            color: Colors.white,
          ),
          textStyle: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
