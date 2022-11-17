/// The upper bar of the post that contains the avatar, title and the subreddit and so on
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../Components/helpers/color_manager.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../cubit/post_notifier/post_notifier_state.dart';
import '../../data/post_model/post_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dropdown_list.dart';
import 'menu_items.dart' as mi;

bool isjoined = true;
const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class PostUpperBar extends StatefulWidget {
  const PostUpperBar({
    Key? key,
    required this.post,
    this.showSubReddit = true,
    this.outSide = true,
  }) : super(key: key);

  /// The post to be displayed
  final PostModel post;

  /// if the subreddit should be shown
  ///
  /// it's passed because the post don't require the subreddit to be shown in
  /// the sunreddit screen
  final bool showSubReddit;

  final bool outSide;

  @override
  State<PostUpperBar> createState() => _PostUpperBarState();
}

class _PostUpperBarState extends State<PostUpperBar> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConditionalBuilder(
              condition: widget.showSubReddit,
              builder: (context) => SizedBox(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: min(5.5.w, 30),
                          child: const Icon(Icons.category_sharp),
                        ),
                        SizedBox(
                          width: min(3.w, 10.dp),
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
                            userRow(),
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
                  ),
              fallback: (context) => userRow()),

          if (widget.post.nsfw ?? false)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: const [
                  Icon(Icons.eighteen_up_rating, color: ColorManager.red),
                  Text('NSFW',
                      style: TextStyle(
                        color: ColorManager.red,
                        fontSize: 15,
                      )),
                ],
              ),
            ),

          // The title of the post
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
          if (widget.post.flair != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: HexColor(
                      widget.post.flair!.backgroundColor ?? '#FF00000'),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  widget.post.flair!.flairText ?? '',
                  style: TextStyle(
                      color:
                          HexColor(widget.post.flair!.textColor ?? '#FFFFFF')),
                ),
              ),
            )
        ],
      ),
    );
  }

  Row userRow() {
    return Row(
      children: [
        Text(
          'u/${widget.post.postedBy} • ',
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
        Text(
          timeago.format(DateTime.parse(widget.post.postedAt!),
              locale: 'en_short'),
          style: const TextStyle(
            color: ColorManager.greyColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
