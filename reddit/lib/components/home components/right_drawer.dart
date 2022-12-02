import 'package:flutter/material.dart';

import '../../Screens/to_be_done_screen.dart';
import '../../cubit/app_cubit.dart';
import '../Helpers/color_manager.dart';
import 'components.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);
    List<Widget> rightDrawerItems = [
      genericTextButton(context, Icons.person, 'My profile', null),
      genericTextButton(context, Icons.add, 'Create a community', null),
      genericTextButton(context, Icons.bookmark_border_rounded, 'Saved', null),
      genericTextButton(
          context, Icons.history_toggle_off_rounded, 'History', null),
      genericTextButton(context, Icons.pending_outlined, 'Pending Posts', null),
      genericTextButton(context, Icons.drafts_outlined, 'Drafts', null),
    ];
    return SafeArea(
        child: Drawer(
      child: SingleChildScrollView(
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
                genericTextButton(
                    context,
                    Icons.keyboard_arrow_down,
                    cubit.username,
                    const ToBeDoneScreen(text: 'account options')),
                genericTextButton(context, null, 'Online / offline',
                    const ToBeDoneScreen(text: 'online/offline')),
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
                const ToBeDoneScreen(text: 'Settings'))
          ],
        ),
      ),
    ));
  }
}
