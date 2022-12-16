/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen fpr the main home
///
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reddit/components/back_to_top_button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/cubit/app_cubit.dart';
import 'package:reddit/screens/comments/add_comment_screen.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

import '../../components/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home_screen_route';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showbtn = false;

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

  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      AppCubit.get(context).getHomePosts(after: true, loadMore: true, limit: 5);
    }

    double showoffset = MediaQuery.of(context).size.height /
        2; //Back to top botton will show on scroll offset 10.0

    if (_scrollController.offset > showoffset) {
      showbtn = true;
      setState(() {
        //update state
      });
    } else {
      showbtn = false;
      setState(() {
        //update state
      });
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    _onLoading();
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    AppCubit.get(context).getHomePosts(limit: 10);
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    AppCubit.get(context).getHomePosts(limit: 10);
    _scrollController.addListener(_scrollListener);
    if (kIsWeb) {
      AppCubit.get(context).getUsername();
      AppCubit.get(context).getYourCommunities();
      AppCubit.get(context).getYourModerating();
      // AppCubit.get(context).getUserProfilePicture();
    }
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
          body: SmartRefresher(
            enablePullDown: true,
            // enablePullUp: true,
            header: const WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: _scrollController,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: kIsWeb ? width * 0.5 : width,
                        // child: ListView.builder(
                        //   // physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   controller: _scrollController,
                        //   scrollDirection: Axis.vertical,
                        //   itemCount: cubit.homePosts.length,
                        //   itemBuilder: (context, index) => Container(
                        //       margin: const EdgeInsets.symmetric(
                        //           horizontal: 0, vertical: 5),
                        //       child: PostWidget(
                        //         post: cubit.homePosts[index],
                        //       )),
                        // ),
                        child: Column(
                          children: cubit.homePosts,
                        ),
                      ),
                    ),
                    if (kIsWeb)
                      SizedBox(
                        height: 500,
                        width: 300,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.red,
                              height: 200,
                              width: 200,
                              child: Text(
                                'Communities near you',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: Colors.blue,
                              height: 200,
                              width: 200,
                              child: Text(
                                'Create post',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
