/// this file is used to define the full screen controls for the video player
/// date: 16/12/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../helpers/color_manager.dart';
import '../../widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import '../../widgets/posts/votes_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../data/post_model/post_model.dart';
import 'flick_multi_manager.dart';

/// defines the full screen controls for the video player
///
/// it is used in the Player widget when the video is in full screen mode
class FullScreenPortraitControls extends StatelessWidget {
  const FullScreenPortraitControls(
      {Key? key, this.flickMultiManager, this.flickManager, required this.post})
      : super(key: key);

  /// the multi manager used to control all video players
  final FlickMultiManager? flickMultiManager;

  /// the manager used to control the video player
  final FlickManager? flickManager;

  /// the post that contains the video
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    FlickDisplayManager displayManager =
        Provider.of<FlickDisplayManager>(context);
    return BlocProvider(
      create: ((context) => PostAndCommentActionsCubit(post: post)),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: FlickToggleSoundAction(
                toggleMute: () {
                  displayManager.handleShowPlayerControls();
                },
                child: const FlickSeekVideoAction(
                  child: Center(child: FlickVideoBuffer()),
                ),
              ),
            ),
            FlickAutoHideChild(
              child: Row(
                children: [
                  Text(
                    post.title!,
                    style: const TextStyle(color: ColorManager.eggshellWhite),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      VotesPart(
                        post: post,
                        iconColor: Colors.white,
                        isWeb: true,
                      ),
                      Icon(
                        Icons.share,
                        size: min(5.5.w, 30),
                      )
                    ],
                  ),
                ],
              ),
            ),
            FlickAutoHideChild(
              child: Row(
                children: [
                  const FlickPlayToggle(),
                  Expanded(child: FlickVideoProgressBar()),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        FlickSoundToggle(
                          toggleMute: () => flickMultiManager?.toggleMute(),
                          color: Colors.white,
                          size: min(5.5.w, 30),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
