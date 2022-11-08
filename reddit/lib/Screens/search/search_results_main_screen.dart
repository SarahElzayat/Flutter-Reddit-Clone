import 'package:flutter/material.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/Screens/search/results_comments.dart';
import 'package:reddit/Screens/search/results_communities.dart';
import 'package:reddit/Screens/search/results_media.dart';
import 'package:reddit/Screens/search/results_people.dart';
import 'package:reddit/Screens/search/results_posts.dart';
import 'package:reddit/components/search_field.dart';

class SearchResults extends StatefulWidget {
  final String searchWord;
  const SearchResults({super.key, required this.searchWord});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    //TODO add it to cubit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SearchFiled(textEditingController: TextEditingController()),
          bottom: TabBar(
            controller: _tabController,
            labelStyle: const TextStyle(fontSize: 14),
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: const [
              Tab(
                text: 'Posts',
              ),
              Tab(
                text: 'Comments',
              ),
              Tab(
                text: 'Communities',
              ),
              Tab(
                text: 'People',
              ),
              Tab(
                text: 'Media',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            //TODO Add screens depeneding on category
            //TODO Add models to each screen
            ResultsPosts(),
            ResultsComments(),
            ResultsCommunities(),
            ResultsPeople(),
            ResultsMedia(),
          ],
        ));
  }
}
