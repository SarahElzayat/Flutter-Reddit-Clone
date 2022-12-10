/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The screen that shows the main search results with the tab bar
import 'package:flutter/material.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:reddit/components/search_field.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';
import 'package:reddit/screens/search/results_comments.dart';
import 'package:reddit/screens/search/results_communities.dart';
import 'package:reddit/screens/search/results_people.dart';
import 'package:reddit/screens/search/results_posts.dart';

class SearchResults extends StatefulWidget {
  final String searchWord;
  const SearchResults({super.key, required this.searchWord});
  static const routeName = '/search_results_route';

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
    super.initState();
    _textEditingController.text = widget.searchWord;
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final SearchCubit cubit = SearchCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          title: SearchField(
            textEditingController: _textEditingController,
            isResult: true,
          ),
          bottom: TabBar(
            controller: _tabController,
            labelStyle: const TextStyle(fontSize: 14),
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: cubit.searchResultTabs,
            indicatorColor: ColorManager.blue,
          ),
        ),
        body: TabBarView(
            controller: _tabController, children: cubit.searchResultScreens));
  }
}
