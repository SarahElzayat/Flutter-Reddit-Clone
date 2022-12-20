// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/add_post/cubit/add_post_cubit.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';

import '../../components/Button.dart';
import '../../components/home_components/right_drawer.dart';
import '../../cubit/app_cubit/app_cubit.dart';
import '../../networks/constant_end_points.dart';
import '../../widgets/subreddit/subreddit_about.dart';
import '../../widgets/subreddit/subreddit_posts.dart';
import '../add_post/add_post.dart';
import '../moderation/mod_tools.dart';
import 'subreddit_topbar.dart';

class Subreddit extends StatefulWidget {
  const Subreddit({Key? key}) : super(key: key);

  @override
  State<Subreddit> createState() => _SubredditState();
  static const routeName = '/subreddit_screen_route';
}

class _SubredditState extends State<Subreddit>
    with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 2, vsync: this);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double sliverHeight = 0;

  bool descriptionFlag = true;
  bool titleFlag = true;

  final GlobalKey _subInof = GlobalKey();
  final GlobalKey _con1 = GlobalKey();
  final GlobalKey _con2 = GlobalKey();
  final GlobalKey _con3 = GlobalKey();

  final List<String> _text = [
    'Hot',
    'New',
    'Top',
    'Trending',
  ];

  @override
  void initState() {
    super.initState();
    final subredditCubit = SubredditCubit.get(context);
    subredditCubit.pagingController = PagingController(firstPageKey: null);
    subredditCubit.pagingController.addPageRequestListener((pageKey) {
      subredditCubit.fetchPosts(
          after: pageKey,
          sortBy: _text[subredditCubit.selectedIndex].toLowerCase());
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => getHeight());
  }

  getHeight() {
    // RenderBox? rendersub =
    //     _subInof.currentContext!.findRenderObject() as RenderBox;
    RenderBox? renderCon1 =
        _con1.currentContext!.findRenderObject() as RenderBox;
    RenderBox? renderCon2 =
        _con2.currentContext!.findRenderObject() as RenderBox;
    RenderBox? renderCon3 =
        _con3.currentContext!.findRenderObject() as RenderBox;

    sliverHeight = renderCon1.size.height +
        renderCon2.size.height +
        renderCon3.size.height +
        30;
    // print('sliverHeight = $sliverHeight');
    // print('sliverHeight = ${rendersub.size.height}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final subredditCubit = BlocProvider.of<SubredditCubit>(context);
    final AppCubit cubit = AppCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        subredditCubit.pagingController.dispose();
        return true;
      },
      child: BlocProvider(
        create: (context) =>
            SearchCubit()..setSearchSubreddit(subredditCubit.subredditName),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Scaffold(
              key: _scaffoldKey,
              endDrawer: const RightDrawer(),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                items: cubit.bottomNavBarIcons,
                onTap: (value) {
                  setState(() {
                    if (value == 2) {
                      AddPostCubit.get(context)
                          .addSubredditName(subredditCubit.subredditName);
                      Navigator.of(context).push(MaterialPageRoute(
                        // TODO:pass the name of subreddit to add post
                        builder: (context) => const AddPost(),
                      ));
                    } else {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      cubit.changeIndex(value);
                    }
                  });
                },
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context2, innerBoxIsScrolled) {
                  return [
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: SubredditAppBar(
                            scaffoldKey: _scaffoldKey,
                            maxExtent: 90,
                            minExtent: 85,
                            subredditCubit: subredditCubit)),
                    SliverAppBar(
                      pinned: true,
                      automaticallyImplyLeading: false,
                      primary: false,
                      actions: <Widget>[Container()],

                      bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0),
                          child: Container(
                            key: _con1,
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.size.width * 0.15),
                            color: ColorManager.black,
                            child: TabBar(
                                indicatorColor: ColorManager.blue,
                                controller: controller,
                                tabs: [
                                  Text(
                                    'Posts',
                                    style: TextStyle(
                                        fontSize:
                                            25 * mediaQuery.textScaleFactor),
                                  ),
                                  Text(
                                    'About',
                                    style: TextStyle(
                                        fontSize:
                                            25 * mediaQuery.textScaleFactor),
                                  )
                                ]),
                          )),
                      // pinned: true,
                      // floating: true,
                      // snap: true,
                      backgroundColor: Colors.black,
                      // actionsIconTheme: IconThemeData(opacity: 0.0),
                      expandedHeight: sliverHeight,
                      flexibleSpace: FlexibleSpaceBar(
                          // key: _subInof,
                          background:
                              subredditInfo(mediaQuery, subredditCubit)),
                    )
                  ];
                },
                body: TabBarView(controller: controller, children: [
                  SubredditPostsWidget(),
                  const SubredditAboutWidget(),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget subredditInfo(
      MediaQueryData mediaQuery, SubredditCubit subredditCubit) {
    return Column(
      key: _subInof,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          key: _con2,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          (subredditCubit.subreddit!.picture == null ||
                                  subredditCubit.subreddit!.picture == '')
                              ? ColorManager.blue
                              : null,
                      radius: 25,
                      backgroundImage: (subredditCubit.subreddit!.picture ==
                                  null ||
                              subredditCubit.subreddit!.picture == '')
                          ? null
                          : NetworkImage(
                              '$baseUrl/${subredditCubit.subreddit!.picture!}'),
                      child: (subredditCubit.subreddit!.picture == null ||
                              subredditCubit.subreddit!.picture == '')
                          ? const Text(
                              'r/',
                              style: TextStyle(
                                  fontSize: 35,
                                  color: ColorManager.eggshellWhite),
                            )
                          : null,
                    ),
                    if (subredditCubit.subreddit!.isModerator!)
                      const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 25,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.shield,
                            color: ColorManager.green,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SizedBox(
                width: mediaQuery.size.width * 0.75,
                // color: ColorManager.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            setState(() {
                              titleFlag = !titleFlag;
                            });

                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              getHeight();
                            });
                          }),
                          child: Text(
                            (subredditCubit.subreddit!.title == null)
                                ? ''
                                : 'r/${subredditCubit.subreddit!.title}',
                            // key: _con3,
                            maxLines: titleFlag ? 1 : 2,
                            overflow: titleFlag ? TextOverflow.ellipsis : null,
                            style: TextStyle(
                                fontSize: 22 * mediaQuery.textScaleFactor),
                          ),
                        ),
                        BlocBuilder<SubredditCubit, SubredditState>(
                            buildWhen: (previous, current) =>
                                (current is leaveSubredditState ||
                                    current is joinSubredditState),
                            builder: (context, state) => (subredditCubit
                                    .subreddit!.isModerator!)
                                ? MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const ModTools())));
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.build),
                                        Text('Mod Tool')
                                      ],
                                    ),
                                  )
                                : MaterialButton(
                                    onPressed: () {
                                      if (!subredditCubit
                                          .subreddit!.isMember!) {
                                        subredditCubit.joinCommunity();
                                      } else {
                                        popupLeaveSubreddit(
                                            Navigator.of(context),
                                            subredditCubit,
                                            mediaQuery);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 12),
                                      decoration: BoxDecoration(
                                          border: (!subredditCubit
                                                  .subreddit!.isMember!)
                                              ? null
                                              : Border.all(
                                                  color: ColorManager.blue),
                                          color: (!subredditCubit
                                                  .subreddit!.isMember!)
                                              ? ColorManager.blue
                                              : ColorManager.black,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        (!subredditCubit.subreddit!.isMember!)
                                            ? 'Join'
                                            : 'Joined',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: (!subredditCubit
                                                    .subreddit!.isMember!)
                                                ? ColorManager.eggshellWhite
                                                : ColorManager.blue),
                                      ),
                                    ),
                                  )),
                      ],
                    ),
                    GestureDetector(
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'r/${subredditCubit.subreddit!.nickname}',
                            style: TextStyle(
                                fontSize: 17 * mediaQuery.textScaleFactor),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: (() {
                    setState(() {
                      descriptionFlag = !descriptionFlag;
                    });

                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      getHeight();
                    });
                  }),
                  child: Text(
                    subredditCubit.subreddit!.description ?? '',
                    key: _con3,
                    maxLines: descriptionFlag ? 2 : null,
                    overflow: descriptionFlag ? TextOverflow.ellipsis : null,
                  ),
                ))),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  void popupLeaveSubreddit(NavigatorState navigator,
      SubredditCubit subredditCubit, MediaQueryData mediaQuery) {
    Future.delayed(
      const Duration(seconds: 0),
      () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: ColorManager.grey,
          insetPadding: EdgeInsets.zero,
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to leave the r/${subredditCubit.subredditName} community',
                  style: TextStyle(fontSize: 17 * mediaQuery.textScaleFactor),
                ),
              ],
            ),
          ),
          actions: [
            Button(
                onPressed: () {
                  navigator.pop();
                  return;
                },
                text: ('Cancel'),
                textColor: ColorManager.white,
                backgroundColor: Colors.transparent,
                buttonWidth: mediaQuery.size.width * 0.3,
                buttonHeight: 40,
                textFontSize: 15,
                splashColor: Color.fromARGB(40, 0, 0, 0)),
            Button(
                onPressed: () {
                  subredditCubit.leaveCommunity();
                  navigator.pop();
                },
                text: ('Leave'),
                textColor: ColorManager.white,
                backgroundColor: Colors.red,
                buttonWidth: mediaQuery.size.width * 0.3,
                buttonHeight: 40,
                textFontSize: 15,
                splashColor: Color.fromARGB(40, 0, 0, 0))
          ],
        ),
      ),
    );
  }
}
