import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:provider/provider.dart';
import 'package:reddit/data/post_model/post_model.dart';

import '../../cubit/videos_cubit/videos_cubit.dart';
import '../../widgets/posts/video_page_view.dart';
import 'flick_multi_manager.dart';

class FeedPlayerPortraitControls extends StatelessWidget {
  final PostModel post;

  const FeedPlayerPortraitControls(
      {Key? key, this.flickMultiManager, this.flickManager, required this.post})
      : super(key: key);

  final FlickMultiManager? flickMultiManager;
  final FlickManager? flickManager;

  @override
  Widget build(BuildContext context) {
    // FlickDisplayManager displayManager =
    // Provider.of<FlickDisplayManager>(context);

    FlickControlManager controlManager =
        Provider.of<FlickControlManager>(context);
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: FlickToggleSoundAction(
              toggleMute: () {
                // flickMultiManager?.toggleMute();
                // controlManager.toggleFullscreen();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WholeScreenVideoViewer(
                      post: post,
                      flickManager: flickManager,
                    ),
                  ),
                );
              },
              child: const FlickSeekVideoAction(
                child: Center(child: FlickVideoBuffer()),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlickSoundToggle(
                  toggleMute: () => flickMultiManager?.toggleMute(),
                  color: Colors.white,
                ),
              ),
              // const FlickFullScreenToggle(),
            ],
          ),
        ],
      ),
    );
  }
}
