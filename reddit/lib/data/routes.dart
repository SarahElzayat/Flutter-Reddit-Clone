/// @author Abdelaziz Salah
/// @date 1/11/2022
/// this file containes all our routes in order to avoid destraction in the main file.
import 'package:flutter/material.dart';
import 'package:reddit/screens/inbox/single_message_screen.dart';
import 'package:reddit/screens/inbox/single_notification_screen.dart';
import 'package:reddit/screens/add_post/add_post.dart';
import 'package:reddit/screens/add_post/community_search.dart';
import 'package:reddit/screens/add_post/post_rules.dart';
import 'package:reddit/screens/saved/saved_screen.dart';
import 'package:reddit/screens/subreddit/subreddit_screen.dart';

import '../../screens/bottom_navigation_bar_screens/add_post_screen.dart';
import '../../screens/bottom_navigation_bar_screens/explore_screen.dart';
import '../../screens/bottom_navigation_bar_screens/home_screen.dart';
import '../../screens/forget_user_name_and_password/mobile/recover_username.dart';
import '../../screens/forget_user_name_and_password/web/forget_password_web_screen.dart';
import '../../screens/forget_user_name_and_password/web/forget_user_name_web_screen.dart';
import '../../screens/sign_in_and_sign_up_screen/web/sign_up_for_web_screen.dart';
import '../../screens/to_go_screens/having_trouble_screen.dart';
import '../../screens/to_go_screens/privacy_and_policy.dart';
import '../../screens/to_go_screens/user_agreement_screen.dart';
import 'package:reddit/screens/settings/blocked_accounts.dart';

import '../screens/inbox/Inbox_screen.dart';
import '../screens/inbox/notifications_screen.dart';
import '../screens/add_post/image_screen.dart';
import '../screens/create_community_screen/create_community_screen.dart';
import '../screens/main_screen.dart';
import '../screens/settings/countries_screen.dart';
import '../screens/search/search_results_main_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/settings/change_password_screen.dart';
import '../screens/settings/update_email_address_screen.dart';
import '../screens/sign_in_and_sign_up_screen/web/continue_sign_up_screen.dart';
import '../screens/add_post/paint_screen.dart';
import '../screens/add_post/post.dart';
import '../screens/add_post/video_trimmer.dart';
import '../screens/forget_user_name_and_password/mobile/forget_password_screen.dart';
import '../screens/settings/account_settings_screen.dart';
import '../screens/settings/settings_main_screen.dart';
import '../screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import '../screens/sign_in_and_sign_up_screen/mobile/sign_up_screen.dart';
import '../screens/sign_in_and_sign_up_screen/web/sign_in_for_web_screen.dart';
import '../screens/user_profile/user_profile_edit_screen.dart';
import '../screens/user_profile/user_profile_screen.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  // sign in sign up screens
  RecoverUserName.routeName: (ctx) => const RecoverUserName(),
  // SignInForWebScreen.routeName: (ctx) => const SignInForWebScreen(),
  SignInForWebScreen.routeName: (ctx) => const SignInForWebScreen(),
  SignUpForWebScreen.routeName: (ctx) => const SignUpForWebScreen(),
  ContinueSignUpScreen.routeName: (ctx) => const ContinueSignUpScreen(),
  SignUpScreen.routeName: (ctx) => const SignUpScreen(),
  SignInScreen.routeName: (ctx) => const SignInScreen(),
  ForgetUserNameWebScreen.routeName: (ctx) => ForgetUserNameWebScreen(),
  ForgetPasswordWebScreen.routeName: (ctx) => const ForgetPasswordWebScreen(),
  TroubleScreen.routeName: (ctx) => const TroubleScreen(),
  PrivacyAndPolicy.routeName: (ctx) => const PrivacyAndPolicy(),
  UserAgreementScreen.routeName: (ctx) => const UserAgreementScreen(),
  ForgetPasswordScreen.routeName: (ctx) => const ForgetPasswordScreen(),
  // settings screens
  SettingsMainScreen.routeName: (ctx) => const SettingsMainScreen(),
  AccountSettingsScreen.routeName: (ctx) => const AccountSettingsScreen(),
  UpdateEmailAddressScreen.routeName: (ctx) => const UpdateEmailAddressScreen(),
  BlockedAccounts.routeName: (ctx) => const BlockedAccounts(),
  ChangePassword.routeName: (ctx) => const ChangePassword(),
  CountriesScreen.routeName: (ctx) => const CountriesScreen(),

  // inbox screens
  InboxScreen.routeName: (ctx) => const InboxScreen(),
  NotificationScreen.routeName: (ctx) => const NotificationScreen(),
  SignleNotificationScreen.routeName: (ctx) => const SignleNotificationScreen(),
  SingleMessageScreen.routeName: (ctx) => const SingleMessageScreen(),

  // home screens
  HomeScreenForMobile.routeName: (ctx) => const HomeScreenForMobile(),
  //bottom navigation bar screens
  HomeScreen.routeName: (ctx) => const HomeScreen(),
  AddPostScreen.routeName: (ctx) => const AddPostScreen(),
  ExploreScreen.routeName: (ctx) => const ExploreScreen(),

  SearchScreen.routeName: (ctx) => const SearchScreen(),
  SavedScreen.routeName: (ctx) => const SavedScreen(),
  SearchResults.routeName: (ctx) => const SearchResults(
        searchWord: '',
      ),
  CreateCommunityScreen.routeName: (ctx) => const CreateCommunityScreen(),
  Subreddit.routeName: (ctx) => const Subreddit(),
  AddPost.routeName: (ctx) => const AddPost(),
  ImageScreen.routeName: (ctx) => ImageScreen(),
  PaintScreen.routeName: (ctx) => PaintScreen(),
  TrimmerView.routeName: (ctx) => const TrimmerView(),
  PostSimpleScreen.routeName: (ctx) => const PostSimpleScreen(),
  CommunitySearch.routeName: (ctx) => const CommunitySearch(),
  PostRules.routeName: (ctx) => const PostRules(),
  UserProfileScreen.routeName: (ctx) => const UserProfileScreen(),
  UserProfileEditScreen.routeName: (ctx) => const UserProfileEditScreen(),
};
