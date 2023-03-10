/// @author Sarah Elzayat
/// @description the component that shows the subreddit results in search page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/data/search/search_result_subbredit_model.dart';

import '../../networks/constant_end_points.dart';
import '../../screens/search/cubit/search_cubit.dart';
import '../helpers/color_manager.dart';

/// @param [model] model of subreddit result

class SubredditResultsContainer extends StatelessWidget {
  const SubredditResultsContainer({super.key, required this.model});
  final SearchResultSubredditModel model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () => SubredditCubit.get(context)
              .setSubredditName(context, model.data!.subredditName.toString()),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                border: BorderDirectional(
                    bottom:
                        BorderSide(width: 1, color: ColorManager.darkGrey))),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundImage: model.data!.profilePicture != null
                        // ignore: prefer_interpolation_to_compose_strings
                        ? NetworkImage(baseUrl +
                            '/' +
                            model.data!.profilePicture.toString())
                        : null,
                    radius: 20,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'r/${model.data!.subredditName.toString()}',
                      style: const TextStyle(
                          fontSize: 16, color: ColorManager.eggshellWhite),
                    ),
                    Row(
                      children: [
                        if (model.data!.nsfw!)
                          const Text(
                            'NFSW ',
                            style: TextStyle(
                                color: Colors.pink,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        Text(
                          '${model.data!.numberOfMembers} members',
                          style: const TextStyle(
                              color: ColorManager.lightGrey,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    if (model.data!.description != null)
                      Text(
                        '${model.data!.description}',
                        style: const TextStyle(
                            color: ColorManager.lightGrey,
                            fontWeight: FontWeight.w400),
                      ),
                  ],
                ),
                const Spacer(),

                ///The button toggels the joind/join subreddit state
                MaterialButton(
                  shape: const StadiumBorder(),
                  color: ColorManager.darkGrey,
                  onPressed: () {
                    if (model.data!.joined!) {
                      SearchCubit.get(context)
                          .leaveSubreddit(name: model.data!.subredditName);
                      model.data!.numberOfMembers =
                          model.data!.numberOfMembers! - 1;
                    } else {
                      SearchCubit.get(context).joinSubreddit(id: model.id);
                      model.data!.numberOfMembers =
                          model.data!.numberOfMembers! + 1;
                    }
                    model.data!.joined = !model.data!.joined!;
                  },
                  child: Text(
                    model.data!.joined! ? 'Joined' : 'Join',
                    style:
                        const TextStyle(color: ColorManager.blue, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
