/// this file is used to define the normal controls for the video player
/// date: 16/12/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:reddit/data/post_model/post_model.dart';

import '../../widgets/posts/video_page_view.dart';
import 'flick_multi_manager.dart';

/// defines the normal controls for the video player
///
/// it is used in the Player widget when the video is in normal mode
class FeedPlayerPortraitControls extends StatelessWidget {
  final PostModel post;

  const FeedPlayerPortraitControls(
      {Key? key, this.flickMultiManager, this.flickManager, required this.post})
      : super(key: key);

  final FlickMultiManager? flickMultiManager;
  final FlickManager? flickManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: FlickToggleSoundAction(
              toggleMute: () {
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
            ],
          ),
        ],
      ),
    );
  }
}
