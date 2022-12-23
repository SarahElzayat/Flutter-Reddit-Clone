/// The inline video viewer
/// date: 20/12/2022
/// @Author: Ahmed Atta
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import '../../components/multi_manager/flick_multi_player.dart';
import '../../cubit/videos_cubit/videos_cubit.dart';
import '../../data/post_model/post_model.dart';
import '../../networks/constant_end_points.dart';

/// This is a custom video player that can be used in a listview.
/// it requires the [context] and the [post] to be passed to it.
/// it also nmight need the [isFull] to be passed to it to know if the video is full screen or not.
/// it also nmight need the [oldFm] to be passed to it to know if was Played before or not.
Widget videoBody(context, PostModel post,
    {isFull = false, FlickManager? oldFm}) {
  // return Container();
  return FlickMultiPlayer(
    url: '$baseUrl/${post.video ?? ''}',
    isFull: isFull,
    flickMultiManager: VideosCubit.get(context).flickMultiManager,
    alreadyflickManager: oldFm,
    image: unknownAvatar,
    post: post,
  );
}
