///@author Sarah Elzayat
///@date 16/11/2022
///@description the left drawer that's present through the whole application

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/home_components/components.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';
import 'package:reddit/screens/to_be_done_screen.dart';

/// @param [cubit] an instance of the App Cubit to give easier access to the state management cubit
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context)
      ..getYourCommunities()
      ..getYourModerating();
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
            child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (cubit.favoriteCommunities.isNotEmpty)
                  listButton(context, 'Favorites', cubit.favoriteCommunities,
                      cubit.changeFavoritesListState, cubit.favoritesListOpen,
                      // isModerating: true,
                      isFavorites: true,
                      navigateToSubreddit: () {}),
                if (cubit.moderatingListItems.isNotEmpty)
                  listButton(context, 'Moderating', cubit.moderatingListItems,
                      cubit.changeModeratingListState, cubit.moderatingListOpen,
                      isModerating: true, navigateToSubreddit: () {}),
                listButton(
                    context,
                    'Your Communities',
                    cubit.yourCommunitiesList,
                    cubit.changeYourCommunitiesState,
                    cubit.yourCommunitiesistOpen,
                    isCommunity: true,
                    navigateToSubreddit: () {}),
                genericTextButton(context, Icons.bar_chart_rounded, 'All',
                    const ToBeDoneScreen(text: 'All'),
                    isLeftDrawer: true)
              ],
            ),
          ),
        ));
      },
    );
  }
}
