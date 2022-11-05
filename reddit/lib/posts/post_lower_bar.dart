import 'package:flutter/material.dart';
import 'package:reddit/posts/post_data.dart';
import '../Components/helpers/color_manager.dart';
import 'helper_funcs.dart';

Widget postLowerBar(
  BuildContext context,
  Post post, {
  Color backgroundColor = Colors.transparent,
  Color iconColor = ColorManager.greyColor,
  EdgeInsets pad = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
  bool isMod = false,
}) {
  return Container(
    color: backgroundColor,
    child: Padding(
      padding: pad,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: iconColor,
                ),
                Text(
                  '1.2k',
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 15,
                  ),
                ),
                Icon(
                  Icons.arrow_downward,
                  color: iconColor,
                ),
              ],
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                goToPost(context, post);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.comment_outlined,
                    color: iconColor,
                  ),
                  Text(
                    '1.2k',
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          Expanded(
            flex: 4,
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: !isMod
                    ? [
                        Icon(
                          Icons.share,
                          color: iconColor,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(
                            color: iconColor,
                            fontSize: 15,
                          ),
                        ),
                      ]
                    : [
                        Icon(
                          Icons.shield_outlined,
                          color: iconColor,
                        ),
                        Text(
                          'Mod',
                          style: TextStyle(
                            color: iconColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
