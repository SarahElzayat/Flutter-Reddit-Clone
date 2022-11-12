/// @author Sarah El-Zayat
/// @date 9/11/2022
/// App cubit for handling application's state management


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/add_post_screen.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/explore_screen.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/inbox_screen.dart';
import 'package:reddit/Screens/bottom_navigation_bar_screens/notifications_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  List screensNames = ['Home', 'Discover', 'Create', 'Chat', 'Inbox'];

  int currentIndex = 0;
  List<Widget> bottomNavBarScreens = [
    const HomeScreen(),
    const ExploreScreen(),
    const AddPostScreen(),
    const InboxScreen(),
    const NotificationsScreen()
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

  void changeEndDrawer() {
    emit(ChangeEndDrawerState());
  }
}