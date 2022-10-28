import 'package:flutter/material.dart';
import 'package:reddit/Components/color_manager.dart';
import 'package:reddit/posts/image_viewer.dart';

import 'post_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
  });

  final Post post;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (buildContext, boxConstraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
              color: ColorManager.darkGrey,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // A row with the Avatar, title and the subreddit
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorManager.greyColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.subredditId,
                            style: const TextStyle(
                              color: ColorManager.eggshellWhite,
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'u/${post.userId}',
                                style: const TextStyle(
                                  color: ColorManager.greyColor,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                '•',
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                '14h',
                                style: TextStyle(
                                  color: ColorManager.greyColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          // const Spacer(),
                          // Chip(label: const Text('Join')),
                        ],
                      ),
                      const Spacer(),
                      const Chip(
                        label: Text('Join'),
                        backgroundColor: ColorManager.blue,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // The title of the post
                  Text(
                    post.title,
                    style: const TextStyle(
                      color: ColorManager.eggshellWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // The body of the post
                  if (post.images != null && post.images!.isNotEmpty)
                    SizedBox(
                      width: boxConstraints.maxWidth,
                      height: boxConstraints.maxWidth,
                      child: InlineImageViewer(
                        imagesUrls: post.images!,
                      ),
                    ),
                  if (post.images == null)
                    Text(
                      post.body ?? '',
                      style: const TextStyle(
                        color: ColorManager.greyColor,
                        fontSize: 15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
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
                        onTap: () {},
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
                  )
                ],
              )),
        );
      },
    );
  }
}
