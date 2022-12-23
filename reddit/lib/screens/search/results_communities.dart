/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the communities results of the main search
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/search_components/subreddit_results_container.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';

import '../../components/helpers/color_manager.dart';

class ResultsCommunities extends StatefulWidget {
  const ResultsCommunities({super.key});

  @override
  State<ResultsCommunities> createState() => _ResultsCommunitiesState();
}

class _ResultsCommunitiesState extends State<ResultsCommunities> {
  final _scrollController = ScrollController();

  /// scroll listener to load more at the bottom of the screen
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      SearchCubit.get(context).getSubbreddits(loadMore: true, after: true);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    SearchCubit.get(context).getSubbreddits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = SearchCubit.get(context); 
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              state is! LoadedResultsState || state is! LoadedMoreResultsState,
          fallback: (context) => const Center(
              child: CircularProgressIndicator(
            color: ColorManager.blue,
          )),
          builder: (context) {
            return cubit.subbreddits.isEmpty
                ? Center(
                    child: Text(
                      'Wow, such empty',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kIsWeb
                            ? MediaQuery.of(context).size.width * 0.2
                            : 0),
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: cubit.subbreddits.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => IntrinsicHeight(
                              child: SubredditResultsContainer(
                                model: cubit.subbreddits[index],
                              ),
                            )),
                  );
          },
        );
      },
    );
  }
}
