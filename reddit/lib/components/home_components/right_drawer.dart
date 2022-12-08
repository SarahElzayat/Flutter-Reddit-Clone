///@author Sarah Elzayat
///@description the right (end) drawer that's present through the whole application
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/Screens/history/history_screen_for_web.dart';
import 'package:reddit/screens/create_community_screen/create_community_screen.dart';
import 'package:reddit/screens/saved/saved_screen.dart';

import '../../cubit/app_cubit.dart';
import '../../screens/history/history_screen.dart';
import '../../screens/to_be_done_screen.dart';
import '../helpers/color_manager.dart';
import 'components.dart';

///TODO try changing it into a scaffold
class RightDrawer extends StatelessWidget {
  const RightDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ///@param [cubit] an instance of the App Cubit to give easier access to the state management cubit
    final AppCubit cubit = AppCubit.get(context);

    ///@param [rightDrawerItems] the list of right drawer items
    List<Widget> rightDrawerItems = [
      genericTextButton(context, Icons.person, 'My profile', null,
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
      genericTextButton(context, Icons.pending_outlined, 'Pending Posts', null,
          isLeftDrawer: false),
      genericTextButton(context, Icons.drafts_outlined, 'Drafts', null,
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
                CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                      cubit.profilePicture,
                    )),
                    // Text
                genericTextButton(
                    context,
                    Icons.keyboard_arrow_down,
                    cubit.username,
                    const ToBeDoneScreen(text: 'account options'),
                    isLeftDrawer: false),

                // genericTextButton(context, null, 'Online / offline',
                //     const ToBeDoneScreen(text: 'online/offline'),
                //     isLeftDrawer: false),

                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      gradient: LinearGradient(colors: [
                        ColorManager.gradientOrange,
                        ColorManager.gradientRed
                      ])),
                  child: MaterialButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      shape: const StadiumBorder(),
                      child: const Text(
                        'Change Profile Picture',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      //TODO do them properly
                      Text('Karma'),
                      Text('Age'),
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
                const ToBeDoneScreen(text: 'Settings'),
                isLeftDrawer: false),
          ],
        ),
      ),
    ));
  }
}
