/// The upper bar of the post that contains the avatar, title and the subreddit and so on
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../Components/helpers/color_manager.dart';
import '../../constants/constants.dart';
import '../../data/post_model/post_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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

  static Widget _buildItem(text, icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

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
                    height: 15.w,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5.5.w,
                          child: const Icon(Icons.category_sharp),
                        ),
                        SizedBox(
                          width: 3.w,
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
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              customButton: const Icon(
                                Icons.more_vert,
                              ),
                              items: [
                                ...MenuItems.allItems.map(
                                  (item) => DropdownMenuItem<MenuItem>(
                                    value: item,
                                    child: MenuItems.buildItem(item),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                MenuItems.onChanged(context, value as MenuItem);
                              },
                              dropdownWidth: 40.w,
                              dropdownPadding:
                                  const EdgeInsets.symmetric(vertical: 6),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              dropdownElevation: 8,
                              offset: const Offset(0, 8),
                            ),
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

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> allItems = [save, hide, report, block];

  static const save = MenuItem(text: 'Save', icon: Icons.bookmark_border);
  static const hide = MenuItem(text: 'Hide post', icon: Icons.visibility_off);
  static const report = MenuItem(text: 'Report', icon: Icons.flag_outlined);
  static const block = MenuItem(text: 'Block Acount', icon: Icons.block);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.save:
        //Do something
        DioHelper.postData(
          path: '$base2/save',
          data: {
            'id': '5f9f1b0b0b9b8c0017b0b0b1',
          },
        ).then((value) => print(value.data));
        break;
      case MenuItems.report:
        //Do something
        break;
      case MenuItems.hide:
        //Do something
        DioHelper.postData(
          path: '$base2/hide',
          data: {
            'id': '5f9f1b0b0b9b8c0017b0b0b1',
          },
        ).then((value) => print(value.data));
        break;
      case MenuItems.block:
        //Do something
        DioHelper.postData(
          path: '$base2/block',
          data: {
            'id': '5f9f1b0b0b9b8c0017b0b0b1',
          },
        ).then((value) => print(value.data));
        break;
    }
  }
}
