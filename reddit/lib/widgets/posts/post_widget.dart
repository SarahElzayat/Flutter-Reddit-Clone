/// The Main Post Widget that shows in the home and other places
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:reddit/widgets/posts/cubit/post_cubit.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'post_lower_bar.dart';
import 'post_upper_bar.dart';
import '../../widgets/posts/inline_image_viewer.dart';
import '../../widgets/posts/votes_widget.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/helpers/posts/helper_funcs.dart';
import '../../data/post_model/post_model.dart';

/// The widget that displays the post
///
/// it's inteded to be used in the HOME PAGE
class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
    this.outsideScreen = true,
    this.upperRowType = ShowingOtions.both,
  });

  /// determines if the post is in the home page or in the post screen
  final bool outsideScreen;

  /// the post to show
  final PostModel post;

  /// if the single or a detailed row should be shown in the upper part of the post
  ///
  /// it's passed because the post don't require the subreddit to be shown in
  /// the sunreddit screen for example
  final ShowingOtions upperRowType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(post),
      child: ResponsiveBuilder(
        builder: (buildContext, sizingInformation) {
          bool isWeb =
              sizingInformation.deviceScreenType != DeviceScreenType.mobile;
          return Container(
            color: ColorManager.darkGreyBlack,
            // margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 5),
            // a Row that contains the votes column and post
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isWeb)
                  VotesPart(
                    post: post,
                    isWeb: isWeb,
                  ),
                Expanded(
                  child: InkWell(
                    onTap: outsideScreen
                        ? () {
                            goToPost(context, post);
                          }
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // A row with the Avatar, title and the subreddit
                        PostUpperBar(
                          post: post,
                          outSide: outsideScreen,
                          showRowsSelect: upperRowType,
                        ),
                        // The body of the post
                        if (post.images?.isNotEmpty ?? false)
                          InlineImageViewer(
                            key: const Key('inline-image-viewer'),
                            post: post,
                          ),

                        // The body text of the post
                        ConditionalSwitch.single(
                          context: context,
                          valueBuilder: (context) {
                            if ((post.kind == 'text' || !outsideScreen) &&
                                post.kind != 'link') {
                              return 'text';
                            } else if (post.kind == 'link' && !outsideScreen) {
                              return 'link';
                            }
                            return 'notAny';
                          },
                          caseBuilders: {
                            'text': (context) => normalContent(),
                            'link': (context) => linkContent(),
                          },
                          fallbackBuilder: (context) => Container(),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isWeb)
                              Expanded(flex: 1, child: VotesPart(post: post)),
                            Expanded(
                              flex: 2,
                              child: PostLowerBarWithoutVotes(
                                  post: post,
                                  isWeb: isWeb,
                                  pad: const EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 10)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget normalContent() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2,
        right: 5,
        top: 5,
      ),
      child: Html(
        data: md.markdownToHtml(post.content ?? ''),
        shrinkWrap: true,
        style: {
          '#': Style(
            color: outsideScreen
                ? ColorManager.greyColor
                : ColorManager.eggshellWhite,
            fontSize: const FontSize(15),
            fontWeight: FontWeight.w500,
            maxLines: outsideScreen ? 3 : null,
            textOverflow: outsideScreen ? TextOverflow.ellipsis : null,
            // margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
          ),
        },
      ),
    );
  }

  Widget linkContent() {
    return InkWell(
      key: const Key('link-content'),
      onTap: () async {
        await launchUrl(Uri.parse(post.content!));
      },
      child: Container(
          constraints: const BoxConstraints(
            minHeight: 40,
          ),
          color: ColorManager.grey,
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                post.content ?? '',
                style: const TextStyle(
                  color: ColorManager.eggshellWhite,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.open_in_new,
                color: ColorManager.eggshellWhite,
                size: 15.sp,
              )
            ],
          )),
    );
  }
}
