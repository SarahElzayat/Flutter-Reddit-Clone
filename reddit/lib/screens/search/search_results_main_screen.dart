/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The screen that shows the main search results with the tab bar
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:reddit/components/search_field.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';

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
    // SearchCubit.get(context).setSearchQuery(widget.searchWord);
    super.initState();
    _textEditingController.text = widget.searchWord;
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // final SearchCubit cubit = SearchCubit.get(context);
    return BlocProvider(
      create: (ctx) => SearchCubit()..setSearchQuery(widget.searchWord),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
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
                tabs: SearchCubit.get(context).searchResultTabs,
                indicatorColor: ColorManager.blue,
              ),
            ),
            body: TabBarView(
                controller: _tabController,
                children: SearchCubit.get(context).searchResultScreens),
          );
        },
      ),
    );
  }
}
