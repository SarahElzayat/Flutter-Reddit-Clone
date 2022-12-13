// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';

import '../../components/app_bar_components.dart';
import '../../components/search_field.dart';
import '../../cubit/app_cubit.dart';

class SubredditAppBar extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;

  final SubredditCubit subredditCubit;

  final GlobalKey<ScaffoldState> scaffoldKey;

  SubredditAppBar({
    required this.minExtent,
    required this.maxExtent,
    required this.subredditCubit,
    required this.scaffoldKey,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(maxExtent - shrinkOffset);
    final mediaQuery = MediaQuery.of(context);
    final AppCubit cubit = AppCubit.get(context)..getUsername();

    return Container(
      // height: maxExtent,
      color: Colors.black,

      child: SafeArea(
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
              alignment: Alignment.bottomLeft,
              child: Container(
                // padding: EdgeInsets.symmetric(
                //     vertical: mediaQuery.size.height * 0.00018),
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          (shrinkOffset == maxExtent)
                              ? Expanded(
                                  // width: mediaQuery.size.width * 0.6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        subredditCubit.subreddit!.title!,
                                        style: TextStyle(
                                            fontSize: 20 *
                                                mediaQuery.textScaleFactor),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            navigateToSearch(context);
                                          },
                                          icon: const Icon(Icons.search))
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: SearchField(
                                      isSubreddit: true,
                                      isResult: true,
                                      labelText:
                                          'r/${subredditCubit.subreddit!.nickname!}',
                                      textEditingController:
                                          TextEditingController(),
                                    ),
                                  ),
                                ),
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
                          InkWell(
                              onTap: () {
                                scaffoldKey.currentState!.isEndDrawerOpen
                                    ? scaffoldKey.currentState?.closeEndDrawer()
                                    : scaffoldKey.currentState?.openEndDrawer();
                              },
                              child: avatar())
                        ],
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

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
