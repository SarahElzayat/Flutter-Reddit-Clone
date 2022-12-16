///@author Sarah Elzayat
///@description the right (end) drawer that's present through the whole application
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/screens/history/history_screen_for_web.dart';
import 'package:reddit/screens/create_community_screen/create_community_screen.dart';
import 'package:reddit/screens/saved/saved_screen.dart';
import 'package:reddit/screens/settings/change_profile_picture_screen.dart';

import 'package:reddit/screens/sign_in_and_sign_up_screen/mobile/sign_in_screen.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

import 'package:reddit/screens/settings/settings_main_screen.dart';
import '../../cubit/app_cubit.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/to_be_done_screen.dart';
import '../helpers/color_manager.dart';
import 'components.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ///@param [cubit] an instance of the App Cubit to give easier access to the state management cubit
    final AppCubit cubit = AppCubit.get(context);

    ///@param [rightDrawerItems] the list of right drawer items
    List<Widget> rightDrawerItems = [
      genericTextButton(context, Icons.person, 'My profile',
          const ToBeDoneScreen(text: 'My profile'),
          isLeftDrawer: false),
      genericTextButton(context, Icons.add, 'Create a community',
          const CreateCommunityScreen(),
          isLeftDrawer: false),
      genericTextButton(
          context, Icons.bookmark_border_rounded, 'Saved', const SavedScreen(),
          isLeftDrawer: false),
      genericTextButton(
          context,
          Icons.history_toggle_off_rounded,
          'History',
          kIsWeb
              ? const HistoryScreenForWeb()
              : HistoryScreen(
                  bottomNavBarScreenIndex: cubit.currentIndex,
                ),
          isLeftDrawer: false),
      genericTextButton(context, Icons.pending_outlined, 'Pending Posts',
          const ToBeDoneScreen(text: 'Pending posts'),
          isLeftDrawer: false),
      genericTextButton(context, Icons.drafts_outlined, 'Drafts',
          const ToBeDoneScreen(text: 'Drafts'),
          isLeftDrawer: false),
    ];

    return SafeArea(
        child: Drawer(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                    radius: 80,
                    backgroundImage: 
                    AssetImage('./assets/images/Logo.png')),
                    // NetworkImage(kReleaseMode
                    //     ? 'https://web.read-it.live/${cubit.profilePicture}'
                    //     : Uri.parse(
                    //             'https://localhost:3000/${cubit.profilePicture}')
                    //         .toString())),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'u/${cubit.username.toString()}',
                    style: const TextStyle(
                        color: ColorManager.eggshellWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      gradient: LinearGradient(colors: [
                        ColorManager.gradientOrange,
                        ColorManager.gradientRed
                      ])),
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChangeProfilePicutre(),
                            ));
                      },
                      padding: EdgeInsets.zero,
                      shape: const StadiumBorder(),
                      child: const Text(
                        'Change Profile Picture',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.keyboard_command_key_outlined,
                              color: ColorManager.blue,
                              size: 30,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.karma.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: ColorManager.eggshellWhite,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'karma',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorManager.lightGrey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.cake_outlined,
                              color: ColorManager.blue,
                              size: 30,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.age.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: ColorManager.eggshellWhite,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Reddit age',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: ColorManager.lightGrey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Column(
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rightDrawerItems,
            ),
            genericTextButton(context, Icons.settings_outlined, 'Settings',
                const SettingsMainScreen(),
                isLeftDrawer: false),
            TextButton(
                onPressed: () {
                  CacheHelper.removeData(key: 'token');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.door_front_door_outlined,
                      color: ColorManager.eggshellWhite,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Log out',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
