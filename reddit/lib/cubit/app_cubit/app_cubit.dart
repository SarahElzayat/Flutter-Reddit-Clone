/// @author Sarah El-Zayat
/// @date 9/11/2022
/// App cubit for handling application's state management for home, history, drawers...
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/comment/comment_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

import 'package:reddit/data/home/drawer_communities_model.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/chat_screen.dart';
import 'package:reddit/screens/inbox/Inbox_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/explore_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/screens/saved/saved_comments.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../data/post_model/post_model.dart';
import '../../data/temp_data/tmp_data.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../screens/bottom_navigation_bar_screens/add_post_screen.dart';
import '../../screens/saved/saved_posts.dart';
import '../../widgets/posts/post_widget.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  ///@param[currentIndex] indicates the index of the current bottom navigation bar screen
  int currentIndex = 0;

  ///@param[screensNames] a list of the names of the bottom navigation bar screens
  List screensNames = ['Home', 'Discover', 'Create', 'Chat', 'Inbox'];
  // late BuildContext mainScreenContext;

  ///@param[bottomNavBarScreens] a list of the bottom navigation bar widgets
  List<Widget> bottomNavBarScreens = [
    const HomeScreen(),
    const ExploreScreen(),
    const AddPostScreen(),
    // const AddPost(),
    const ChatScreen(),
    const InboxScreen(),
  ];

  ///@param[screensNames] a list of the icons of the bottom navigation bar screens
  List<BottomNavigationBarItem> bottomNavBarIcons = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.explore_outlined), label: 'Discover'),
    const BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Create'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.message_outlined), label: 'Chat'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.notifications_outlined), label: 'Inbox'),
  ];

  ///@param [homePosts] home posts
  List<Widget> homePosts = [];
  String homePostsAfterId = '';
  String homePostsBeforeId = '';

  /// gets the posts of the home page
  void getHomePosts(
      {bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 25}) {
    if (!loadMore) {
      homePosts.clear();
    }
    int sort = CacheHelper.getData(key: 'SortHome');
    String path = '';
    if (HomeSort.best.index == sort) {
      path = homeBest;
    } else if (HomeSort.hot.index == sort) {
      path = homeHot;
    } else if (HomeSort.top.index == sort) {
      path = homeTop;
    } else if (HomeSort.newPosts.index == sort) {
      path = homeNew;
    } else if (HomeSort.trending.index == sort) {
      path = homeTrending;
    }

    DioHelper.getData(path: path, query: {
      'limit': limit,
      'after': after ? homePostsAfterId : null,
      'before': before ? homePostsBeforeId : null,
    }).then((value) {
      if (value.statusCode == 200) {
        if (value.data['children'].length == 0) {
          // //logger.wtf('Mafeesh tany');

          loadMore
              ? emit(NoMoreResultsToLoadState())
              : emit(ResultEmptyState());
          emit(LoadedResultsState());
        } else {
          // //logger.wtf(value.data);
          homePostsAfterId = value.data['after'];
          homePostsBeforeId = value.data['before'];
          // //logger.wtf(value.data['children'].length);
          // //logger.wtf('before $homePostsBeforeId');
          // //logger.wtf('after $homePostsAfterId');
          for (int i = 0; i < value.data['children'].length; i++) {
            homePosts.add(PostWidget(
                post: PostModel.fromJson(value.data['children'][i]['data'])));
            // //logger.e(i);
          }
        }
        // //logger.wtf(value.data);
        emit(LoadedResultsState());
      } else {
        emit(ErrorState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        // //logger.wtf(error.toString());
      }
    }).catchError((error) {
      emit(ErrorState());
    });
  }

  ///@param [popularPosts] dummy data for home screen
  List<Widget> popularPosts = [
    PostWidget(
        post: textPost, insideProfiles: true, postView: PostView.classic),
    PostWidget(post: oneImagePost, postView: PostView.classic),
    PostWidget(post: oneImagePost, postView: PostView.classic),
    PostWidget(post: oneImagePost),
    PostWidget(post: oneImagePost),
  ];

  ///@param [index] is the index of the bottom navigation bar screen
  ///the function changes the displayed screen accordingly
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  ///@param [homeMenuDropdown] a boolean that indicates whether the home dropdown button is open or not
  bool homeMenuDropdown = false;
  List homeMenuItems = ['Home', 'Popular'];
  int homeMenuIndex = 0;

  /// the function changes the state of the home/popular dropdown menu
  void changeHomeMenuState() {
    homeMenuDropdown = !homeMenuDropdown;
    emit(ChangeHomeMenuDropdownState());
  }

  /// @param[index] is the index of the home/popular menu item
  /// the function changes the index according ti the selected item
  void changeHomeMenuIndex(index) {
    homeMenuIndex = index;

    emit(ChangeHomeMenuIndex());
  }

  /// the function changes the state of the right (end) drawer from open to close and vice versa
  void changeRightDrawer() {
    emit(ChangeRightDrawerState());
  }

  /// the function changes the state of the left drawer from open to close and vice versa
  void changeLeftDrawer() {
    emit(ChangeLeftDrawerState());
  }

  ///@param [moderatingListOpen] a boolean that indicates whether the left drawer's 'moderating' list is open or not
  bool moderatingListOpen = true;

  /// The function changes the moderating list state from open to closed and the opposite to keep its state in different contexts
  void changeModeratingListState() {
    moderatingListOpen = !moderatingListOpen;
    emit(ChangeModeratingListState());
  }

  ///@param [favoritesListOpen] a boolean that indicates whether the left drawer's 'moderating' list is open or not
  bool favoritesListOpen = true;

  /// The function changes the moderating list state from open to closed and the opposite to keep its state in different contexts
  void changeFavoritesListState() {
    favoritesListOpen = !favoritesListOpen;
    emit(ChangeFavoritesListState());
  }

  ///@param [moderatingListItems] the subreddits you moderate
  Map<String, DrawerCommunitiesModel> moderatingListItems =
      <String, DrawerCommunitiesModel>{};

  ///@param [yourCommunitiesistOpen] a boolean that indicates whether the left drawer's 'your communities' list is open or not
  bool yourCommunitiesistOpen = true;

  /// The function changes the communitites list state from openn to closed and the opposite to keep its state in different contexts
  void changeYourCommunitiesState() {
    yourCommunitiesistOpen = !yourCommunitiesistOpen;
    emit(ChangeYourCommunitiesState());
  }

  ///@param [yourCommunitiesList] user's joined communities
  Map<String, DrawerCommunitiesModel> yourCommunitiesList =
      <String, DrawerCommunitiesModel>{};

  ///@param [yourCommunitiesList] user's favorite communities
  Map<String, DrawerCommunitiesModel> favoriteCommunities =
      <String, DrawerCommunitiesModel>{};

  void getYourCommunities() {
    // favoriteCommunities.clear();
    yourCommunitiesList.clear();
    DioHelper.getData(path: joinedSubreddits).then((value) {
      if (value.statusCode == 200) {
        for (int i = 0; i < value.data['children'].length; i++) {
          DrawerCommunitiesModel temp =
              DrawerCommunitiesModel.fromJson(value.data['children'][i]);
          yourCommunitiesList[temp.title!] = temp;
          if (temp.isFavorite!) favoriteCommunities[temp.title!] = temp;
        }
        emit(LoadedCommunitiesState());
      } else {
        emit(ErrorState());
      }
    }).catchError((onError) {
      emit(ErrorState());
    });
  }

  /// gets the list of the subreddits the user moderates
  void getYourModerating() {
    moderatingListItems.clear();
    // favoriteCommunities.clear();
    DioHelper.getData(path: moderatedSubreddits).then((value) {
      if (value.statusCode == 200) {
        for (int i = 0; i < value.data['children'].length; i++) {
          DrawerCommunitiesModel temp =
              DrawerCommunitiesModel.fromJson(value.data['children'][i]);
          yourCommunitiesList[temp.title!] = temp;
          moderatingListItems[temp.title!] = temp;
          if (temp.isFavorite!) favoriteCommunities[temp.title!] = temp;
        }
        emit(LoadedCommunitiesState());
      } else {
        emit(ErrorState());
      }
    }).catchError((onError) {
      emit(ErrorState());
    });
  }

  void addFavoriteSubreddit({required String subredditName}) {
    DioHelper.patchData(
        token: token,
        path: '$subreddit/$subredditName/$makeFavorite',
        data: {}).then((value) {
      if (value.statusCode == 200) {
        if (yourCommunitiesList.containsKey(subredditName)) {
          yourCommunitiesList[subredditName]!.isFavorite = true;
        }
        if (moderatingListItems.containsKey(subredditName)) {
          moderatingListItems[subredditName]!.isFavorite = true;
        }

        yourCommunitiesList.containsKey(subredditName)
            ? favoriteCommunities[subredditName] =
                yourCommunitiesList[subredditName]!
            : favoriteCommunities[subredditName] =
                moderatingListItems[subredditName]!;
        emit(ChangedSubredditFavoriteState());
      } else {
        emit(ErrorState());
      }
    }).onError((error, stackTrace) {
      emit(ErrorState());
    });
  }

  void removeFavoriteSubreddit({required String subredditName}) {
    DioHelper.patchData(
        token: token,
        path: '$subreddit/$subredditName/$removeFavorite',
        data: {}).then((value) {
      if (value.statusCode == 200) {
        if (yourCommunitiesList.containsKey(subredditName)) {
          yourCommunitiesList[subredditName]!.isFavorite = false;
        }
        if (moderatingListItems.containsKey(subredditName)) {
          moderatingListItems[subredditName]!.isFavorite = false;
        }
        favoriteCommunities.remove(subredditName);

        emit(ChangedSubredditFavoriteState());
      } else {
        emit(ErrorState());
      }
    }).onError((error, stackTrace) {
      emit(ErrorState());
    });
  }

  ///@param [profilePicture] the profile picture of the user
  String profilePicture = '';

  /// gets the profile picture of the user
  void getUserProfilePicture() {
    DioHelper.getData(path: '$user/$username/$about').then((value) {
      if (value.statusCode == 200) {
        if (value.data['picture'] != null) {
          profilePicture = value.data['picture'];
        }
        emit(LoadedProfilePictureState());
      } else {
        emit(ErrorState());
      }
    }).catchError((error) {
      emit(ErrorState());
    }).catchError((onError) {
      emit(ErrorState());
    });
  }

  ///@param [username] is the username of the user
  String? username = 'Anonymous';

  ///@param [age] is the user's age
  String? age = '';

  ///@param [karma] is the user's karma
  int? karma = 1;

  /// the function get the user's username, age and karma from the backend
  void getUsername() {
    username = CacheHelper.getData(key: 'username');
    DioHelper.getData(path: '$userDetails/$username').then((value) {
      if (value.statusCode == 200) {
        karma = value.data['karma'];
        DateTime joinDate = DateTime.parse(value.data['joinDate']);
        if (DateTime.now().year - joinDate.year > 0) {
          age = '${DateTime.now().year - joinDate.year} y';
        } else if (DateTime.now().month - joinDate.month > 0) {
          age = '${DateTime.now().month - joinDate.month} m';
        } else {
          age = '${DateTime.now().day - joinDate.day + 1} d';
        }
      } else {
        emit(ErrorState());
      }
    }).catchError((error) {
      if (kDebugMode) {
        print('Error In Get User Details $error');
      }
      emit(ErrorState());
    });
  }

  ///@param [history] the list of the user's history, changes according to its category
  List<PostModel> history = [];
  String currentHistoryCategory = recentHistory;
  String beforeId = '';
  String afterId = '';

  ///@param [path] is the path of the desired history category
  /// the function gets the history of the specified path (recent, upvoted, downvoted, hidden) history
  /// emits some corresponding states and fills [history] list
  void getHistory(
      {path,
      bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 10}) {
    // loadMore ? emit(LoadingMoreHistoryState()) : emit(LoadingHistoryState());
    if (!loadMore) {
      history.clear();
      beforeId = '';
      afterId = '';
      emit(LoadingHistoryState());
    }
    DioHelper.getData(
      path: path != null
          ? '$user/$username$path'
          : '$user/$username$currentHistoryCategory',
      query: {
        'limit': limit,
        'after': after ? afterId : null,
        'before': before ? beforeId : null,
      },
    ).then((value) {
      if (value.data['children'].length == 0) {
        if (!loadMore) {
          emit(HistoryEmptyState());
        }
      } else {
        afterId = value.data['after'];
        beforeId = value.data['before'];
        for (int i = 0; i < value.data['children'].length; i++) {
          // //logger.wtf(i);
          history.add(PostModel.fromJsonwithData(value.data['children'][i]));
          loadMore
              ? emit(LoadedMoreHistoryState())
              : emit(LoadedHistoryState());
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        // //logger.wtf(error.toString());
      }
    }).catchError((onError) {
      emit(ErrorState());
    });
  }

  ///@param [historyCategoriesNames] a list the string names of the history categories to be used in different buttons, lists...etc
  List<String> historyCategoriesNames = [
    'Recent',
    'Upvoted',
    'Downvoted',
    'Hidden'
  ];

  ///@param [historyCategoriesIcons] a list of icons corresponding to [historyCategoriesNames]
  List<Icon> historyCategoriesIcons = [
    const Icon(Icons.timelapse),
    const Icon(Icons.arrow_circle_up_rounded),
    const Icon(Icons.arrow_circle_down_rounded),
    const Icon(Icons.hide_image_outlined),
  ];

  ///@param [historyCategoryIndex] is the index of the chosen history category
  int historyCategoryIndex = 0;

  ///@param [category] is an enum that corresponds to the history category item
  /// the function clears the [history] list and fills it with the designated category and emits a state after doing so
  void changeHistoryCategory(HistoyCategory category) {
    historyCategoryIndex = category.index;
    // currentHistoryCategory = category;
    switch (historyCategoryIndex) {
      case 0:
        currentHistoryCategory = recentHistory;
        getHistory(path: recentHistory);
        break;
      case 1:
        currentHistoryCategory = upvotedHistory;
        getHistory(path: upvotedHistory);
        break;
      case 2:
        currentHistoryCategory = downvotedHistory;
        getHistory(path: downvotedHistory);
        break;
      case 3:
        currentHistoryCategory = hiddenHistory;
        getHistory(path: hiddenHistory);
        break;
    }

    emit(ChangeHistoryCategoryState());
  }

  List<Icon> historyPostViewsIcons = [
    const Icon(Icons.crop_square_outlined),
    const Icon(Icons.view_list),
  ];

  int historyPostViewIconIndex = 0;
  PostView histoyPostsView = PostView.card;
  void changeHistoryPostView(PostView view) {
    historyPostViewIconIndex = view.index;
    histoyPostsView = view;
    // //logger.wtf(histoyPostsView.toString());
    emit(ChangeHistoryPostViewState());
  }

  List<Tab> savedTabBarTabs = [
    const Tab(
      text: 'Posts',
    ),
    const Tab(
      text: 'Comments',
    ),
  ];

  List<Widget> savedTabBarScreens = const [
    SavedPostsScreen(),
    SavedCommentsScreen()
  ];

  List<PostModel> savedPostsList = [];
  String savedPostsBeforeId = '';
  String savedPostsAfterId = '';

  List<CommentModel> savedCommentsList = [];
  List<PostModel> savedCommentsPostsList = [];
  String savedCommentsBeforeId = '';
  String savedCommentsAfterId = '';

  /// the function gets the history of the specified path (recent, upvoted, downvoted, hidden) history
  /// emits some corresponding states and fills [savedPostsList] list
  void getSaved(
      {bool isPosts = false,
      bool isComments = false,
      bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 5}) {
    // if (loadMore && isPosts) emit(LoadingMoreSavedPostsState());
    // if (loadMore && isComments) emit(LoadingMoreSavedCommentsState());
    if (!loadMore) {
      savedPostsList.clear();
      savedCommentsList.clear();
      savedCommentsPostsList.clear();
      savedPostsBeforeId = '';
      savedPostsAfterId = '';
      savedCommentsBeforeId = '';
      savedCommentsAfterId = '';
    }

    DioHelper.getData(
      path: '$user/$username/saved',
      query: {
        'limit': limit,
        'after': after
            ? isPosts
                ? savedPostsAfterId
                : isComments
                    ? savedCommentsAfterId
                    : ''
            : '',
        'before': before
            ? isPosts
                ? savedCommentsBeforeId
                : isComments
                    ? savedCommentsBeforeId
                    : ''
            : '',
      },
    ).then((value) {
      if (value.data['children'].length == 0) {
        if (kDebugMode) {
          //logger.wtf('EMPPPTTYYYYY');
        }

        if (!loadMore) {
          emit(SavedEmptyState());
        }
      } else {
        if (isPosts) {
          savedPostsAfterId = value.data['after'];
          savedPostsBeforeId = value.data['before'];
        } else if (isComments) {
          savedCommentsAfterId = value.data['after'];
          savedCommentsBeforeId = value.data['before'];
        }

        //logger.wtf(value.data.toString());
        for (int i = 0; i < value.data['children'].length; i++) {
          if (value.data['children'][i]['type'] == 'post') {
            //logger.wtf('POOOOSTTTTSSS');
            //logger.wtf(value.data['children'][i]['data']['post'].toString());

            savedPostsList.add(
                PostModel.fromJson(value.data['children'][i]['data']['post']));
            savedPostsList[savedPostsList.length - 1].id =
                value.data['children'][i]['id'];

            //logger.e('tmmmmamaamammama');
          } else if (value.data['children'][i]['type'] == 'comment') {
            //logger.wtf('COOOMMMMEEENNNTSSSS');
            //logger.wtf(value.data['children'][i]['data'].toString());
            for (int j = 0;
                j < value.data['children'][i]['data']['comments'].length;
                j++) {
              savedCommentsList.add(CommentModel.fromJson(
                  value.data['children'][i]['data']['comments'][j]));
              savedCommentsPostsList.add(PostModel.fromJson(
                  value.data['children'][i]['data']['post']));

              //logger.e('tmmmmamaamammama');
            }
          } else {
            savedPostsList.add(
                PostModel.fromJson(value.data['children'][i]['data']['post']));
            savedPostsList[savedPostsList.length - 1].id =
                value.data['children'][i]['id'];
            for (int j = 0;
                j < value.data['children'][i]['data']['comments'].length;
                j++) {
              savedCommentsList.add(CommentModel.fromJson(
                  value.data['children'][i]['data']['comments'][j]));
              savedCommentsPostsList.add(PostModel.fromJson(
                  value.data['children'][i]['data']['post']));
            }
          }
        }

        loadMore ? emit(LoadedMoreSavedState()) : emit(LoadedSavedState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        //logger.wtf(error.toString());
      }
    }).catchError((onError) {
      emit(ErrorState());
    });
  }

  /// clears the user's history
  void clearHistoy() {
    DioHelper.postData(
      sentToken: token,
      path: clearHistory,
      data: {'username': username},
    ).then((value) {
      if (value.statusCode == 200) history.clear();
      emit(ClearHistoryState());
      emit(HistoryEmptyState());
    }).catchError((onError) {
      emit(ErrorState());
    });
  }

  void deleteProfilePicture() {
    DioHelper.deleteData(path: userProfilePicture).then((value) {
      if (value.statusCode == 204) {
        profilePicture = '';
        emit(DeletedProfilePictureState());
      } else if (value.statusCode == 400) {
        emit(NoProfilePictureState());
      }
    }).onError((error, stackTrace) {
      emit(ErrorState());
    });
  }

  Future<void> changeProfilePicture(XFile image) async {
    MultipartFile file = await MultipartFile.fromFile(image.path,
        filename: image.path.split('/').last,
        contentType: MediaType('image', 'png'));

    DioHelper.postData(
      isFormdata: true,
      path: userProfilePicture,
      data: FormData.fromMap({'avatar': file}),
      sentToken: token,
    ).then((value) {
      if (value.statusCode == 200) {
        getUserProfilePicture();
        emit(ChangedProfilePictureState());
      }
    }).onError(
      (error, stackTrace) {
        emit(ErrorState());
      },
    );
  }

  void deletePost(String id) {
    homePosts.removeWhere((element) {
      return (element is PostWidget) && element.post.id == id;
    });
  }
}
