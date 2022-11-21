import 'package:flutter/material.dart';
import 'package:reddit/Screens/saved/saved_screen.dart';
import '../../Screens/forget_user_name_and_password/web/forget_password_web_screen.dart';
import '../../Screens/forget_user_name_and_password/web/forget_user_name_web_screen.dart';
import '../../Screens/main_screen.dart';
import '../../Screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';
import '../../Screens/to_go_screens/having_trouble_screen.dart';
import '../../Screens/to_go_screens/privacy_and_policy.dart';
import '../../Screens/to_go_screens/user_agreement_screen.dart';
import '../../Screens/bottom_navigation_bar_screens/add_post_screen.dart';
import '../../Screens/bottom_navigation_bar_screens/explore_screen.dart';
import '../../Screens/bottom_navigation_bar_screens/home_screen.dart';
import '../../Screens/bottom_navigation_bar_screens/inbox_screen.dart';
import '../../Screens/search/search_results_main_screen.dart';
import '../../Screens/search/search_screen.dart';
import '../../screens/forget_user_name_and_password/mobile/recover_username.dart';
import '../Screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import '../Screens/bottom_navigation_bar_screens/notifications_screen.dart';
import '../screens/forget_user_name_and_password/mobile/forget_password_screen.dart';
import '../screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import '../screens/sign_in_and_sign_up_screen/mobile/sign_up_screen.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  RecoverUserName.routeName: (ctx) => const RecoverUserName(),
  SignInForWebScreen.routeName: (ctx) => SignInForWebScreen(),
  SignUpForWebScreen.routeName: (ctx) => SignUpForWebScreen(),
  SignUpScreen.routeName: (ctx) => const SignUpScreen(),
  SignInScreen.routeName: (ctx) => const SignInScreen(),
  ForgetUserNameWebScreen.routeName: (ctx) => ForgetUserNameWebScreen(),
  ForgetPasswordWebScreen.routeName: (ctx) => ForgetPasswordWebScreen(),
  TroubleScreen.routeName: (ctx) => const TroubleScreen(),
  PrivacyAndPolicy.routeName: (ctx) => const PrivacyAndPolicy(),
  UserAgreementScreen.routeName: (ctx) => const UserAgreementScreen(),
  ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),

  MainScreen.routeName: (ctx) => const MainScreen(),
  //bottom navigation bar screens
  HomeScreen.routeName: (ctx) => const HomeScreen(),
  InboxScreen.routeName: (ctx) => const InboxScreen(),
  AddPostScreen.routeName: (ctx) => const AddPostScreen(),
  ExploreScreen.routeName: (ctx) => const ExploreScreen(),
  NotificationsScreen.routeName: (ctx) => const NotificationsScreen(),

  SearchScreen.routeName: (ctx) => const SearchScreen(),
  SavedScreen.routeName: (ctx) => const SavedScreen(),
  SearchResults.routeName: (ctx) => const SearchResults(
        searchWord: '',
      ),
};
