///@author: Yasmine Ghanem
///@date: 5/12/2022
///this screen shows the mod tools to a moderator of the subreddit

// ignore_for_file: prefer_const_constructors
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
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:reddit/widgets/moderation/community_settings.dart';
import 'package:reddit/widgets/moderation/notification_settings.dart';
import 'package:reddit/widgets/moderation/posts_comments_settings.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModTools extends StatefulWidget {
  static const String routeName = 'mod_tools';
  final String communityName = 'yazzooz';
  ModTools({super.key});

  @override
  State<ModTools> createState() => _ModToolsState();
}

class _ModToolsState extends State<ModTools> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    ModerationCubit.get(context).getSettings(context, widget.communityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    final List<Function> generalFunctions = [
      () {
        cubit.navigate(context, '/description_screen');
      },
      () {
        cubit.navigate(context, '/welcome_message_screen');
      },
      () {
        cubit.navigate(context, '/topics_screen');
      },
      () {
        cubit.navigate(context, '/community_type_screen');
      },
      () {
        cubit.navigate(context, '/content_tag_screen');
      },
      () {
        cubit.navigate(context, '/post_types_screenconst');
      },
      () {
        cubit.navigate(context, '/discovery_screen');
      },
      () {
        cubit.navigate(context, '/modmail_screen');
      },
      () {
        cubit.navigate(context, '/mod_notifications_screen');
      },
      () {
        cubit.navigate(context, '/location_screen');
      },
      () {
        cubit.navigate(context, '/archive_posts_screen');
      },
      () {
        cubit.navigate(context, '/media_in_comments_screen');
      },
    ];

    //content and regulation mod tools screen navigation functions
    final List<Function> contentAndRegulationsFunctions = [
      () {
        cubit.navigate(context, '/create_flair_mod_screen');
      },
      () {
        cubit.navigate(context, '/post_flair_mod_screen');
      }
    ];

    //user managment mod tools screen navigation functions
    final List<Function> userManagementFunctions = [
      () {
        cubit.navigate(context, '/moderators_screen');
      },
      () {
        cubit.navigate(context, '/approved_users_screen');
      },
      () {
        cubit.navigate(context, '/muted_users_screen');
      },
      () {
        cubit.navigate(context, '/banned_users_screen');
      },
      () {
        cubit.navigate(context, '/user_flair_mod_screen');
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
                                  padding: EdgeInsets.all(10.0),
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
                                  padding: EdgeInsets.all(10.0),
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
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('FLAIR',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.lightGrey)),
                                ),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.userFlair,
                                        ModToolsGroup.flair),
                                    title: 'User Flair'),
                                ModListTile(
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.postFlair,
                                        ModToolsGroup.flair),
                                    title: 'PostFlair'),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('CONTENT',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.lightGrey)),
                                ),
                                ModListTile(
                                    title: 'Scheduled post',
                                    onTap: () => cubit.setWebSelectedItem(
                                        context,
                                        ModToolsSelectedItem.scheduledPost,
                                        ModToolsGroup.content)),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
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
                                  padding: EdgeInsets.all(10.0),
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
                                      ? CommunitySettings()
                                      : (cubit.webSelectedItem ==
                                              ModToolsSelectedItem
                                                  .notifications)
                                          ? ModNotificationSettings()
                                          : PostsCommentsSettings()
                                  : CommunitySettings()
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 710,
                          child: ListTileContainer(
                              types: const [],
                              handler: generalFunctions,
                              title: '      GENERAL',
                              listTileTitles: generalTitles,
                              listTileIcons: generalIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon
                              ]),
                        ),
                        SizedBox(
                          height: 150,
                          child: ListTileContainer(
                              types: const [],
                              handler: contentAndRegulationsFunctions,
                              title: '      CONTENT & REGULATIONS',
                              listTileTitles: contentAndRegulationsTitles,
                              listTileIcons: contentAndRegulationsIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon
                              ]),
                        ),
                        SizedBox(
                          height: 315,
                          child: ListTileContainer(
                              types: const [],
                              handler: userManagementFunctions,
                              title: '      USER MANAGEMENT',
                              listTileTitles: userManagementTitles,
                              listTileIcons: userManagementIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon
                              ]),
                        ),
                        SizedBox(
                          height: 315,
                          child: ListTileContainer(
                              types: const [],
                              handler: resourceLinksFunctions,
                              title: '      RSOURCE LINKS',
                              listTileTitles: resourceLinksTitles,
                              listTileIcons: resourceLinksIcons,
                              trailingObject: const [
                                TrailingObjects.tailingIcon
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
