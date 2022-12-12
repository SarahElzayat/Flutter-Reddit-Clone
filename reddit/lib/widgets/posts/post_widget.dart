/// The Main Post Widget that shows in the home and other places
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:math';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/helpers/widgets/responsive_widget.dart';
import 'package:reddit/functions/post_functions.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/post_lower_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/helpers/posts/helper_funcs.dart';
import '../../data/post_model/post_model.dart';
import '../../widgets/posts/inline_image_viewer.dart';
import '../../widgets/posts/votes_widget.dart';
import 'actions_cubit/post_comment_actions_state.dart';
import 'post_upper_bar.dart';

/// The widget that displays the post
///
/// it's inteded to be used in the HOME PAGE
class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
    this.outsideScreen = true,
    this.upperRowType = ShowingOtions.both,
    this.postView = PostView.card,
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

  /// the view type of the post
  /// it's either a card or a classic view
  /// defaults to [PostView.card]
  final PostView postView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostAndCommentActionsCubit(post: post),
      child: ResponsiveBuilder(
        builder: (buildContext, sizingInformation) {
          bool isWeb = !ResponsiveWidget.isSmallScreen(context);
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                color: ColorManager.darkGreyBlack,
                // margin: const EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                // a Row that contains the votes column and post
                child: Column(
                  children: [
                    Row(
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
                                    goToPost(
                                      context,
                                      post,
                                      upperRowType,
                                    );
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
                                // title and flairs
                                _titleWithFlairs(),

                                // image or video viewrs
                                if (postView == PostView.card)
                                  InlineImageViewer(
                                    key: const Key('inline-image-viewer'),
                                    post: post,
                                    isWeb: isWeb,
                                    outsideScreen: outsideScreen,
                                  ),

                                // the body text or the link bar
                                ConditionalSwitch.single(
                                  context: context,
                                  valueBuilder: (context) {
                                    if ((!outsideScreen &&
                                            post.kind != 'link') ||
                                        (outsideScreen &&
                                            post.kind == 'hybrid' &&
                                            ((post.content ?? '').length >
                                                90))) {
                                      return 'bodytext';
                                    } else if (post.kind == 'link' &&
                                        !outsideScreen) {
                                      return 'link';
                                    }
                                    return 'notAny';
                                  },
                                  caseBuilders: {
                                    'bodytext': (context) => _bodyText(),
                                    'link': (context) => _linkBar(),
                                  },
                                  fallbackBuilder: (context) => Container(),
                                ),
                                SizedBox(height: 1.h),
                                _lowerPart(isWeb),
                                BlocBuilder<PostAndCommentActionsCubit,
                                    PostState>(
                                  builder: (context, state) {
                                    return AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: (PostAndCommentActionsCubit.get(
                                                    context)
                                                .showModTools)
                                            ? _modRow(context)
                                            : Container(
                                                key: const Key('mod-row-empty'),
                                              ));
                                  },
                                ),
                                if (!outsideScreen && !isWeb)
                                  commentSortRow(context),
                              ],
                            ),
                          ),
                        ),
                        if ((post.kind != 'link') &&
                            postView == PostView.classic)
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            width: constraints.maxWidth * 0.2,
                            height: constraints.maxWidth * 0.2,
                            child: InlineImageViewer(
                              key: const Key('inline-image-viewer'),
                              post: post,
                              isWeb: isWeb,
                              postView: postView,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Row _lowerPart(bool isWeb) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isWeb) Expanded(flex: 1, child: VotesPart(post: post)),
        Expanded(
          flex: 2,
          child: PostLowerBarWithoutVotes(
              post: post,
              isWeb: isWeb,
              pad: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10)),
        ),
      ],
    );
  }

  Widget _modRow(context) {
    return Row(
      key: const Key('mod-row'),
      children: [
        // a row of approve and delete icons
        // that are only visible to mods
        Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: IconButton(
            onPressed: () {},
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.check,
              color: ColorManager.greyColor,
            ),
            iconSize: min(5.5.w, 30),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: IconButton(
            onPressed: () {},
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.block,
              color: ColorManager.greyColor,
            ),
            iconSize: min(5.5.w, 30),
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: IconButton(
            onPressed: () {},
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.delete,
              color: ColorManager.greyColor,
            ),
            iconSize: min(5.5.w, 30),
          ),
        ),
        const Spacer(),
        Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: IconButton(
            onPressed: () {
              showModOperations(context: context, post: post);
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.menu,
              color: ColorManager.greyColor,
            ),
            iconSize: min(5.5.w, 30),
          ),
        ),
      ],
    );
  }

  Widget _bodyText() {
    return quill.QuillEditor(
      controller: quill.QuillController(
        document: quill.Document.fromJson(
          jsonDecode(post.content!),
        ),
        selection: const TextSelection.collapsed(offset: 0),
      ),
      readOnly: true,
      autoFocus: false,
      enableInteractiveSelection: false,
      expands: false,
      scrollable: false,
      scrollController: ScrollController(),
      focusNode: FocusNode(),
      padding: EdgeInsets.zero,
      embedBuilders: [
        ...FlutterQuillEmbeds.builders(),
      ],
    );
  }

  Widget _linkBar() {
    return InkWell(
      key: const Key('link-content'),
      onTap: () async {
        await launchUrl(Uri.parse(post.link!));
      },
      child: Container(
          constraints: const BoxConstraints(
            minHeight: 40,
          ),
          color: ColorManager.betterDarkGrey,
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                post.link ?? '',
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

  Widget _titleWithFlairs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  post.title ?? '',
                  style: const TextStyle(
                    color: ColorManager.eggshellWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            if (post.kind == 'link' && outsideScreen)
              InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(post.link!));
                },
                child: SizedBox(
                  width: min(30.w, 120),
                  height: min(30.w, 100),
                  child: AnyLinkPreview.builder(
                    errorWidget: imageWithUrl(
                        'https://cdn-icons-png.flaticon.com/512/3388/3388466.png'),
                    link: post.link ?? '',
                    cache: const Duration(hours: 1),
                    itemBuilder: (BuildContext ctx, Metadata md,
                        ImageProvider<Object>? ip) {
                      return imageWithUrl(md.image ?? '');
                    },
                  ),
                ),
              ),
          ],
        ),
        if (post.flair != null && !(post.kind == 'link' && outsideScreen))
          _flairWidget()
      ],
    );
  }

  Stack imageWithUrl(image) {
    return Stack(
      children: [
        Image.network(image ?? ''),
        Positioned(
          bottom: 0,
          child: Container(
            width: min(30.w, 50.dp),
            color: Colors.black.withOpacity(0.5),
            child: Text(
              (post.link ?? '')
                  .replaceAll('https://', '')
                  .replaceAll('www.', ''),
              style: const TextStyle(
                color: ColorManager.eggshellWhite,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _flairWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: HexColor(post.flair!.backgroundColor ?? '#FF00000'),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          post.flair!.flairName ?? '',
          style: TextStyle(color: HexColor(post.flair!.textColor ?? '#FFFFFF')),
        ),
      ),
    );
  }
}
