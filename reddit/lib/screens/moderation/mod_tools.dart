///@author: Yasmine Ghanem
///@date: 5/12/2022
///this screen shows the mod tools to a moderator of the subreddit

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/components/list_tile_container.dart';
import 'package:reddit/components/moderation_components/mod_list_tiles.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/screens/moderation/content_and_regulation/post_flair.dart';
import 'package:reddit/screens/moderation/create_flair.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:reddit/screens/moderation/general_screens/archive_posts.dart';
import 'package:reddit/screens/moderation/general_screens/community_types.dart';
import 'package:reddit/screens/moderation/general_screens/description.dart';
import 'package:reddit/screens/moderation/general_screens/discovery/discovery.dart';
import 'package:reddit/screens/moderation/general_screens/location.dart';
import 'package:reddit/screens/moderation/general_screens/media_in_comments.dart';
import 'package:reddit/screens/moderation/general_screens/mod_notifications.dart';
import 'package:reddit/screens/moderation/general_screens/post_types.dart';
import 'package:reddit/screens/moderation/general_screens/topics.dart';
import 'package:reddit/screens/moderation/general_screens/welcome_message/welcome_message.dart';
import 'package:reddit/screens/moderation/user_management_screens/approved_users.dart';
import 'package:reddit/screens/moderation/user_management_screens/banned_users.dart';
import 'package:reddit/screens/moderation/user_management_screens/moderators.dart';
import 'package:reddit/screens/moderation/user_management_screens/muted_users.dart';
import 'package:reddit/widgets/moderation/community_settings.dart';
import 'package:reddit/widgets/moderation/notification_settings.dart';
import 'package:reddit/widgets/moderation/post_flair_web.dart';
import 'package:reddit/widgets/moderation/posts_comments_settings.dart';
import 'package:reddit/widgets/moderation/traffic_stats.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModTools extends StatefulWidget {
  static const String routeName = 'mod_tools';

  ///the community name of the currents subreddit
  final String communityName;
  const ModTools({super.key, required this.communityName});

  @override
  State<ModTools> createState() => _ModToolsState();
}

class _ModToolsState extends State<ModTools> {
  /// the scroll controller for the column of list tiles
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    /// returns the community settings of the current subreddit
    ModerationCubit.get(context)
        .getCommunitySettings(context, widget.communityName);

    /// returns the post settings of the currents subreddit
    ModerationCubit.get(context).getPostSettings(context, widget.communityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);

    /// the functions for the list tile container to navigate to screens
    final List<Function> generalFunctions = [
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const Description())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const WelcomeMessage())));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => const Topics())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const CommunityType())));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => PostTypes())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const Discovery())));
      },
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => const ModNotifications())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const Location())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const ArchivePosts())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const MediaInComments())));
      },
    ];

    //content and regulation mod tools screen navigation functions
    final List<Function> contentAndRegulationsFunctions = [
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const PostFlair())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const PostFlair())));
      }
    ];

    //user managment mod tools screen navigation functions
    final List<Function> userManagementFunctions = [
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const Moderators())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const ApprovedUsers())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const MutedUsers())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const BannedUsers())));
      },
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateFlair()));
      }
    ];

    //resource links mod tools screen navigation functions
    final List<Function> resourceLinksFunctions = [
      () {
        // cubit.navigate(context, 'route');
      },
      () {
        // cubit.navigate(context, 'route');
      },
      () {
        // cubit.navigate(context, 'route');
      },
      () {
        // cubit.navigate(context, 'route');
      },
      () {
        // cubit.navigate(context, 'route');
      }
    ];
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: (kIsWeb)
                ? homeAppBar(context, 0)
                : AppBar(
                    backgroundColor: ColorManager.darkGrey,
                    shadowColor: ColorManager.eggshellWhite,
                    elevation: 1,
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    title: const Text('Moderator tools'),
                  ),

            ///if the platform is web returns modtools in a column is same screen
            body: (kIsWeb)
                ? Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                        child: Scrollbar(
                            controller: controller,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('QUEUES',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.lightGrey)),
                                ),
                                // list tile of the modtool in web
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.spam,
                                        ModToolsGroup.queues),
                                    title: 'Spam'),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.unmoderated,
                                        ModToolsGroup.queues),
                                    title: 'Unmoderated'),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.edited,
                                        ModToolsGroup.queues),
                                    title: 'Edited'),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('USER MANAGEMENT',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.lightGrey)),
                                ),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.banned,
                                        ModToolsGroup.userManagement),
                                    title: 'Banned Users'),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.muted,
                                        ModToolsGroup.userManagement),
                                    title: 'Muted Users'),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.approved,
                                        ModToolsGroup.userManagement),
                                    title: 'Approved Users'),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.moderator,
                                        ModToolsGroup.userManagement),
                                    title: 'Moderators'),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('FLAIR',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.lightGrey)),
                                ),

                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.postFlair,
                                        ModToolsGroup.flair),
                                    title: 'Post Flair'),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('SETTINGS',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.lightGrey)),
                                ),
                                ModListTile(
                                    title: 'Community',
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.communitySettings,
                                        ModToolsGroup.settings)),
                                ModListTile(
                                    title: 'Posts and Comments',
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.postsAndComments,
                                        ModToolsGroup.settings)),
                                ModListTile(
                                    title: 'Notifications',
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.notifications,
                                        ModToolsGroup.settings)),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('COMMUNITY ACTIVITY',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.lightGrey)),
                                ),
                                ModListTile(
                                    title: 'Traffic stats',
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.trafficStats,
                                        ModToolsGroup.communityActivity)),
                              ],
                            )),
                      ),
                      (cubit.webSelectedGroup == ModToolsGroup.queues)
                          ? queuesWidget(cubit.webSelectedItem)
                          : (cubit.webSelectedGroup ==
                                  ModToolsGroup.userManagement)
                              ? userManagementWidget(cubit.webSelectedItem)
                              : (cubit.webSelectedGroup ==
                                      ModToolsGroup.settings)
                                  ? (cubit.webSelectedItem ==
                                          ModToolsSelectedItem
                                              .communitySettings)
                                      ? const CommunitySettings()
                                      : (cubit.webSelectedItem ==
                                              ModToolsSelectedItem
                                                  .notifications)
                                          ? const ModNotificationSettings()
                                          : const PostsCommentsSettings()
                                  : (cubit.webSelectedGroup ==
                                          ModToolsGroup.flair)
                                      ? WebPostFlair()
                                      : const TrafficStats()
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100.h,
                          child: ListTileContainer(
                              handler: generalFunctions,
                              title: '      GENERAL',
                              listTileTitles: generalTitles,
                              listTileIcons: generalIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                              ]),
                        ),
                        SizedBox(
                          height: 20.h,
                          child: ListTileContainer(
                              handler: contentAndRegulationsFunctions,
                              title: '      CONTENT & REGULATIONS',
                              listTileTitles: contentAndRegulationsTitles,
                              listTileIcons: contentAndRegulationsIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                              ]),
                        ),
                        SizedBox(
                          height: 40.h,
                          child: ListTileContainer(
                              handler: userManagementFunctions,
                              title: '      USER MANAGEMENT',
                              listTileTitles: userManagementTitles,
                              listTileIcons: userManagementIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                              ]),
                        ),
                        SizedBox(
                          height: 40.h,
                          child: ListTileContainer(
                              handler: resourceLinksFunctions,
                              title: '      RSOURCE LINKS',
                              listTileTitles: resourceLinksTitles,
                              listTileIcons: resourceLinksIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                                TrailingObjects.tailingIcon,
                              ]),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(
                            'Can\'t find an option? Visit reddit.com on desktop',
                            style: TextStyle(
                                color: ColorManager.eggshellWhite,
                                fontSize: 15),
                          )),
                        )
                      ],
                    ),
                  ));
      },
    );
  }
}
