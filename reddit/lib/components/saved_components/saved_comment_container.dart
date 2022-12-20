import 'package:flutter/material.dart';

import '../../data/saved/saved_comments_model.dart';
import '../helpers/color_manager.dart';

class SavedCommentContainer extends StatelessWidget {
  const SavedCommentContainer({super.key, required this.model});
  final SavedCommentModel model;
  // now.day -  commentTime.day
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toUtc();
    DateTime commentTime = DateTime.parse(model.publishTime.toString());
    String time; //;= TimeAgo;
    String commentBody = '';
    if (now.year - commentTime.year != 0) {
      time = '${now.year - commentTime.year} y';
    } else if (now.month - commentTime.month != 0) {
      time = '${now.month - commentTime.month} m';
    } else if (now.hour - commentTime.hour != 0) {
      // print(now);
      // print(commentTime.hour);
      time = '${now.hour - commentTime.hour} h ';
    } else if (now.minute - commentTime.minute != 0) {
      time = '${now.minute - commentTime.minute} m';
    } else {
      time = 'Now';
    }

    for (var element in model.commentBody!.ops!) {
      // logger.wtf(model.commentBody!.toString());
      commentBody += element.insert.toString();
    }
    return Container(
      decoration: const BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(width: 1, color: ColorManager.darkGrey))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.postTitle.toString(),
            style: const TextStyle(
              color: ColorManager.eggshellWhite,
              fontSize: 18,
              // fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                '${model.commentedBy.toString()} . ',
                style: const TextStyle(
                    color: ColorManager.lightGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '$time . ${model.points}',
                style: const TextStyle(
                    color: ColorManager.lightGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              model.points! > 0
                  ? const Icon(
                      Icons.arrow_upward,
                      size: 15,
                      color: ColorManager.lightGrey,
                    )
                  : const Icon(
                      Icons.arrow_downward,
                      size: 14,
                      color: ColorManager.lightGrey,
                    ),
            ],
          ),
          Text(commentBody.toString(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ColorManager.eggshellWhite,
                fontSize: 18,
                // fontWeight: FontWeight.w600,
              ))
        ],
      ),
    );
  }
}
