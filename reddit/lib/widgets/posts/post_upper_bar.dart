/// The upper bar of the post that contains the avatar, title and the subreddit and so on
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../Components/helpers/color_manager.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../cubit/post_notifier/post_notifier_state.dart';
import '../../data/post_model/post_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dropdown_list.dart';

bool isjoined = true;

enum ShowingOtions { onlyUser, onlySubreddit, both }

class PostUpperBar extends StatefulWidget {
  const PostUpperBar({
    Key? key,
    required this.post,
    this.showRowsSelect = ShowingOtions.both,
    this.outSide = true,
  }) : super(key: key);

  /// The post to be displayed
  final PostModel post;

  /// if the single row should be shown
  ///
  /// it's passed because the post don't require the subreddit to be shown in
  /// the sunreddit screen for example
  final ShowingOtions showRowsSelect;

  /// if the post is in the home page or in the post screen
  final bool outSide;

  @override
  State<PostUpperBar> createState() => _PostUpperBarState();
}

class _PostUpperBarState extends State<PostUpperBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConditionalSwitch.single<ShowingOtions>(
            context: context,
            valueBuilder: (BuildContext context) {
              return widget.showRowsSelect;
            },
            caseBuilders: {
              ShowingOtions.onlyUser: (ctx) {
                return _singleRow(
                    name: widget.post.postedBy!,
                    timeAgo: widget.post.postedAt!,
                    sub: false);
              },
              ShowingOtions.onlySubreddit: (_) {
                return _singleRow(
                    name: widget.post.subreddit!,
                    timeAgo: widget.post.postedAt!,
                    sub: true);
              },
              ShowingOtions.both: (_) {
                return _bothRows();
              },
            },
            fallbackBuilder: (BuildContext context) {
              return _bothRows();
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: _tagsRow(),
          ),

          // The title of the post
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  widget.post.title ?? '',
                  style: const TextStyle(
                    color: ColorManager.eggshellWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Spacer(),
              if (widget.post.kind == 'link' && widget.outSide)
                InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse(widget.post.content!));
                  },
                  child: SizedBox(
                    width: min(30.w, 120),
                    height: min(30.w, 100),
                    child: AnyLinkPreview.builder(
                      errorWidget: imageWithUrl(
                          'https://cdn-icons-png.flaticon.com/512/3388/3388466.png'),
                      link: widget.post.content ?? '',
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
          if (widget.post.flair != null &&
              !(widget.post.kind == 'link' && widget.outSide))
            _flairWidget()
        ],
      ),
    );
  }

  SizedBox _bothRows() {
    return SizedBox(
      child: Row(
        children: [
          subredditAvatar(),
          SizedBox(
            width: min(3.w, 0.1.dp),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'r/${widget.post.subreddit ?? ''}',
                style: const TextStyle(
                  color: ColorManager.eggshellWhite,
                  fontSize: 15,
                ),
              ),
              _singleRow(
                  name: widget.post.postedBy ?? '',
                  timeAgo: widget.post.postedAt ?? '',
                  sub: false),
            ],
          ),
          const Spacer(),
          if (!isjoined)
            InkWell(
              onTap: () {
                setState(() {
                  isjoined = true;
                });
              },
              child: const Chip(
                label: Text(
                  'Join',
                  style: TextStyle(
                    color: ColorManager.eggshellWhite,
                  ),
                ),
                backgroundColor: ColorManager.blue,
              ),
            )
          else if (widget.outSide)
            BlocBuilder<PostNotifierCubit, PostNotifierState>(
              builder: (context, state) {
                return DropDownList(
                  postId: widget.post.id!,
                  itemClass: (widget.post.saved ?? true)
                      ? ItemsClass.publicSaved
                      : ItemsClass.public,
                );
              },
            ),
        ],
      ),
    );
  }

  CircleAvatar subredditAvatar({small = false}) {
    return CircleAvatar(
      radius: small ? min(4.w, 15) : min(5.5.w, 30),
      child: Image.network(
          'https://styles.redditmedia.com/t5_2qh87/styles/communityIcon_ub69d1lpjlf51.png?width=256&s=920c352b6d0c69518b6978ba8b456176a8d63c25'),
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
              (widget.post.content ?? '')
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

  Row _tagsRow() {
    return Row(
      children: [
        if (widget.post.nsfw ?? false)
          Row(
            children: const [
              Icon(Icons.eighteen_up_rating, color: ColorManager.red, size: 20),
              Text('NSFW',
                  style: TextStyle(
                    color: ColorManager.red,
                    fontSize: 13,
                  )),
            ],
          ),
        if (widget.post.nsfw ?? false) const SizedBox(width: 5),
        if (widget.post.spoiler ?? false)
          Row(
            children: const [
              Icon(Icons.privacy_tip_outlined,
                  color: ColorManager.eggshellWhite, size: 20),
              Text('Spoiler',
                  style: TextStyle(
                    color: ColorManager.eggshellWhite,
                    fontSize: 13,
                  )),
            ],
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
          color: HexColor(widget.post.flair!.backgroundColor ?? '#FF00000'),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.post.flair!.flairText ?? '',
          style: TextStyle(
              color: HexColor(widget.post.flair!.textColor ?? '#FFFFFF')),
        ),
      ),
    );
  }

  Row _singleRow(
      {required String name, required String timeAgo, bool sub = false}) {
    return Row(
      children: [
        subredditAvatar(small: true),
        SizedBox(
          width: min(5.w, 0.2.dp),
        ),
        Text(
          '${sub ? 'r' : 'u'}/$name • ',
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
        Text(
          timeago.format(DateTime.parse(timeAgo), locale: 'en_short'),
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
