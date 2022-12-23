/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The screen that shows the main search results with the tab bar
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/components/search_field.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';
import '../../components/home_components/functions.dart';
import '../../components/snack_bar.dart';
import '../../cubit/app_cubit/app_cubit.dart';

///
/// @param [searchWord] the seaech word entered by the user
/// @param [subredditName] the name of the subreddit in case of searching inside one
/// @param [isSubreddit] bool to check if the search is called inside a subreddit or not to preview the results accordingly
///

class SearchResults extends StatefulWidget {
  final String searchWord;
  const SearchResults(
      {super.key,
      required this.searchWord,
      this.subredditName,
      this.isSubreddit = false});
  static const routeName = '/search_results_route';
  final String? subredditName;
  final bool isSubreddit;
  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///opens/closes the end drawer
  void endDrawer() {
    changeEndDrawer(_scaffoldKey);
  }

  ///opens/closes the drawer
  void drawer() {
    changeLeftDrawer(_scaffoldKey);
  }

  /// initial state of the stateful widget
  /// sets the search word of the screen
  @override
  void initState() {
    _textEditingController.text = widget.searchWord;
    _tabController =
        TabController(length: widget.isSubreddit ? 2 : 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) {
        return SearchCubit()..setSearchQuery(widget.searchWord);
      },
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (widget.isSubreddit) {
            SearchCubit.get(context).setSearchSubreddit(widget.subredditName);
          }
          return BlocListener<AppCubit, AppState>(
            listener: (context, state) {
              if (kIsWeb) {
                if (state is ChangeRightDrawerState) {
                  endDrawer();
                }
                if (state is ChangeLeftDrawerState) {
                  drawer();
                }

                if (state is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                    message: 'An error occurred, please try again later.',
                    error: false,
                  ));
                }
              }
            },
            child: Scaffold(
              key: _scaffoldKey,
              drawer: kIsWeb ? const LeftDrawer() : null,
              endDrawer: kIsWeb ? const RightDrawer() : null,
              appBar: AppBar(
                actions: kIsWeb ? [Container()] : null,
                automaticallyImplyLeading: kIsWeb ? false : true,
                title: kIsWeb
                    ? homeAppBar(
                        context,
                        0,
                        isSearch: true,
                        isSubreddit: widget.isSubreddit,
                        subredditName: widget.subredditName,
                      )
                    : SearchField(
                        subredditName:
                            widget.isSubreddit ? widget.subredditName : null,
                        isSubreddit: widget.isSubreddit,
                        textEditingController: _textEditingController,
                        isResult: true,
                      ),
                bottom: TabBar(
                  controller: _tabController,
                  labelStyle: const TextStyle(fontSize: 14),
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  tabs: widget.isSubreddit
                      ? SearchCubit.get(context).searchInSubredditResultTabs
                      : SearchCubit.get(context).searchResultTabs,
                  indicatorColor: ColorManager.blue,
                ),
              ),
              body: TabBarView(
                  controller: _tabController,
                  children: widget.isSubreddit
                      ? SearchCubit.get(context).searchInSubredditResultScreens
                      : SearchCubit.get(context).searchResultScreens),
            ),
          );
        },
      ),
    );
  }
}
