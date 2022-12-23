// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';

import '../../components/app_bar_components.dart';
import '../../components/search_field.dart';
import '../../networks/constant_end_points.dart';
import '../search/search_results_main_screen.dart';

/// AppBar in Subreddit Screen For Mobile
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
    final mediaQuery = MediaQuery.of(context);

    return Container(
      // height: maxExtent,
      color: Colors.black,

      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            (subredditCubit.subreddit!.banner == null ||
                    subredditCubit.subreddit!.banner == '')
                ? Image.asset(
                    'assets/images/subredditBackground.jpg',
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    '$baseUrl/${subredditCubit.subreddit!.banner!}',
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
            (kIsWeb)
                ? SizedBox()
                : Align(
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
                                                      mediaQuery
                                                          .textScaleFactor),
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
                                            onSubmitted: (value) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchResults(
                                                    isSubreddit: true,
                                                    subredditName:
                                                        'r/${subredditCubit.subredditName}',
                                                    searchWord: value,
                                                  ),
                                                ),
                                              );
                                            },
                                            subredditName:
                                                'r/${subredditCubit.subredditName}',
                                            textEditingController:
                                                TextEditingController(),
                                          ),
                                        ),
                                      ),
                                // SubredditOpion(),
                                if (subredditCubit.subreddit!.isModerator !=
                                        null &&
                                    subredditCubit.subreddit!.isModerator !=
                                        false)
                                  PopupMenuButton(
                                      itemBuilder: ((context) => [
                                            PopupMenuItem(
                                                child: Row(
                                              children: [
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Icon(Icons
                                                        .notifications_none)),
                                                Expanded(
                                                  child: Text(
                                                    'Manage Mod Notification',
                                                    style: TextStyle(
                                                        fontSize: 15 *
                                                            mediaQuery
                                                                .textScaleFactor),
                                                  ),
                                                )
                                              ],
                                            )),
                                          ])),
                                Container(
                                  margin:
                                      (subredditCubit.subreddit!.isModerator ==
                                                  null ||
                                              subredditCubit
                                                      .subreddit!.isModerator ==
                                                  false)
                                          ? const EdgeInsets.only(left: 10)
                                          : null,
                                  child: InkWell(
                                      onTap: () {
                                        scaffoldKey
                                                .currentState!.isEndDrawerOpen
                                            ? scaffoldKey.currentState
                                                ?.closeEndDrawer()
                                            : scaffoldKey.currentState
                                                ?.openEndDrawer();
                                      },
                                      child: avatar(context: context)),
                                )
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
