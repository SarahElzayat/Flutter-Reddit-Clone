import 'package:flutter/material.dart';
import 'package:reddit/posts/post_data.dart';
import '../Components/helpers/color_manager.dart';
import 'helper_funcs.dart';

Widget postBar(
  BuildContext context,
  Post post, {
  Color backgroundColor = Colors.transparent,
  EdgeInsets pad = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
}) {
  return Container(
    color: backgroundColor,
    child: Padding(
      padding: pad,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(
                Icons.arrow_upward,
                color: ColorManager.greyColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '1.2k',
                style: TextStyle(
                  color: ColorManager.greyColor,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_downward,
                color: ColorManager.greyColor,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              goToPost(context, post);
            },
            child: Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.comment,
                  color: ColorManager.greyColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '1.2k',
                  style: TextStyle(
                    color: ColorManager.greyColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.share,
                  color: ColorManager.greyColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Share',
                  style: TextStyle(
                    color: ColorManager.greyColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
