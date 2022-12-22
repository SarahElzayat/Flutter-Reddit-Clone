/// @author Abdelaziz Salah
/// @date 22/12/2022
/// This  file contains the user settings screen in the web version.

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/data/settings/countries.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

class UserSettings extends StatefulWidget {
  static const String routeName = '/user-settings-for-web';
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  String dropDownValue = 'Male';
  String dropDownValueCountries = 'Egypt';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
        appBar: homeAppBar(context, 1),
        body: mediaQuery.size.height < 400 || mediaQuery.size.width < 580
            ? const Scaffold(
                body: Center(child: Text('increase the window size please!')),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: mediaQuery.size.width > 800
                      ? mediaQuery.size.width * 0.6
                      : double.infinity,
                  height: mediaQuery.size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User Settings', style: theme.textTheme.titleLarge),
                      Text('Account Settings',
                          style: theme.textTheme.titleLarge),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ACCOUNT PREFERENCES',
                              style: theme.textTheme.titleMedium),
                          const Divider()
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email address',
                                  style: theme.textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    CacheHelper.getData(key: 'email') ??
                                        'email',
                                    style: theme.textTheme.titleMedium),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorManager.grey,
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {
                                /// todo: here we should change the email.
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text('Change',
                                    style: TextStyle(fontSize: 18)),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Change password',
                                  style: theme.textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'password must be at least 8 characters',
                                    style: theme.textTheme.titleMedium),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: ColorManager.grey,
                                side: const BorderSide(
                                    width: 1, color: Colors.white),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {
                                /// todo: here we should change the password.
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text('Change',
                                    style: TextStyle(fontSize: 18)),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gender', style: theme.textTheme.titleLarge),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'Reddit will never share this information and only uses it to improve what content you see.',
                                    overflow: TextOverflow.clip,
                                    style: theme.textTheme.titleMedium),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              alignment: Alignment.center,
                              value: dropDownValue,
                              items: [
                                DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: 'Male',
                                  child: Text(
                                    'Male',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: 'Female',
                                  child: Text(
                                    'Female',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dropDownValue = value!;
                                });

                                /// TODO: here we should change the gender.
                              },
                            )),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Country',
                            style: theme.textTheme.titleLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'This is your primary location.',
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 8),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                              value: dropDownValueCountries,
                              items: countries.map((country) {
                                return DropdownMenuItem(
                                  child: Text(country),
                                  value: country,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropDownValueCountries = value!;
                                });

                                /// TODO: here we should change the country.
                              },
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
