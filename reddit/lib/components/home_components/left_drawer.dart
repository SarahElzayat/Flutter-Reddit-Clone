///@author Sarah Elzayat
///@date 16/11/2022
///@description the left drawer that's present through the whole application

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/screens/to_be_done_screen.dart';
import 'package:reddit/components/home_components/components.dart';
import 'package:reddit/cubit/app_cubit.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ///@param [cubit] an instance of the App Cubit to give easier access to the state management cubit
    final AppCubit cubit = AppCubit.get(context);

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return SafeArea(
            child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cubit.moderatingListItems.isNotEmpty)
                listButton(context, 'Moderating', cubit.moderatingListItems,
                    cubit.changeModeratingListState, cubit.moderatingListOpen,
                    isModerating: true),
              if (cubit.yourCommunitiesList.isNotEmpty)
                listButton(
                    context,
                    'Your Communities',
                    cubit.yourCommunitiesList,
                    cubit.changeYourCommunitiesState,
                    cubit.yourCommunitiesistOpen,
                    isCommunity: true),
              genericTextButton(context, Icons.bar_chart_rounded, 'All',
                  const ToBeDoneScreen(text: 'All'),
                  isLeftDrawer: true)
            ],
          ),
        ));
      },
    );
  }
}
