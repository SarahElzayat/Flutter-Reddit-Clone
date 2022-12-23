///
/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen fpr the main home
///
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/back_to_top_button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_state.dart';
import 'package:reddit/screens/add_post/add_post.dart';
import '../../components/home_app_bar.dart';
import '../create_community_screen/create_community_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home_screen_route';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// @param [_scrollController] the scroll controller of the ListView to load more at the bottom of the screen
  final ScrollController _scrollController = ScrollController();

  /// @param[_scaffoldKey] the key of the scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// @param [showButton] a bool that indicates whether to show the back to top button or not
  bool showButton = false;

  ///The method changes the end drawer state from open to closed and vice versa
  void _changeEndDrawer() {
    _scaffoldKey.currentState!.isEndDrawerOpen
        ? _scaffoldKey.currentState?.closeEndDrawer()
        : _scaffoldKey.currentState?.openEndDrawer();
  }

  ///The method changes the drawer state from open to closed and vice versa
  void _changeLeftDrawer() {
    _scaffoldKey.currentState!.isDrawerOpen
        ? _scaffoldKey.currentState?.closeDrawer()
        : _scaffoldKey.currentState?.openDrawer();
  }

  /// the scroll listener associated with the listView's [_scrollController]
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      AppCubit.get(context).getHomePosts(
        after: true,
        loadMore: true,
      );
    }

    double showoffset = MediaQuery.of(context).size.height /
        2; //Back to top botton will show on scroll offset 10.0

    if (_scrollController.offset > showoffset) {
      showButton = true;
      setState(() {
        //update state
      });
    } else {
      showButton = false;
      setState(() {
        //update state
      });
    }
  }

  /// the method that's callled on pull down to refresh
  Future<void> _onRefresh() async {
    setState(() {
      AppCubit.get(context).getHomePosts();
      AppCubit.get(context).getUsername();

      AppCubit.get(context).getUserProfilePicture();
    });
  }

  /// initial state of the widget
  /// loads necessary data from backend
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    AppCubit.get(context).getHomePosts();
    AppCubit.get(context).getUsername();

    AppCubit.get(context).getUserProfilePicture();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ChangeRightDrawerState) {
          _changeEndDrawer();
        }
        if (state is ChangeLeftDrawerState) {
          _changeLeftDrawer();
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: kIsWeb ? homeAppBar(context, 0) : null,
          floatingActionButton: kIsWeb
              ? BackToTopButton(scrollController: _scrollController)
              : null,
          drawer: kIsWeb ? const LeftDrawer() : null,
          endDrawer: kIsWeb ? const RightDrawer() : null,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<PostNotifierCubit, PostNotifierState>(
                  listener: (context, state) {
                    if (state is PostDeleted) {
                      AppCubit.get(context).deletePost(state.id);
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: kIsWeb ? max(width * 0.5, 500) : width,
                      child: RefreshIndicator(
                        color: ColorManager.blue,
                        onRefresh: _onRefresh,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: cubit.homePosts.length,
                          itemBuilder: (context, index) {
                            return index == 0 && kIsWeb
                                ? Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            homeButton(
                                                Icons.rocket,
                                                'Best',
                                                () => cubit.changeHomeSort(
                                                    HomeSort.best)),
                                            homeButton(
                                                Icons.trending_up,
                                                'Hot',
                                                () => cubit.changeHomeSort(
                                                    HomeSort.hot)),
                                            homeButton(
                                                Icons.new_releases,
                                                'New',
                                                () => cubit.changeHomeSort(
                                                    HomeSort.newPosts)),
                                            homeButton(
                                                Icons.bar_chart,
                                                'Trending',
                                                () => cubit.changeHomeSort(
                                                    HomeSort.trending)),
                                            homeButton(
                                                Icons.upload,
                                                'Top',
                                                () => cubit.changeHomeSort(
                                                    HomeSort.top)),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 5),
                                          child: cubit.homePosts[index],
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 5),
                                    child: cubit.homePosts[index],
                                  );
                          },
                        ),
                      ),
                    );
                  },
                ),
                if (kIsWeb)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.darkGrey,
                          border: Border.all(color: ColorManager.grey),
                          borderRadius: BorderRadius.circular(10)),
                      width: width * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MaterialButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 48),
                              color: ColorManager.blue,
                              shape: const StadiumBorder(),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AddPost(),
                                  )),
                              child: const Text(
                                'Create Post',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorManager.blue),
                                  borderRadius: BorderRadius.circular(20)),
                              child: MaterialButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                shape: const StadiumBorder(),
                                // color: ColorManager.blue,
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateCommunityScreen(),
                                    )),
                                child: const Text('Create Community'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget homeButton(icon, text, onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
  );
}
