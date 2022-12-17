///
/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen fpr the main home
///
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/back_to_top_button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';
import '../../components/home_app_bar.dart';

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
      AppCubit.get(context).getHomePosts(after: true, loadMore: true, limit: 5);
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
      AppCubit.get(context).getHomePosts(limit: 5);
      AppCubit.get(context).getUsername();
      AppCubit.get(context).getYourCommunities();
      AppCubit.get(context).getYourModerating();
      Logger().i(token);
    });
  }

  /// initial state of the widget
  /// loads necessary data from backend
  @override
  void initState() {
    AppCubit.get(context).getHomePosts(limit: 5);
    _scrollController.addListener(_scrollListener);
    AppCubit.get(context).getUsername();
    AppCubit.get(context).getYourCommunities();
    AppCubit.get(context).getYourModerating();
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
                SizedBox(
                  width: kIsWeb ? width * 0.5 : width,
                  child: RefreshIndicator(
                    color: ColorManager.blue,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount: cubit.homePosts.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: cubit.homePosts[index],
                      ),
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
        );
      },
    );
  }
}
