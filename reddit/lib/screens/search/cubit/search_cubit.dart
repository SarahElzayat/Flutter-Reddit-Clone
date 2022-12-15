import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/search/search_result_profile_model.dart';
import 'package:reddit/data/search/search_result_subbredit_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';

import '../../../data/post_model/post_model.dart';
import '../results_comments.dart';
import '../results_communities.dart';
import '../results_users.dart';
import '../results_posts.dart';

part 'search_state.dart';

var logger = Logger();

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

  List<PostModel> posts = [];
  String postsBeforeId = '';
  String postsAfterId = '';

  void getPosts(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 25}) {
    if (!loadMore) {
      posts.clear();
    }

    DioHelper.getData(path: search, query: {
      'type': searchPosts,
      'q': searchQuery,
      'limit': limit,
      'after': after ? postsAfterId : null,
      'before': before ? postsBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        if (value.data['children'].length == 0) {
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
          emit(LoadedResultsState());
        } else {
          logger.wtf(value.data);
          postsAfterId = value.data['after'];
          postsBeforeId = value.data['before'];
          print(value.data['children'].length);
          for (int i = 0; i < value.data['children'].length; i++) {
            posts.add(PostModel.fromJson(value.data['children'][i]['data']));
            print('tmam');
          }
        }
        // print(value.data);
        loadMore ? emit(LoadedMoreResultsState()) : emit(LoadedResultsState());
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  List<SearchResultProfileModel> users = [];
  String usersBeforeId = '';
  String usersAfterId = '';

  void getUsers(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 25}) {
    loadMore ? emit(LoadingMoreResultsState()) : emit(LoadingResultsState());
    if (!loadMore) users.clear();

    DioHelper.getData(path: search, query: {
      'type': searchUsers,
      'q': searchQuery,
      'limit': limit,
      'after': after ? usersAfterId : null,
      'before': before ? usersBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        logger.wtf(value.data);
        if (value.data['children'].length == 0) {
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
          emit(LoadedResultsState());
        } else {
          usersAfterId = value.data['after'];
          usersBeforeId = value.data['before'];

          for (int i = 0; i < value.data['children'].length; i++) {
            print(value.data['children'][i].toString());
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
  List<PostModel> commentsPosts = [];
  String commentsBeforeId = '';
  String commentsAfterId = '';

  void getComments(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 25}) {
    loadMore ? emit(LoadingMoreResultsState()) : emit(LoadingResultsState());

    if (!loadMore) {
      comments.clear();
      commentsPosts.clear();
    }

    DioHelper.getData(path: search, query: {
      'type': searchComments,
      'q': searchQuery,
      'limit': limit,
      'after': after ? commentsAfterId : null,
      'before': before ? commentsBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        if (value.data.length == 0) {
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
        } else {
          commentsAfterId = value.data['after'];
          commentsBeforeId = value.data['before'];

          for (int i = 0; i < value.data['children'].length; i++) {
            comments.add(CommentModel.fromJson(
                value.data['children'][i]['data']['comment']));
            commentsPosts.add(
                PostModel.fromJson(value.data['children'][i]['data']['post']));
          }
          loadMore
              ? emit(LoadedMoreResultsState())
              : emit(LoadedResultsState());
        }
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  List<SearchResultSubredditModel> subbreddits = [];
  String subbredditsBeforeId = '';
  String subbredditsAfterId = '';

  void getSubbreddits(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 25}) {
    loadMore ? emit(LoadingMoreResultsState()) : emit(LoadingResultsState());

    if (!loadMore) {
      subbreddits.clear();
    }
    DioHelper.getData(path: search, query: {
      'type': searchSubreddits,
      'q': searchQuery,
      'limit': limit,
      'after': after ? subbredditsAfterId : null,
      'before': before ? subbredditsBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        logger.wtf(value.data);
        if (value.data.length == 0) {
          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
        } else {
          subbredditsAfterId = value.data['after'];
          subbredditsBeforeId = value.data['before'];
          for (int i = 0; i < value.data['children'].length; i++) {
            subbreddits.add(
                SearchResultSubredditModel.fromJson(value.data['children'][i]));
          }
          loadMore
              ? emit(LoadedMoreResultsState())
              : emit(LoadedResultsState());
        }
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void folowUser({required username, required follow}) {
    // print('$token token');
    DioHelper.postData(
        path: followUser,
        data: {'username': username, 'follow': follow}).then((value) {
      if (value.statusCode == 200) {
        emit(FollowStateChanged());
      } else {
        emit(SearchErrorState());
      }
    });
  }

  void joinSubreddit({required id}) {
    DioHelper.postData(path: joinCommunity, data: {
      'subredditId': id,
    }).then((value) {
      if (value.statusCode == 200) {
        logger.wtf(value.data);
        emit(JoinStateChanged());
      } else {
        emit(SearchErrorState());
      }
    });
  }

  void leaveSubreddit({required name}) {
    DioHelper.postData(path: leaveCommunity, data: {
      'subredditName': name,
    }).then((value) {
      if (value.statusCode == 200) {
        logger.wtf(value.data);
        emit(JoinStateChanged());
      } else {
        emit(SearchErrorState());
      }
    });
  }
}
