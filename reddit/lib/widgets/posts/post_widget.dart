/// The Main Post Widget that shows in the home and other places
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'package:flutter/foundation.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_state.dart';
import 'package:reddit/widgets/comments/comment.dart';
import 'package:reddit/widgets/posts/video_page_view.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'dart:math';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/functions/post_functions.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/post_lower_bar_without_votes.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/helpers/posts/helper_funcs.dart';
// import '../../cubit/videos_cubit/videos_cubit.dart';
import '../../components/helpers/widgets/responsive_widget.dart';
import '../../data/comment/comment_model.dart';
import '../../data/post_model/post_model.dart';
import '../../widgets/posts/inline_image_viewer.dart';
import '../../widgets/posts/votes_widget.dart';
import 'actions_cubit/post_comment_actions_state.dart';
import 'inline_video_viewer.dart';
import 'post_upper_bar.dart';

/// The widget that displays the post
///
/// it's inteded to be used in the HOME PAGE
class PostWidget extends StatefulWidget {
  const PostWidget({
    super.key,
    required this.post,
    this.outsideScreen = true,
    this.isNested = false,
    this.inSearch = false,
    this.upperRowType = ShowingOtions.both,
    this.postView = PostView.card,
    this.comment,
    this.insideProfiles = false,
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

  /// determines if the post is a nested post or not
  /// if yes then the post will be shown in a compact way
  final bool isNested;

  /// determines if the post is in the search screen or not
  /// if yes then the post will be shown in a compact way
  final bool inSearch;

  /// the comment that the post is related to
  /// it's used to show the comment in the Search screen
  final CommentModel? comment;

  /// determines if the post is inside the profiles screen or not
  /// if yes then the post will be shown in a different way
  final bool insideProfiles;
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  PostModel? childPost;
  @override
  void initState() {
    if (widget.post.kind == 'post') {
      // get child post if it's a hybrid post
      DioHelper.getData(path: '/post-details', query: {
        'id': widget.post.sharePostId,
      }).then((value) {
        if (value.statusCode == 200 && mounted) {
          setState(() {
            childPost = PostModel.fromJson(value.data);
            logger.d(childPost!.title);
          });
        }
      }).catchError((e) {
        logger.e(e);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostAndCommentActionsCubit(post: widget.post)
        ..getSubDetails()
        ..getUserDetails(),
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
                child: BlocConsumer<PostNotifierCubit, PostNotifierState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isWeb)
                              VotesPart(
                                post: widget.post,
                                isWeb: isWeb,
                              ),
                            Expanded(
                              child: InkWell(
                                onTap: widget.outsideScreen
                                    ? () {
                                        goToPost(
                                          context,
                                          widget.post,
                                          widget.upperRowType,
                                        );
                                      }
                                    : null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // A row with the Avatar, title and the subreddit
                                    _upperPart(isWeb),
                                    // title and flairs
                                    _titleWithFlairs(),

                                    // image or video viewrs
                                    if (widget.postView == PostView.card)
                                      InlineImageViewer(
                                        key: const Key('inline-image-viewer'),
                                        post: widget.post,
                                        isWeb: isWeb,
                                        outsideScreen: widget.outsideScreen,
                                      ),

                                    // the body text or the link bar
                                    ConditionalSwitch.single(
                                      context: context,
                                      valueBuilder: (context) {
                                        if (widget.postView ==
                                            PostView.withCommentsInSearch) {
                                          return 'commentBody';
                                        }
                                        if (widget.post.kind == 'post') {
                                          return 'postBody';
                                        }
                                        if (widget.post.kind == 'video') {
                                          return 'videoBody';
                                        }
                                        if (_showTextBody()) {
                                          return 'bodytext';
                                        }
                                        if (widget.post.kind == 'link' &&
                                            !widget.outsideScreen) {
                                          return 'link';
                                        }

                                        return 'notAny';
                                      },
                                      caseBuilders: {
                                        'commentBody': (context) =>
                                            _commentBody(),
                                        'bodytext': (context) => _bodyText(),
                                        'link': (context) => _linkBar(),
                                        'videoBody': (context) => InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      WholeScreenVideoViewer(
                                                    post: widget.post,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: videoBody(
                                                context, widget.post)),
                                        'postBody': (context) => _postBody(),
                                      },
                                      fallbackBuilder: (context) => Container(),
                                    ),
                                    SizedBox(height: 1.h),
                                    _lowerPart(isWeb),
                                    BlocBuilder<PostAndCommentActionsCubit,
                                        PostActionsState>(
                                      builder: (context, state) {
                                        return AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child:
                                                (PostAndCommentActionsCubit.get(
                                                            context)
                                                        .showModTools)
                                                    ? _modRow(context)
                                                    : Container(
                                                        key: const Key(
                                                            'mod-row-empty'),
                                                      ));
                                      },
                                    ),
                                    if (!widget.outsideScreen && !isWeb)
                                      commentSortRow(context),

                                    if (widget.postView ==
                                        PostView.withCommentsInSearch)
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              goToPost(
                                                context,
                                                widget.post,
                                                widget.upperRowType,
                                              );
                                            },
                                            child: const Text(
                                              'View comments',
                                              style: TextStyle(
                                                color: ColorManager.hoverOrange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if ((widget.post.kind != 'link') &&
                                widget.postView == PostView.classic)
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: InlineImageViewer(
                                  key: const Key('inline-image-viewer'),
                                  post: widget.post,
                                  isWeb: isWeb,
                                  postView: widget.postView,
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _upperPart(isWeb) {
    if (widget.isNested) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.post.subreddit?.isNotEmpty ?? false)
            Text(
              'r/${widget.post.subreddit}',
              style: const TextStyle(
                color: ColorManager.lightGrey,
                fontSize: 15,
              ),
            ),
          Text(
            '• ${timeago.format(DateTime.tryParse(widget.post.postedAt ?? '') ?? DateTime.now(), locale: 'en_short')}',
            style: const TextStyle(
              color: ColorManager.greyColor,
              fontSize: 15,
            ),
          ),
          Text(
            ' u/${widget.post.postedBy ?? ''}',
            style: const TextStyle(
              color: ColorManager.lightGrey,
              fontSize: 15,
            ),
          ),
        ],
      );
    }

    return PostUpperBar(
      post: widget.post,
      outSide: widget.outsideScreen,
      showRowsSelect: widget.upperRowType,
      isWeb: isWeb,
    );
  }

  bool _showTextBody() {
    return (!widget.outsideScreen && widget.post.kind != 'link') ||
        (widget.outsideScreen &&
            widget.post.kind == 'hybrid' &&
            ((((widget.post.content ?? {'ops': []})['ops'] ?? false).length >
                    90) ||
                widget.post.kind == 'hybrid'));
  }

  Widget _lowerPart(bool isWeb) {
    if (widget.isNested ||
        widget.postView == PostView.withCommentsInSearch ||
        widget.inSearch) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${widget.post.votes ?? 0} points',
            style: const TextStyle(
              color: ColorManager.lightGrey,
              fontSize: 15,
            ),
          ),
          Text(
            ' • ${widget.post.comments ?? 0} comments',
            style: const TextStyle(
              color: ColorManager.lightGrey,
              fontSize: 15,
            ),
          ),
        ],
      );
    }
    if (kIsWeb) {
      return Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          if (!isWeb) VotesPart(post: widget.post),
          if (!isWeb) SizedBox(width: 1.w),
          PostLowerBarWithoutVotes(
              post: widget.post,
              isWeb: isWeb,
              showIsights: widget.insideProfiles,
              pad: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10)),
        ],
      );
    }
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(flex: 1, child: VotesPart(post: widget.post)),
        Expanded(
          flex: 2,
          child: PostLowerBarWithoutVotes(
              post: widget.post,
              isWeb: isWeb,
              showIsights: widget.insideProfiles,
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
            onPressed: () {
              handleApprove(
                  post: widget.post,
                  onSuccess: () {
                    PostNotifierCubit.get(context).notifyPosts();

                    ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                      message: 'Post Approved',
                      error: false,
                    ));
                  },
                  onError: (err) {
                    PostNotifierCubit.get(context).notifyPosts();

                    ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                      message:
                          err.response?.data['error'] ?? 'Something went wrong',
                      error: false,
                    ));
                  });
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            icon: Icon(
              Icons.check,
              color: isApproved(widget.post)
                  ? ColorManager.green
                  : ColorManager.greyColor,
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
            onPressed: () {
              handleSpam(
                  onSuccess: () {
                    PostNotifierCubit.get(context).notifyPosts();
                    ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                      message: 'Post Marked Spam',
                      error: false,
                    ));
                  },
                  onError: (err) {
                    PostNotifierCubit.get(context).notifyPosts();
                    ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                      message:
                          err.response?.data['error'] ?? 'Something went wrong',
                      error: false,
                    ));
                  },
                  post: widget.post);
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            icon: Icon(
              Icons.block,
              color: isSpammed(widget.post)
                  ? ColorManager.red
                  : ColorManager.greyColor,
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
            onPressed: () {
              handleRemove(
                  onSuccess: () {
                    PostNotifierCubit.get(context).notifyPosts();
                    ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                      message: 'Post Removed',
                      error: false,
                    ));
                  },
                  onError: (err) {
                    PostNotifierCubit.get(context).notifyPosts();
                    ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                      message:
                          err.response?.data['error'] ?? 'Something went wrong',
                      error: false,
                    ));
                  },
                  post: widget.post);
            },
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            icon: Icon(
              Icons.delete,
              color: isRemoved(widget.post)
                  ? ColorManager.gradientRed
                  : ColorManager.greyColor,
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
              showModOperations(context: context, post: widget.post);
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
    return BlocBuilder<PostNotifierCubit, PostNotifierState>(
      builder: (context, state) {
        return QuillEditor(
          controller: getController(),
          readOnly: true,
          autoFocus: false,
          enableInteractiveSelection: false,
          expands: false,
          scrollable: false,
          placeholder: '',
          customStyles: DefaultStyles(
            paragraph: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 14,
                color: ColorManager.eggshellWhite,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const Tuple2(16, 0),
              const Tuple2(0, 0),
              const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            code: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 14,
                color: ColorManager.eggshellWhite,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const Tuple2(16, 0),
              const Tuple2(0, 0),
              const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            inlineCode: InlineCodeStyle(
                style: const TextStyle(color: ColorManager.eggshellWhite)),
            h1: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 32,
                color: ColorManager.eggshellWhite,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const Tuple2(16, 0),
              const Tuple2(0, 0),
              const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            link: const TextStyle(
              fontSize: 14,
              color: ColorManager.eggshellWhite,
              height: 1.15,
              fontWeight: FontWeight.w600,
            ),
            sizeSmall: const TextStyle(fontSize: 9),
          ),
          scrollController: ScrollController(),
          focusNode: FocusNode(),
          padding: EdgeInsets.zero,
          embedBuilders: [
            ...FlutterQuillEmbeds.builders(),
          ],
        );
      },
    );
  }

  QuillController getController() {
    Document doc;

    try {
      doc = Document.fromJson((widget.post.content ?? {'ops': []})['ops']);
    } catch (e) {
      doc = Document();
    }

    return QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  Widget _linkBar() {
    return InkWell(
      key: const Key('link-content'),
      onTap: () async {
        await launchUrl(Uri.parse(widget.post.link!));
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
                widget.post.link ?? '',
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
                  widget.post.title ?? '',
                  style: const TextStyle(
                    color: ColorManager.eggshellWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            if (widget.post.kind == 'link' && widget.outsideScreen)
              InkWell(
                onTap: () async {
                  await launchUrl(Uri.parse(widget.post.link!));
                },
                child: SizedBox(
                  width: min(30.w, 120),
                  height: min(30.w, 100),
                  child: AnyLinkPreview.builder(
                    errorWidget: imageWithUrl(
                        'https://cdn-icons-png.flaticon.com/512/3388/3388466.png'),
                    link: widget.post.link ?? '',
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
        if (widget.post.flair?.id != null &&
            !(widget.post.kind == 'link' && widget.outsideScreen))
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
              (widget.post.link ?? '')
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
    logger.d('flair: ${widget.post.flair!}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: HexColor(widget.post.flair!.backgroundColor ?? '#FF0000'),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.post.flair!.flairName ?? '',
          style: TextStyle(
              color: HexColor(widget.post.flair!.textColor ?? '#FFFFFF')),
        ),
      ),
    );
  }

  Widget _postBody() {
    if (childPost != null) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: PostWidget(
            post: childPost!,
            isNested: true,
          ),
        ),
      );
    }
    return Container();
  }

  Widget _commentBody() {
    return Comment(
      post: widget.post,
      comment: widget.comment!,
      viewType: CommentView.inSearch,
    );
  }
}
