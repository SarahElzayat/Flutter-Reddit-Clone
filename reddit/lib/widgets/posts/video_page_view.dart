/// The Image PageView that opens when clicking images
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/functions/post_functions.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/inline_video_viewer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../components/multi_manager/flick_multi_manager.dart';
import 'actions_cubit/post_comment_actions_state.dart';
import '../../data/post_model/post_model.dart';
import 'votes_widget.dart';

/// A widget that displays the images in all the Screen
/// it shows images with the help of [PageView]
/// and [PhotoViewGallery]
class WholeScreenVideoViewer extends StatefulWidget {
  /// Creates a widget that displays the images in all the Screen
  ///
  /// [post] and [initialIndex] cann't be null
  const WholeScreenVideoViewer({
    super.key,
    required this.post,
    this.flickManager,
  });
  final FlickManager? flickManager;

  /// The post to show
  final PostModel post;

  @override
  State<WholeScreenVideoViewer> createState() => _WholeScreenVideoViewerState();
}

class _WholeScreenVideoViewerState extends State<WholeScreenVideoViewer> {
  @override
  void initState() {
    widget.flickManager?.flickDisplayManager?.addListener(() {
      if (mounted) setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PostAndCommentActionsCubit(post: widget.post),
        child: BlocBuilder<PostAndCommentActionsCubit, PostState>(
          builder: (context, state) {
            return Column(
              children: [
                AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: widget.flickManager?.flickDisplayManager
                                ?.showPlayerControls ??
                            false
                        ? 1
                        : 0,
                    child: appBar(context)),
                Expanded(
                  child: Stack(
                    children: [
                      videoBody(context, widget.post,
                          isFull: true, oldFm: widget.flickManager),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black.withOpacity(0.5),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Text(
                'r/${widget.post.subreddit ?? '-'} • ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              // InkWell(
              //   onTap: () {
              //     debugPrint('joined');
              //   },
              //   child: Text(
              //     'Join',
              //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //           color: Colors.blue,
              //         ),
              //   ),
              // ),
              // Text(
              //   '  •   u/${widget.post.postedBy ?? '-'}  • ',
              //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //         color: Colors.white,
              //       ),
              // ),
              Text(
                timeago.format(DateTime.parse(widget.post.postedAt!),
                    locale: 'en_short'),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Spacer(),
              dropDownDots(widget.post),
            ],
          ),
          // Text(
          //   widget.post.title ?? '',
          //   style: Theme.of(context).textTheme.labelLarge!.copyWith(
          //         color: Colors.white,
          //       ),
          // ),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
