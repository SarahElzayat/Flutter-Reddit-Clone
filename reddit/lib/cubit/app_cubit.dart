/// @author Sarah El-Zayat
/// @date 9/11/2022
/// App cubit for handling application's state management for home, history, drawers...
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/explore_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/inbox_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/notifications_screen.dart';
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
    const InboxScreen(),
    const NotificationsScreen()
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
  String username = 'Anonymous';

  /// the function get the user's username from the backend
  void getUsername() {
    username = CacheHelper.getData(key: 'username');
  }

  ///@param [history] the list of the user's history, changes according to its category
  List<PostModel> history = [];

  ///@param [path] is the path of the desired history category
  /// the function gets the history of the specified path (recent, upvoted, downvoted, hidden) history
  /// emits some corresponding states and fills [history] list
  void getHistory(path) {
    emit(LoadingHistoryState());
    history.clear();
    DioHelper.getData(
      path: '$user/$username$path',
      token: CacheHelper.getData(key: 'token'),
      query: {},
    ).then((value) {
      // print('KOSSOM EL VALUE' + value.data.toString());
      if (value.data['children'].length == 0) {
        emit(HistoryEmptyState());
      } else {
        for (int i = 0; i < value.data['children'].length; i++) {
          history.add(PostModel.fromJsonwithData(value.data['children'][i]));
          emit(LoadedHistoryState());
        }
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
    switch (historyCategoryIndex) {
      case 0:
        getHistory(recentHistory);
        break;
      case 1:
        getHistory(upvotedHistory);
        break;
      case 2:
        getHistory(downvotedHistory);
        break;
      case 3:
        getHistory(hiddenHistory);
        break;
    }

    emit(ChangeHistoryCategoryState());
  }

  List<Icon> historyPostViewsIcons = [
    const Icon(Icons.crop_square_outlined),
    const Icon(Icons.view_list),
  ];

  int historyPostViewIconIndex = 0;
  HistoyPostsView histoyPostsView = HistoyPostsView.card;
  void changeHistoryPostView(HistoyPostsView view) {
    historyPostViewIconIndex = view.index;
    histoyPostsView = view;
    print(histoyPostsView.toString());
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

  /// the function gets the history of the specified path (recent, upvoted, downvoted, hidden) history
  /// emits some corresponding states and fills [savedPostsList] list
  void getSavedPosts(path) {
    emit(LoadingHistoryState());
    history.clear();
    DioHelper.getData(
      path: '$user/$username$path',
      token: CacheHelper.getData(key: 'token'),
      query: {},
    ).then((value) {
      // print('KOSSOM EL VALUE' + value.data.toString());
      if (value.data['children'].length == 0) {
        emit(HistoryEmptyState());
      } else {
        for (int i = 0; i < value.data['children'].length; i++) {
          history.add(PostModel.fromJsonwithData(value.data['children'][i]));
          emit(LoadedHistoryState());
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
