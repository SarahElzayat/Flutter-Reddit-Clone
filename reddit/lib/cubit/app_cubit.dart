/// @author Sarah El-Zayat
/// @date 9/11/2022
/// App cubit for handling application's state management
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/explore_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/inbox_screen.dart';
import 'package:reddit/screens/bottom_navigation_bar_screens/notifications_screen.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import 'package:reddit/widgets/posts/post_upper_bar.dart';

import '../components/helpers/color_manager.dart';
import '../data/post_model/post_model.dart';
import '../data/temp_data/tmp_data.dart';
import '../networks/constant_end_points.dart';
import '../networks/dio_helper.dart';
import '../screens/bottom_navigation_bar_screens/add_post_screen.dart';
import '../widgets/posts/post_widget.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  List screensNames = ['Home', 'Discover', 'Create', 'Chat', 'Inbox'];
  late BuildContext mainScreenContext;
  int currentIndex = 0;
  List<Widget> bottomNavBarScreens = [
    const HomeScreen(),
    const ExploreScreen(),
    const AddPostScreen(),
    // const AddPost(),
    const InboxScreen(),
    const NotificationsScreen()
  ];

  List<Widget> homePosts = [
    PostWidget(post: textPost),
    PostWidget(post: linkPost, upperRowType: ShowingOtions.onlyUser),
    PostWidget(post: oneImagePost),
    PostWidget(post: manyImagePost),
    // PostWidget(post: oneImagePost),
    // PostWidget(post: manyImagePost),
  ];
  List<Widget> popularPosts = [
    PostWidget(post: textPost),
    PostWidget(post: oneImagePost),
    PostWidget(post: oneImagePost),
    PostWidget(post: oneImagePost),
    PostWidget(post: oneImagePost),
  ];

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

  ///@param [index] is the index of the bottom navigation bar screen
  ///the function changes the displayed screen accordingly
  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

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

  void changeRightDrawer() {
    emit(ChangeRightDrawerState());
  }
    void changeLeftDrawer() {
    emit(ChangeLeftDrawerState());
  }

  ///@param [context] is the context of the desired screen
  void getMainScreenContext(context) {
    mainScreenContext = context;
  }

  ///Left drawer 'moderating' list state management
  bool moderatingListOpen = true;

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

  void changeModeratingListState() {
    moderatingListOpen = !moderatingListOpen;
    emit(ChangeModeratingListState());
  }

  ///Left drawer 'your communitites' list state management
  bool yourCommunitiesistOpen = true;

  void changeYourCommunitiesState() {
    yourCommunitiesistOpen = !yourCommunitiesistOpen;
    emit(ChangeYourCommunitiesState());
  }

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

  String profilePicture = 'assets/images/Logo.png';
  String username = 'Anonymous';
  void getUsername() {
    username = CacheHelper.getData(key: 'username');
  }

  List<PostModel> history = [];

  void getHistory(path) {
    emit(LoadingHistoryState());
    history.clear();
    DioHelper.getData(
      path: '$user/$username$path',
      token: CacheHelper.getData(key: 'token'),
      query: {},
    ).then((value) {
      for (int i = 0; i < value.data['children'].length; i++) {
        history.add(PostModel.fromJsonwithData(value.data['children'][i]));
        emit(LoadedHistoryState());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  int historyCategoryIndex = 0;
  List<String> historyCategoriesNames = [
    'Recent',
    'Upvoted',
    'Downvoted',
    'Hidden'
  ];
  List<Icon> historyCategoriesIcons = [
    const Icon(Icons.timelapse),
    const Icon(Icons.arrow_circle_up_rounded),
    const Icon(Icons.arrow_circle_down_rounded),
    const Icon(Icons.hide_image_outlined),
  ];

  void changeHistoryCategory(index) {
    historyCategoryIndex = index;
    switch (index) {
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
}
