///@author: Yasmine Ghanem
///@date: 5/12/2022
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/list_tile_container.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';

class ModTools extends StatelessWidget {
  static const String routeName = 'mod_tools';
  const ModTools({super.key});

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);

    //general mod tools screen navigation functions
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
    return Scaffold(
        appBar: AppBar(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 710,
                child: ListTileContainer(
                    types: const [''],
                    handler: [() {}],
                    title: '      GENERAL',
                    listTileTitles: generalTitles,
                    listTileIcons: generalIcons,
                    trailingObject: const [TrailingObjects.tailingIcon]),
              ),
              SizedBox(
                height: 150,
                child: ListTileContainer(
                    types: const [''],
                    handler: [() {}],
                    title: '      CONTENT & REGULATIONS',
                    listTileTitles: contentAndRegulationsTitles,
                    listTileIcons: contentAndRegulationsIcons,
                    trailingObject: const [TrailingObjects.tailingIcon]),
              ),
              SizedBox(
                height: 315,
                child: ListTileContainer(
                    types: const [''],
                    handler: userManagementFunctions,
                    title: '      USER MANAGEMENT',
                    listTileTitles: userManagementTitles,
                    listTileIcons: userManagementIcons,
                    trailingObject: const [TrailingObjects.tailingIcon]),
              ),
              SizedBox(
                height: 315,
                child: ListTileContainer(
                    types: const [''],
                    handler: resourceLinksFunctions,
                    title: '      RSOURCE LINKS',
                    listTileTitles: resourceLinksTitles,
                    listTileIcons: resourceLinksIcons,
                    trailingObject: const [TrailingObjects.tailingIcon]),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  'Can\'t find an option? Visit reddit.com on desktop',
                  style: TextStyle(
                      color: ColorManager.eggshellWhite, fontSize: 15),
                )),
              )
            ],
          ),
        ));
  }
}
