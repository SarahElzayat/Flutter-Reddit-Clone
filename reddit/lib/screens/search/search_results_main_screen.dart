/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The screen that shows the main search results with the tab bar
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/search_field.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';

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

  /// initial state of the stateful widget
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
        // ..setSearchSubreddit(widget.subredditName);
      },
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (widget.isSubreddit) {
            SearchCubit.get(context).setSearchSubreddit(widget.subredditName);
          }
          return Scaffold(
            appBar: AppBar(
              title: SearchField(
                subredditName: widget.isSubreddit ? widget.subredditName : null,
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
          );
        },
      ),
    );
  }
}
