import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart';
import 'package:reddit/widgets/posts/inline_image_viewer.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/helpers/posts/helper_funcs.dart';
import 'post_lower_bar.dart';
import '../../Data/post_model/post_model.dart';
import 'post_upper_bar.dart';

/// The widget that displays the post
///
/// it's inteded to be used in the HOME PAGE
class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
    this.outsideScreen = true,
  });

  /// determines if the post is in the home page or in the post screen
  final bool outsideScreen;

  /// the post to show
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, boxConstraints) {
        return Container(
          color: ColorManager.darkGrey,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            onTap: outsideScreen
                ? () {
                    goToPost(context, post);
                  }
                : null,
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
                      left: 5,
                      right: 5,
                      top: 5,
                    ),
                    child: Html(
                      data: markdownToHtml(post.content ?? ''),
                      shrinkWrap: true,
                      style: {
                        '#': Style(
                          color: outsideScreen
                              ? ColorManager.greyColor
                              : ColorManager.white,
                          fontSize: const FontSize(15),
                          maxLines: outsideScreen ? 3 : null,
                          textOverflow:
                              outsideScreen ? TextOverflow.ellipsis : null,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                        ),
                      },
                    ),
                  ),

                PostLowerBar(
                    post: post,
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
