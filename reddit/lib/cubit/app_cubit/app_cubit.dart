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
import 'package:http_parser/http_parser.dart';

import 'package:reddit/data/home/drawer_communities_model.dart';
import 'package:reddit/data/saved/saved_comments_model.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/chat_screen.dart';
import 'package:reddit/screens/inbox/Inbox_screen.dart';
import 'package:reddit/screens/inbox/notifications_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/explore_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/screens/saved/saved_comments.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../data/post_model/post_model.dart';
import '../../data/temp_data/tmp_data.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../screens/comments/add_comment_screen.dart';
import '../../screens/saved/saved_posts.dart';
import '../../widgets/posts/post_widget.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  /// static method to instantiate an isntance of the app cubit to be used
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
    const ExploreScreen(),
    // const AddPostScreen(),
    // const AddPost(),
    const ChatScreen(),
    const InboxScreen(),
  ];

  ///@param[bottomNavBarIcons] a list of the icons of the bottom navigation bar screens
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
        logger.wtf(error.toString());
      }
    }).catchError((error) {
      emit(ErrorState());
    });
  }

  /// @param [postId] is the id of the saved post that's been unsaved
  /// the method removes the saved post from th saved list
  void removeSavedPost(String postId) {
    savedPostsList.removeWhere((element) => element.id == postId);
    emit(LoadedSavedState());
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

  /// gets the list of the user's joined
  void getYourCommunities() {
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

  /// @param [subredditName] is the name of the subreddit that needs to be added to favorites
  /// the function checks whether the subreddit is added to the user's favorite subreddits or not
  /// if it is the it's added to the list
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

  /// @param [subredditName] is the name of the subreddit that needs to be removed from the user's favorites
  /// the method removes a certain subreddit from the user's favorites
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

  ///@param [currentHistoryCategory] the category chosen [recent, upvoted, downvoted, hidden]
  String currentHistoryCategory = recentHistory;

  ///@param [beforeId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                   before the currently loaded oens
  /// initially empty to load posts for the first time
  String beforeId = '';

  ///@param [afterId] is the last "after" id sent from the backend, used when needed to get the posts
  ///                   after the currently loaded oens
  /// initially empty to load posts for the first time
  String afterId = '';

  ///@param [path] is the path of the desired history category
  ///@param [loadMore] bool that indicates whether the function is called on loading more items for infinte scrolling or not
  ///@param [before] bool to use when the posts before the current loaded ones are needed
  ///@param [after] bool to use when the posts after the current loaded ones are needed
  /// the function gets the history of the specified path (recent, upvoted, downvoted, hidden) history
  /// emits some corresponding states and fills [history] list
  void getHistory(
      {path,
      bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 10}) {
    if (!loadMore) {
      history.clear();
      beforeId = '';
      afterId = '';
    } else {
      if (kDebugMode) {
        // //logger.wtf('AFFFTEEEEERRRRRR ');
      }
      if (kDebugMode) {
        // //logger.wtf(history[history.length - 1].id);
      }
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
        if (kDebugMode) {
          // //logger.wtf('EMPPPTTYYYYY');
        }

        if (loadMore) {
          emit(NoMoreHistoryToLoadState());
        } else {
          emit(HistoryEmptyState());
        }
      } else {
        afterId = value.data['after'];
        beforeId = value.data['before'];
        for (int i = 0; i < value.data['children'].length; i++) {
          history.add(PostModel.fromJsonwithData(value.data['children'][i]));
          loadMore
              ? emit(LoadedMoreHistoryState())
              : emit(LoadedHistoryState());
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {}
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

  /// @param [historyPostViewsIcons] the icons of the different history post views in mobile
  List<Icon> historyPostViewsIcons = [
    const Icon(Icons.crop_square_outlined),
    const Icon(Icons.view_list),
  ];

  /// @param [historyPostViewIconIndex] the index of the selected [historyPostViewsIcons] icon
  int historyPostViewIconIndex = 0;

  /// @param [histoyPostsView] the current PostView selected
  PostView histoyPostsView = PostView.card;

  /// @param [view] the PostView selected by the user
  /// the method changed the history posts view
  void changeHistoryPostView(PostView view) {
    historyPostViewIconIndex = view.index;
    histoyPostsView = view;
    emit(ChangeHistoryPostViewState());
  }

  /// @param [savedTabBarTabs] list of Tab items for saved screen
  List<Tab> savedTabBarTabs = [
    const Tab(
      text: 'Posts',
    ),
    const Tab(
      text: 'Comments',
    ),
  ];

  /// @param [savedTabBarScreens] list of widgets corresponding to the [savedTabBarTabs] for search screen
  List<Widget> savedTabBarScreens = const [
    SavedPostsScreen(),
    SavedCommentsScreen()
  ];

  /// @param [savedPostsList] the list of the user's saved posts
  List<PostModel> savedPostsList = [];

  ///@param [savedPostsBeforeId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                   before the currently loaded oens
  /// initially empty to load posts for the first time
  String savedPostsBeforeId = '';

  ///@param [savedPostsAfterId] is the last "after" id sent from the backend, used when needed to get the posts
  ///                   after the currently loaded oens
  /// initially empty to load posts for the first time
  String savedPostsAfterId = '';

  /// @param [savedCommentsList] the list of the user's saved comments
  List<CommentModel> savedCommentsList = [];

  /// @param [savedCommentsPostsList] the list of the user's saved posts corresopnding to the user's saved comments
  List<PostModel> savedCommentsPostsList = [];

  ///@param [savedCommentsBeforeId] is the last "before" id sent from the backend, used when needed to get the posts
  ///                   before the currently loaded oens
  /// initially empty to load posts for the first time
  String savedCommentsBeforeId = '';

  ///@param [savedCommentsAfterId] is the last "after" id sent from the backend, used when needed to get the posts
  ///                   after the currently loaded oens
  /// initially empty to load posts for the first time
  String savedCommentsAfterId = '';

  /// the function gets the history of the specified path (recent, upvoted, downvoted, hidden) history
  /// emits some corresponding states and fills [savedPostsList] list
  ///@param [isPosts] bool to indicate if the method is called for posts or not
  ///@param [isComments] bool to indicate if the method is called for comments or not
  ///@param [loadMore] bool that indicates whether the function is called on loading more items for infinte scrolling or not
  ///@param [before] bool to use when the posts before the current loaded ones are needed
  ///@param [after] bool to use when the posts after the current loaded ones are needed
  void getSaved(
      {bool isPosts = false,
      bool isComments = false,
      bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 25}) {
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
          logger.wtf('EMPPPTTYYYYY');
        }

        if (loadMore) {
          emit(NoMoreSavedToLoadState());
        } else {
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

        logger.wtf(value.data.toString());
        for (int i = 0; i < value.data['children'].length; i++) {
          if (value.data['children'][i]['type'] == 'post') {
            //logger.wtf('POOOOSTTTTSSS');
            //logger.wtf(value.data['children'][i]['data']['post'].toString());

            savedPostsList.add(
                PostModel.fromJson(value.data['children'][i]['data']['post']));
            savedPostsList[savedPostsList.length - 1].id =
                value.data['children'][i]['id'];

            // savedCommentsPostsList[savedCommentsPostsList.length - 1].id =
            // value.data['children'][i]['id'];
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
        logger.wtf('TAMMAMM');
        loadMore ? emit(LoadedMoreSavedState()) : emit(LoadedSavedState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        logger.wtf(error.toString());
      }
    }).catchError((onError) {
      emit(ErrorState());
    });
  }

  /// the method clears the user's history
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

  /// the method deletes the user's profile picture
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

  ///@param [image] is the image file uploaded by the user
  ///SUPPORTS PNG ONLY
  ///the method changes the user's profile picture
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

  ///@param [id] is the id of the posts that needs to be deletes
  /// deletes a post from home
  void deletePost(String id) {
    homePosts.removeWhere((element) {
      return (element is PostWidget) && element.post.id == id;
    });
  }

  ///@param [sort] the sort of the home screen's posts [best, hot, new, top, trending]
  ///the function chanegs the home posts sort
  void changeHomeSort(HomeSort sort) {
    CacheHelper.putData(key: 'SortHome', value: sort.index);
    emit(ChangeHomeSortState());
    getHomePosts();
  }
}
