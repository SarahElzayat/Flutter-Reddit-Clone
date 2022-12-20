import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/history/history_screen.dart';
import 'screens/history/history_screen_for_web.dart';
import 'cubit/app_cubit/app_cubit.dart';
import 'screens/moderation/content_and_regulation/post_flair.dart';
import 'screens/moderation/create_flair.dart';
import 'screens/moderation/cubit/moderation_cubit.dart';
import 'screens/moderation/general_screens/archive_posts.dart';
import 'screens/moderation/general_screens/community_types.dart';
import 'screens/moderation/general_screens/content_tag.dart';
import 'screens/moderation/general_screens/description.dart';
import 'screens/moderation/general_screens/discovery/discovery.dart';
import 'screens/moderation/general_screens/location.dart';
import 'screens/moderation/general_screens/media_in_comments.dart';
import 'screens/moderation/general_screens/mod_notifications.dart';
import 'screens/moderation/general_screens/post_types.dart';
import 'screens/moderation/general_screens/topics.dart';
import 'screens/moderation/general_screens/welcome_message/welcome_message.dart';
import 'screens/moderation/user_management_screens/add_banned_user.dart';
import 'screens/moderation/user_management_screens/approved_users.dart';
import 'screens/moderation/user_management_screens/banned_users.dart';
import 'screens/moderation/user_management_screens/invite_moderator.dart';
import 'screens/moderation/user_management_screens/moderators.dart';
import 'screens/moderation/user_management_screens/muted_users.dart';
import 'screens/moderation/user_management_screens/user_flair.dart';
import 'screens/add_post/video_trimmer.dart';

import 'cubit/add_post/cubit/add_post_cubit.dart';
import 'screens/add_post/add_post.dart';
import 'screens/add_post/post.dart';
import 'screens/add_post/image_screen.dart';
import 'screens/add_post/paint_screen.dart';

class AppRouter {
  static final AddPostCubit _addPostCubit = AddPostCubit();
  static final AppCubit _appCubit = AppCubit();
  static final ModerationCubit _modCubit = ModerationCubit();
  // late InternetCubit _internetCubit;
  // late CounterCubit _counterCubit;

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addPostCubit,
                  child: const AddPost(),
                ));

      case '/image_screen_route':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addPostCubit,
                  child: ImageScreen(),
                ));

      case '/paint_screen_route':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addPostCubit,
                  child: PaintScreen(),
                ));

      case '/trimmerView_screen_route':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _addPostCubit,
            child: const TrimmerView(),
          );
        });

      case '/postSimpleScreen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _addPostCubit,
            child: const PostSimpleScreen(),
          );
        });

      case '/history_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _appCubit,
            child: const HistoryScreen(bottomNavBarScreenIndex: 0),
          );
        });

      case '/history_screen_web':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _appCubit,
            child: const HistoryScreenForWeb(),
          );
        });

      case '/description_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const Description(),
          );
        });

      case '/welcome_message_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const WelcomeMessage(),
          );
        });

      case '/topics_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const Topics(),
          );
        });

      case '/community_type_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const CommunityType(),
          );
        });

      case '/content_tag_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const ContentTag(),
          );
        });

      case '/post_types_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: PostTypes(),
          );
        });

      case '/discovery_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const Discovery(),
          );
        });

      case '/mod_notifications_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const ModNotifications(),
          );
        });

      case '/location_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const Location(),
          );
        });

      case '/archive_posts_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const ArchivePosts(),
          );
        });

      case '/media_in_comments_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const MediaInComments(),
          );
        });

      case '/moderators_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const Moderators(),
          );
        });

      case '/invite_moderator_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: InviteModerator(),
          );
        });

      case '/approved_users_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const ApprovedUsers(),
          );
        });

      case '/muted_users_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const MutedUsers(),
          );
        });

      case '/banned_users_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const BannedUsers(),
          );
        });

      case '/add_banned_user_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: AddBannedUser(),
          );
        });

      case '/user_flair_mod_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const UserFlair(),
          );
        });

      case '/post_flair_mod_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const PostFlair(),
          );
        });

      case '/create_flair_mod_screen':
        return MaterialPageRoute(builder: (_) {
          return BlocProvider.value(
            value: _modCubit,
            child: const CreateFlair(),
          );
        });

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
