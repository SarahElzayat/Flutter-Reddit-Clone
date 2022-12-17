///@author Sarah Elzayat
///@date 16/11/2022
///@description this file has some reusable components to use in the home screen
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/app_cubit.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/cubit/user_profile/cubit/user_profile_cubit.dart';
import 'package:reddit/data/home/drawer_communities_model.dart';
import 'package:reddit/screens/user_profile/user_profile_edit_screen.dart';
import 'package:reddit/screens/user_profile/user_profile_screen.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

import '../../screens/create_community_screen/create_community_screen.dart';
import '../../screens/to_be_done_screen.dart';

/// a reusable button with a dropdown list to use in drawer
/// @param [text] is the name of the list
/// @param [list] is the items to be displayed
/// @param [onPressed] is the function that controls the list
/// @param [isOpen] is the state of the list
Widget listButton(
    context, text, List<DrawerCommunitiesModel> list, onPressed, isOpen,
    {isCommunity = false, isModerating = false, required navigateToSubreddit}) {
  return Container(
    decoration: const BoxDecoration(
        border: BorderDirectional(
            end: BorderSide.none,
            start: BorderSide.none,
            top: BorderSide.none,
            bottom: BorderSide(width: 2, color: ColorManager.darkGrey))),
    child: Column(
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
              Icon(
                isOpen
                    ? Icons.keyboard_arrow_down_outlined
                    : Icons.keyboard_arrow_right_outlined,
                color: ColorManager.eggshellWhite,
              )
            ],
          ),
        ),
        if (isOpen)
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (isCommunity)
              genericTextButton(context, Icons.add, 'Create a community',
                  const CreateCommunityScreen(),
                  isLeftDrawer: true),
            if (isModerating)
              genericTextButton(
                  context,
                  Icons.shield_outlined,
                  'Mod Feed',
                  const ToBeDoneScreen(
                    text: 'Mod Feed',
                  ),
                  isLeftDrawer: true),
            if (isModerating)
              genericTextButton(
                  context,
                  Icons.queue,
                  'Mod Queue',
                  const ToBeDoneScreen(
                    text: 'Mod Queue',
                  ),
                  isLeftDrawer: true),
            ListView.builder(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () => SubredditCubit.get(context).setSubredditName(
                        context, list[index].title.toString()),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: yourCommunitiesCard(list[index]),
                    ));
              },
              shrinkWrap: true,
            ),
          ]),
      ],
    ),
  );
}

/// resuable text button with a prefix icon to navigate to another route
Widget genericTextButton(BuildContext context, icon, text, route,
        {required isLeftDrawer}) =>
    TextButton(
        onPressed: () {
          if (isLeftDrawer) {
            AppCubit.get(context).changeLeftDrawer();
          } else {
            AppCubit.get(context).changeRightDrawer();
          }
          if (route is UserProfileScreen) {
            UserProfileCubit.get(context).setUsername(
                CacheHelper.getData(key: 'username'),
                navigate: true);
          }

          // AppCubit.get(context)();
          else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => route,
            ));
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: ColorManager.eggshellWhite,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                text,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            )
          ],
        ));

Widget yourCommunitiesCard(DrawerCommunitiesModel model) {
  return BlocConsumer<AppCubit, AppState>(
    listener: (context, state) {},
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('./assets/images/uranus.png'),
                radius: 10,
              ),
            ),
            Text(
              'r/${model.title.toString()}',
              style: Theme.of(context).textTheme.displayMedium,
              // style:  TextStyle(
              //     The
              //     color: ColorManager.eggshellWhite, fontSize: 16),
            ),
            const Spacer(),
            // IconButton(onPressed: (){}, icon: model.)
          ],
        ),
      );
    },
  );
}
