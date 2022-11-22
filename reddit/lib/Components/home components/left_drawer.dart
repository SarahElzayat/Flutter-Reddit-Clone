///@author Sarah Elzayat
///@date 16/11/2022
///@description left drawer to add to main screen

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/screens/home/all_screen.dart';
import 'package:reddit/components/home%20components/components.dart';
import 'package:reddit/cubit/app_cubit.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);

    return SafeArea(
        child: Drawer(
      child: Column(
        children: [
          listButton(context, 'Moderating', cubit.moderatingListItems,
              cubit.changeModeratingListState, cubit.moderatingListOpen),
          listButton(context, 'Your Communities', cubit.yourCommunitiesList,
              cubit.changeYourCommunitiesState, cubit.yourCommunitiesistOpen),

          ///TODO use/make a reusable component
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AllScreen(),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.align_vertical_bottom_rounded,
                    color: ColorManager.eggshellWhite),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
