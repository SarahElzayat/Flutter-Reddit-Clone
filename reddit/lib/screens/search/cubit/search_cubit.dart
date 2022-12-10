import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';

import '../../../data/post_model/post_model.dart';
import '../results_comments.dart';
import '../results_communities.dart';
import '../results_people.dart';
import '../results_posts.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  String searchQuery = '';
  void setSearchQuery(s) {
    searchQuery = s;
  }

  List<Widget> searchResultScreens = [
     const ResultsPosts(),
    const ResultsComments(),
    const ResultsCommunities(),
    const ResultsPeople(),
  ];
  List<Tab> searchResultTabs = [
    const Tab(
      text: 'Posts',
    ),
    const Tab(
      text: 'Comments',
    ),
    const Tab(
      text: 'Communities',
    ),
    const Tab(
      text: 'People',
    ),
  ];

  List<PostModel> posts = [];
  String beforeId = '';
  String afterId = '';
  void getPosts(
      {
      bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 3}) {
    DioHelper.getData(path: search, query: {
      'q': searchQuery,
      'limit': limit,
      'after': after ? afterId : null,
      'before': before ? beforeId : null,
    }).then((value) {
      print(value.data);

      if (value.data.length == 0) {
        loadMore ? emit(NoMoreResultsToLoadState()) : emit(ResultEmptyState());
      } else {
        afterId = value.data['after'];
        beforeId = value.data['before'];

        for (int i = 0; i < value.data.length; i++) {
          posts.add(PostModel.fromJson(value.data[i]));
          loadMore ? emit(LoadedMorePostsState()) : emit(LoadedPostsState());
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
