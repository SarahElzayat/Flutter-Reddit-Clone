/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This file contains the Screen of the account settings.

import 'package:flutter/material.dart';
import '../../screens/settings/blocked_accounts.dart';
import '../../widgets/settings/facebook_icon.dart';
import '../../components/helpers/enums.dart';
import '../../components/list_tile_container.dart';
import '../../screens/settings/change_password_screen.dart';
import '../../screens/settings/countries_screen.dart';
import '../../screens/settings/update_email_address_screen.dart';

class AccountSettingsScreen extends StatelessWidget {
  static const routeName = 'account_settings_screen_route';
  const AccountSettingsScreen({super.key});

  void requestChangeGender() {}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: SizedBox(
        height: mediaQuery.size.height * 0.8,
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: ListTileContainer(
                  types: ['', '', '', ''],
                  title: 'BASIC SETTINGS',
                  handler: [
                    () {
                      navigator.pushNamed(UpdateEmailAddressScreen.routeName);
                    },
                    () {
                      navigator.pushNamed(ChangePassword.routeName);
                    },
                    () {
                      navigator.pushNamed(CountriesScreen.routeName);
                    },
                    requestChangeGender,
                  ],
                  listTileIcons: const [
                    Icons.settings,
                    Icons.settings,
                    Icons.location_pin,
                    Icons.supervised_user_circle
                  ],
                  listTileTitles: const [
                    'Update email address',
                    'Change password',
                    'Country',
                    'Gender',
                  ],
                  trailingObject: const [
                    TrailingObjects.tailingIcon,
                    TrailingObjects.tailingIcon,
                    TrailingObjects.tailingIcon,
                    TrailingObjects.dropBox,
                  ],
                  items: const [
                    [],
                    [],
                    [],
                    [
                      'Male',
                      'Female',
                    ],
                  ],
                )),
            Expanded(
                child: ListTileContainer(
              types: ['', ''],
              handler: [
                () {},
                () {},
              ],
              listTileIcons: const [
                CustomIcons.google,
                CustomIcons.facebookSquared,
              ],
              listTileTitles: const [
                'Google',
                'Facebook',
              ],
              title: 'Connected Accounts',
              trailingObject: const [
                TrailingObjects.dropBox,
                TrailingObjects.dropBox,
              ],
              items: const [
                ['Connected', 'Disconnected'],
                ['Connected', 'Disconnected'],
              ],
            )),
            Expanded(
              child: ListTileContainer(
                types: ['', 'fsafsa'],
                handler: [
                  () {
                    navigator.pushNamed(BlockedAccounts.routeName);
                  },
                  () {},
                ],
                listTileIcons: const [
                  Icons.not_interested_sharp,
                  Icons.supervised_user_circle
                ],
                listTileTitles: const [
                  'Managed blocked accounts',
                  'Allow people to follow you'
                ],
                title: 'BLOCKING AND PERMISSIONS',
                trailingObject: const [
                  TrailingObjects.tailingIcon,
                  TrailingObjects.switchButton
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
