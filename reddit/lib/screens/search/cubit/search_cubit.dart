import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/search/search_result_profile_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/widgets/comments/comment.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';

import '../../../data/post_model/post_model.dart';
import '../results_comments.dart';
import '../results_communities.dart';
import '../results_users.dart';
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
    const ResultsUsers(),
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

  dynamic getSearch(
      {required type,
      beforeId,
      afterId,
      bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 10}) {
    DioHelper.getData(path: search, query: {
      'type': type,
      'q': searchQuery,
      'limit': limit,
      'after': after ? afterId : null,
      'before': before ? beforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        if (value.data.length == 0) {
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
        } else {
          afterId = value.data['after'];
          beforeId = value.data['before'];
        }
        // print(value.data);
        print(value.data['children']);
        return value.data['children'];
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  List<PostModel> posts = [];
  String postsBeforeId = '';
  String postsAfterId = '';
  // void getPosts({bool loadMore = false}) {
  //   loadMore ? emit(LoadingMoreResultsState()) : emit(LoadingResultsState());

  //   var data = getSearch(
  //       type: posts,
  //       beforeId: postsBeforeId,
  //       afterId: postsAfterId,
  //       loadMore: loadMore);

  //   if (!loadMore) {
  //     posts.clear();
  //   }
  //   for (int i = 0; i < data.length; i++) {
  //     posts.add(PostModel.fromJson(data[i]));
  //   }
  //   // print(' LEEEEENNNNGGGTHHHH ${posts.length}');
  // }

  List<SearchResultProfileModel> users = [];
  String usersBeforeId = '';
  String usersAfterId = '';

  void getPosts(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 10}) {
    // loadMore ? emit(LoadingMoreResultsState()) : emit(LoadingResultsState());
    if (!loadMore) users.clear();

    DioHelper.getData(path: search, query: {
      'type': searchPosts,
      'q': searchQuery,
      'limit': limit,
      'after': after ? postsAfterId : null,
      'before': before ? postsBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        if (value.data['children'].length == 0) {
          print('hena');
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
          emit(LoadedResultsState());
        } else {
          postsAfterId = value.data['after'];
          postsBeforeId = value.data['before'];
          print(value.data['children'].length);
          logger.e(value.data['children']);
          for (int i = 0; i < value.data['children'].length; i++) {
            posts.add(PostModel.fromJson(value.data['children'][i]['data']));
          }
        }
        // print(value.data);
        loadMore
            ? emit(LoadedMoreResultsState())
            : emit(LoadingMoreResultsState());
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void getUsers(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 10}) {
    // loadMore ? emit(LoadingMoreResultsState()) : emit(LoadingResultsState());
    if (!loadMore) users.clear();

    DioHelper.getData(path: search, query: {
      'type': searchUsers,
      'q': searchQuery,
      'limit': limit,
      'after': after ? usersAfterId : null,
      'before': before ? usersBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        if (value.data['children'].length == 0) {
          print('hena');
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
          emit(LoadedResultsState());
        } else {
          usersAfterId = value.data['after'];
          usersBeforeId = value.data['before'];

          for (int i = 0; i < value.data['children'].length; i++) {
            users.add(
                SearchResultProfileModel.fromJson(value.data['children'][i]));
          }
        }
        // print(value.data);
        loadMore
            ? emit(LoadedMoreResultsState())
            : emit(LoadingMoreResultsState());
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  List<CommentModel> comments = [];
  String commentsBeforeId = '';
  String commentsAfterId = '';

  void getComments(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 10}) {
    DioHelper.getData(path: search, query: {
      'type': searchComments,
      'q': searchQuery,
      'limit': limit,
      'after': after ? commentsBeforeId : null,
      'before': before ? commentsBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        if (value.data.length == 0) {
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
        } else {
          commentsBeforeId = value.data['after'];
          commentsBeforeId = value.data['before'];

          //   if (!loadMore) users.clear();
          for (int i = 0; i < value.data['children'].length; i++) {
            comments.add(CommentModel.fromJson(value.data[i]));
          }
        }
        // print(value.data);
        return value.data['children'];
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void folowUser(id) {}
}
