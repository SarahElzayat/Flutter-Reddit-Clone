/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This file contains the Settings main screen which is the first screen opens
/// when the user presses on the settings in the UI.

import 'package:flutter/material.dart';
import '../../components/list_tile_container.dart';
import '../../screens/settings/account_settings_screen.dart';
import '../../../components/helpers/enums.dart';

class SettingsMainScreen extends StatelessWidget {
  static const routeName = '/settings_main_screen_route';

  const SettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SizedBox(
        height: mediaQuery.size.height * 0.6,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListTileContainer(
                  types: const [''],
                  handler: [
                    () {
                      navigator.pushNamed(AccountSettingsScreen.routeName);
                    }
                  ],
                  title: 'General',
                  listTileTitles: const [
                    'Account Settings',
                  ],
                  listTileIcons: const [
                    Icons.supervised_user_circle,
                  ],
                  trailingObject: const [
                    TrailingObjects.tailingIcon,
                    TrailingObjects.tailingIcon,
                  ]),
            ),
            Expanded(
                flex: 1,
                child: ListTileContainer(
                  types: const [
                    'Best',
                    'Hot',
                    'New',
                    'Top',
                    'Raising',
                    'Controversial',
                  ],
                  handler: [() {}],
                  listTileIcons: const [Icons.home_outlined],
                  listTileTitles: const ['Sort home posts by'],
                  items: const [
                    [
                      'Best',
                      'Hot',
                      'New',
                      'Top',
                      'Raising',
                      'Controversial',
                    ]
                  ],
                  title: 'FEED OPTIONS',
                  trailingObject: const [TrailingObjects.dropBox],
                )),
            Expanded(
                flex: 2,
                child: ListTileContainer(
                  types: const ['autPlay', 'showNSFW'],
                  handler: [
                    () {},
                    () {},
                  ],
                  listTileIcons: const [
                    Icons.play_arrow,
                    Icons.supervised_user_circle
                  ],
                  listTileTitles: const [
                    'AutoPlay',
                    'Show NSFW content (i\'m over 18)'
                  ],
                  title: 'View Options',
                  trailingObject: const [
                    TrailingObjects.switchButton,
                    TrailingObjects.switchButton
                  ],
                  items: const [[], []],
                ))
          ],
        ),
      ),
    );
  }
}
