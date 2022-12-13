/// @author Sarah El-Zayat
/// @date 9/11/2022
/// App cubit for handling application's state management for home, history, drawers...
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/data/saved/saved_comments_model.dart';
import 'package:reddit/screens/inbox/Inbox_screen.dart';
import 'package:reddit/screens/inbox/notifications_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/explore_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/screens/saved/saved_comments.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import 'package:reddit/widgets/posts/post_upper_bar.dart';
import '../components/helpers/color_manager.dart';
import '../data/post_model/post_model.dart';
import '../data/temp_data/tmp_data.dart';
import '../networks/constant_end_points.dart';
import '../networks/dio_helper.dart';
import '../screens/bottom_navigation_bar_screens/add_post_screen.dart';
import '../screens/saved/saved_posts.dart';
import '../widgets/posts/post_widget.dart';

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
    const NotificationScreen(),
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

  ///@param [homePosts] dummy data for home screen
  List<Widget> homePosts = [
    PostWidget(post: textPost),
    PostWidget(post: smalltextPost),
    PostWidget(post: linkPost, upperRowType: ShowingOtions.onlyUser),
    PostWidget(post: oneImagePost, postView: PostView.classic),
    PostWidget(post: manyImagePost, postView: PostView.classic),
    PostWidget(post: manyImagePost, postView: PostView.card),
  ];

  ///@param [popularPosts] dummy data for home screen
  List<Widget> popularPosts = [
    PostWidget(post: textPost),
    PostWidget(post: oneImagePost),
    PostWidget(post: oneImagePost),
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

  ///@param [moderatingListItems] dummy data for drawer
  List<Widget> moderatingListItems = [
    const Text(
      'moderating 1 ',
      style: TextStyle(
          color: ColorManager.eggshellWhite, fontWeight: FontWeight.w400),
    ),
    const Text(
      'moderating 2 ',
      style: TextStyle(
          color: ColorManager.eggshellWhite, fontWeight: FontWeight.w400),
    ),
    const Text(
      'moderating 3 ',
      style: TextStyle(
          color: ColorManager.eggshellWhite, fontWeight: FontWeight.w400),
    ),
  ];

  ///@param [yourCommunitiesistOpen] a boolean that indicates whether the left drawer's 'your communities' list is open or not
  bool yourCommunitiesistOpen = true;

  /// The function changes the communitites list state from openn to closed and the opposite to keep its state in different contexts
  void changeYourCommunitiesState() {
    yourCommunitiesistOpen = !yourCommunitiesistOpen;
    emit(ChangeYourCommunitiesState());
  }

  ///@param [yourCommunitiesList] dummy data
  List<Widget> yourCommunitiesList = [
    //
    const Text(
      'community 1 ',
      style: TextStyle(
          color: ColorManager.eggshellWhite, fontWeight: FontWeight.w400),
    ),
    const Text(
      'community 2 ',
      style: TextStyle(
          color: ColorManager.eggshellWhite, fontWeight: FontWeight.w400),
    ),
    const Text(
      'community 3 ',
      style: TextStyle(
          color: ColorManager.eggshellWhite, fontWeight: FontWeight.w400),
    ),
  ];

  ///@param [profilePicture] the profile picture of the user
  //TODO get it from the fucking backend
  String profilePicture = 'assets/images/Logo.png';

  ///@param [username] is the username of the user
  String? username = 'Anonymous';

  /// the function get the user's username from the backend
  void getUsername() {
    username = CacheHelper.getData(key: 'username');
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
    if (kDebugMode) {
      print('after$afterId');
      print('before$beforeId');
    }
    if (kDebugMode) {
      print('CATEGOOORYYYY $currentHistoryCategory');
    }
    loadMore ? emit(LoadingMoreHistoryState()) : emit(LoadingHistoryState());
    if (!loadMore) {
      history.clear();
      beforeId = '';
      afterId = '';
    } else {
      if (kDebugMode) {
        print('AFFFTEEEEERRRRRR ');
      }
      if (kDebugMode) {
        print(history[history.length - 1].id);
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
          print('EMPPPTTYYYYY');
        }

        if (loadMore) {
          emit(NoMoreHistoryToLoadState());
        } else {
          emit(HistoryEmptyState());
        }
      } else {
        afterId = value.data['after'];
        beforeId = value.data['before'];
        print(value.data.toString());
        for (int i = 0; i < value.data['children'].length; i++) {
          // logger.wtf(i);
          history.add(PostModel.fromJsonwithData(value.data['children'][i]));
          loadMore
              ? emit(LoadedMoreHistoryState())
              : emit(LoadedHistoryState());
        }
        print('55665445456654654465');
        print(history.length);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
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
    // print(histoyPostsView.toString());
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

  List<SavedCommentModel> savedCommentsList = [];
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
    if (loadMore && isPosts) emit(LoadingMoreSavedPostsState());
    if (loadMore && isComments) emit(LoadingMoreSavedCommentsState());
    if (!loadMore) {
      savedPostsList.clear();
      savedCommentsList.clear();
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
                    : null
            : null,
        'before': before
            ? isPosts
                ? savedCommentsBeforeId
                : isComments
                    ? savedCommentsBeforeId
                    : null
            : null,
      },
    ).then((value) {
      if (value.data['children'].length == 0) {
        if (kDebugMode) {
          print('EMPPPTTYYYYY');
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

        // print(value.data.toString());
        for (int i = 0; i < value.data['children'].length; i++) {
          if (value.data['children']['type'] == 'fullPost' && isPosts) {
            // print('POOOOSTTTTSSS');
            print(value.data['children'][i]['data'].toString());
            savedPostsList
                .add(PostModel.fromJson(value.data['children'][i]['data']));
          } else {
            // print('COOOMMMMEEENNNTSSSS');
            // print(value.data['children'][i]['data'].toString());
            savedCommentsList.add(
                SavedCommentModel.fromJson(value.data['children'][i]['data']));
          }
        }
        print('aaaaaaaaaaaaa');

        print(savedPostsList[0].id.toString());

        loadMore ? emit(LoadedMoreHistoryState()) : emit(LoadedHistoryState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void clearHistoy() {
    DioHelper.postData(
            path: clearHistory,
            data: {'username': username},
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      if (value.statusCode == 200) history.clear();
      emit(ClearHistoryState());
      emit(HistoryEmptyState());
    });
  }
}
