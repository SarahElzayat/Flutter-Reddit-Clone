import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

import '../../components/multi_manager/flick_multi_player.dart';
import '../../cubit/videos_cubit/videos_cubit.dart';
import '../../data/post_model/post_model.dart';
import '../../networks/constant_end_points.dart';

Widget videoBody(context, PostModel post,
    {isFull = false, FlickManager? oldFm}) {
  // return Container();
  return FlickMultiPlayer(
    url: post.video ?? '',
    isFull: isFull,
    flickMultiManager: VideosCubit.get(context).flickMultiManager,
    alreadyflickManager: oldFm,
    image: unknownAvatar,
    post: post,
  );
}
