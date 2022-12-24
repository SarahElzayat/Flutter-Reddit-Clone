///  @author Sarah El-Zayat
///  @date 9/11/2022
///  Search cubit for handling application's state management of searching
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../data/comment/comment_model.dart';
import '../../../data/search/search_result_profile_model.dart';
import '../../../data/search/search_result_subbredit_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../data/post_model/post_model.dart';
import '../results_comments.dart';
import '../results_communities.dart';
import '../results_users.dart';
import '../results_posts.dart';

part 'search_state.dart';

var logger = Logger();

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  ///  static method to instantiate an isntance of the app cubit to be used
  static SearchCubit get(context) => BlocProvider.of(context);

  ///  @param[searchQuery] the search word
  String searchQuery = '';

  ///  @param[s] the search word entered
  /// the method sets the search word for the cubit
  void setSearchQuery(s) {
    searchQuery = s;
  }

  ///  @param[subredditName] in case of searching inside a subreddit, the paramater holds the subreddit name
  String subredditName = '';

  ///  @param[s] subreddit's name, it's the subreddit's name
  /// the method sets the subreddit's name for the cubit in case of searching inside a subreddit
  void setSearchSubreddit(s) {
    subredditName = s;
    logger.wtf(s);
  }

  ///  @param[searchResultScreens] a list of the search results screens
  List<Widget> searchResultScreens = [
    const ResultsPosts(),
    const ResultsComments(),
    const ResultsCommunities(),
    const ResultsUsers(),
  ];

  ///  @param[searchResultTabs] a list of the search result tabs to be added to the appbar
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

  ///  @param[searchInSubredditResultScreens] a list of the search results screens in case of searching inside a subreddit
  List<Widget> searchInSubredditResultScreens = [
    const ResultsPosts(isSubreddit: true),
    const ResultsComments(),
  ];

  ///  @param[searchInSubredditResultTabs] a list of the search result tabs to be added to the appbar in case of searching inside a subreddit
  List<Tab> searchInSubredditResultTabs = [
    const Tab(
      text: 'Posts',
    ),
    const Tab(
      text: 'Comments',
    ),
  ];

  ///  @param [posts] list of search result posts
  List<PostModel> posts = [];

  ///  @param [postsBeforeId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                    before the currently loaded oens
  ///  initially empty to load posts for the first time
  String postsBeforeId = '';

  ///  @param [postsAfterId] is the last "after" id sent from the backend, used when needed to get the posts
  ///                    after the currently loaded oens
  ///  initially empty to load posts for the first time
  String postsAfterId = '';

  ///  @param [loadMore] bool that indicates whether the function is called on loading more items for infinte scrolling or not
  ///  @param [before] bool to use when the posts before the current loaded ones are needed
  ///  @param [after] bool to use when the posts after the current loaded ones are needed
  ///  the function gets the search result posts and fills the [posts] list
  void getPosts(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 25}) {
    if (!loadMore) {
      posts.clear();
    }

    DioHelper.getData(
        path: subredditName.isNotEmpty ? '/$subredditName$search' : search,
        query: {
          'type': searchPosts,
          'q': searchQuery,
          'limit': limit,
          'after': after ? postsAfterId : null,
          'before': before ? postsBeforeId : null,
        }).then((value) {
      if (value.statusCode == 200) {
        if (value.data['children'].length == 0) {
          if (!loadMore) {
            emit(ResultEmptyState());
          }
        } else {
          logger.wtf(value.data);
          postsAfterId = value.data['after'];
          postsBeforeId = value.data['before'];
          for (int i = 0; i < value.data['children'].length; i++) {
            posts.add(PostModel.fromJson(value.data['children'][i]['data']));
          }
          loadMore
              ? emit(LoadedMoreResultsState())
              : emit(LoadedResultsState());
        }
        // print(value.data);
      } else {
        emit(SearchErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  ///  @param [users] list of search result users
  List<SearchResultProfileModel> users = [];

  ///  @param [usersBeforeId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                    before the currently loaded oens
  ///  initially empty to load users for the first time
  String usersBeforeId = '';

  ///  @param [usersAfterId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                    before the currently loaded oens
  ///  initially empty to load users for the first time
  String usersAfterId = '';

  ///  @param [loadMore] bool that indicates whether the function is called on loading more items for infinte scrolling or not
  ///  @param [before] bool to use when the users before the current loaded ones are needed
  ///  @param [after] bool to use when the users after the current loaded ones are needed
  ///  the function gets the search result users and fills the [users] list
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
          if (!loadMore) {
            emit(ResultEmptyState());
          }

          emit(LoadedResultsState());
        } else {
          usersAfterId = value.data['after'];
          usersBeforeId = value.data['before'];

          for (int i = 0; i < value.data['children'].length; i++) {
            // print(value.data['children'][i].toString());
            users.add(
                SearchResultProfileModel.fromJson(value.data['children'][i]));
          }
          // print(value.data);
          loadMore
              ? emit(LoadedMoreResultsState())
              : emit(LoadingMoreResultsState());
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

  ///  @param [comments] list of search result comments
  List<CommentModel> comments = [];

  ///  @param [commentsPosts] list of search result posts corresponding to comments
  List<PostModel> commentsPosts = [];

  ///  @param [commentsBeforeId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                    before the currently loaded oens
  ///  initially empty to load comments for the first time
  String commentsBeforeId = '';

  ///  @param [commentsAfterId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                    before the currently loaded oens
  ///  initially empty to load comments for the first time
  String commentsAfterId = '';

  ///  @param [loadMore] bool that indicates whether the function is called on loading more items for infinte scrolling or not
  ///  @param [before] bool to use when the comments before the current loaded ones are needed
  ///  @param [after] bool to use when the comments after the current loaded ones are needed
  ///  the function gets the search result comments and fills the [comments] and [commentsPosts] list
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

    DioHelper.getData(
        path: subredditName.isNotEmpty ? '/$subredditName$search' : search,
        query: {
          'type': searchComments,
          'q': searchQuery,
          'limit': limit,
          'after': after ? commentsAfterId : null,
          'before': before ? commentsBeforeId : null,
        }).then((value) {
      if (value.statusCode == 200) {
        if (value.data.length == 0) {
          if (!loadMore) {
            emit(ResultEmptyState());
          }
        } else {
          commentsAfterId = value.data['after'];
          commentsBeforeId = value.data['before'];
          for (int i = 0; i < value.data['children'].length; i++) {
            comments.add(CommentModel.fromJson(
                value.data['children'][i]['data']['comment']));
            Logger().wtf(comments[i].toJson());
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
      logger.e(error.toString());
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
          if (!loadMore) {
            emit(ResultEmptyState());
          }
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

  ///  @param [username] the username of the user to be followed/unfollowed
  ///  @param [follow] the action that needs to be taken (follow/unfollow) user
  /// the method follows/unfollow a user
  void folowUser({required username, required follow}) {
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

  ///  @param [id] the id of the subreddit the user needs to join
  /// the function allows the user to join a certain subreddit
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

  ///  @param [name] the name of the subreddit the user needs to leave
  /// the function allows the user to leave a certain subreddit
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
