import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:reddit/posts/custom_markdown.dart';
import 'package:reddit/posts/post_screen.dart';
import 'package:reddit/posts/inline_image_viewer.dart';

import '../components/helpers/color_manager.dart';
import 'helper_funcs.dart';
import 'post_lower_bar.dart';
import 'post_data.dart';
import 'post_upper_bar.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
    this.outsideScreen = true,
  });
  final bool outsideScreen;
  final Post post;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, boxConstraints) {
        return Container(
          color: ColorManager.darkGrey,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            onTap: () {
              goToPost(context, post);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // A row with the Avatar, title and the subreddit
                PostUpperBar(post: post),
                // The body of the post
                if (post.images != null && post.images!.isNotEmpty)
                  InlineImageViewer(
                    post: post,
                  ),

                if (post.images == null || !outsideScreen)
                  Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                      ),
                      // child: Text(
                      //   post.body ?? '',
                      //   style: TextStyle(
                      //     color: outsideScreen
                      //         ? ColorManager.greyColor
                      //         : ColorManager.white,
                      //     fontSize: 15,
                      //   ),
                      //   maxLines: outsideScreen ? 3 : null,
                      //   overflow: outsideScreen ? TextOverflow.ellipsis : null,
                      // ),
                      child: MarkdownBody(
                        data: post.body ?? '',
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                            color: outsideScreen
                                ? ColorManager.greyColor
                                : ColorManager.white,
                            fontSize: 15,
                          ),
                        ),
                      )),

                postLowerBar(context, post,
                    pad: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10))
              ],
            ),
          ),
        );
      },
    );
  }
}
