import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/list_tile_container.dart';

class ModTools extends StatelessWidget {
  ModTools({super.key});

  final List<String> generalTitles = [
    'Description',
    'Welcome message',
    'Topics',
    'Community Type',
    'Content tag',
    'Post types',
    'Discovery',
    'Modmail',
    'Mod notifications',
    'Location',
    'Archive Posts',
    'Media in comments'
  ];

  final List<String> contentAndRegulationsTitles = [
    'Post flair',
    'Scheduled posts',
  ];

  final List<String> userManagementTitles = [
    'Moderators',
    'Approved users',
    'Mutes users',
    'Banned users',
    'User flair',
  ];

  final List<String> resourceLinksTitles = [
    'r/ModSupport',
    'r/modhelp',
    'Mod help center',
    'Mod guidelines',
    'Connect Reddit',
  ];

  final List<IconData> generalIcons = [
    Icons.edit_outlined,
    Icons.message_outlined,
    Icons.label_outlined,
    Icons.lock_outline,
    Icons.star_border_outlined,
    Icons.menu_book_outlined,
    Icons.compass_calibration_outlined,
    Icons.mail_outline,
    Icons.notifications_none_outlined,
    Icons.location_on_outlined,
    Icons.archive_outlined,
    Icons.image_outlined
  ];

  final List<IconData> contentAndRegulationsIcons = [
    Icons.edit_outlined,
    Icons.message_outlined,
  ];

  final List<IconData> userManagementIcons = [
    Icons.shield_outlined,
    Icons.person_outlined,
    Icons.volume_mute_outlined,
    Icons.gavel_outlined,
    Icons.label_outlined
  ];

  final List<IconData> resourceLinksIcons = [
    Icons.shield,
    Icons.shield,
    Icons.help_outline_rounded,
    Icons.list_alt_outlined,
    Icons.reddit_outlined
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.darkGrey,
          shadowColor: ColorManager.eggshellWhite,
          elevation: 1,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (() {
                Navigator.pop(context);
              })),
          title: const Text('Moderator tools'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.83,
                child: ListTileContainer(
                    title: '      GENERAL',
                    listTileTitles: generalTitles,
                    listTileIcons: generalIcons,
                    trailingObject: TrailingObjects.tailingIcon),
              ),
              SizedBox(
                height: height * 0.19,
                child: ListTileContainer(
                    title: '      CONTENT & REGULATIONS',
                    listTileTitles: contentAndRegulationsTitles,
                    listTileIcons: contentAndRegulationsIcons,
                    trailingObject: TrailingObjects.tailingIcon),
              ),
              SizedBox(
                height: height * 0.38,
                child: ListTileContainer(
                    title: '      USER MANAGEMENT',
                    listTileTitles: userManagementTitles,
                    listTileIcons: userManagementIcons,
                    trailingObject: TrailingObjects.tailingIcon),
              ),
              SizedBox(
                height: height * 0.38,
                child: ListTileContainer(
                    title: '      RSOURCE LINKS',
                    listTileTitles: resourceLinksTitles,
                    listTileIcons: resourceLinksIcons,
                    trailingObject: TrailingObjects.tailingIcon),
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
        )
        // ],
        // ),
        );
  }
}
