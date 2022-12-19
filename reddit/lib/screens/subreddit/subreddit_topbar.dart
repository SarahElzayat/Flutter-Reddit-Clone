// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';

class SliverPersistentHeaderDelegateImp extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final SubredditCubit subredditCubit;

  SliverPersistentHeaderDelegateImp({
    required this.minExtent,
    required this.maxExtent,
    required this.subredditCubit,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(maxExtent - shrinkOffset);
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: ((maxExtent - shrinkOffset) > minExtent)
          ? maxExtent - shrinkOffset
          : minExtent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          (subredditCubit.subreddit!.banner == null ||
                  subredditCubit.subreddit!.banner == '')
              ? Container(
                  color: ColorManager.blue,
                )
              : Image.network(
                  subredditCubit.subreddit!.banner!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(shrinkOffset.toInt(), 0, 0, 0),
                Color.fromARGB(shrinkOffset.toInt(), 0, 0, 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        (shrinkOffset == maxExtent)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    subredditCubit.subreddit!.title!,
                                    style: TextStyle(
                                        fontSize:
                                            20 * mediaQuery.textScaleFactor),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.search))
                                ],
                              )
                            : const Icon(Icons.done),
                        PopupMenuButton(
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      child: Row(
                                    children: const [
                                      Icon(Icons.volume_mute),
                                      Text('Mute subreddit')
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: const [
                                      Icon(Icons.dynamic_feed_rounded),
                                      Text('Add to Custom Feed')
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: const [
                                      Icon(Icons.sell_outlined),
                                      Text('Change user flair')
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: const [
                                      Icon(Icons.mail_outline),
                                      Text('Contact mods')
                                    ],
                                  ))
                                ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
