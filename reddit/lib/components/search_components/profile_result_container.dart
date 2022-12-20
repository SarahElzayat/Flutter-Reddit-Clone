/// @author Sarah Elzayat
/// @description the component that shows the user results in search page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/search/search_result_profile_model.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';

import '../../networks/constant_end_points.dart';

///@param [model] model of user result
class ProfileResultContainer extends StatelessWidget {
  const ProfileResultContainer({super.key, required this.model});
  final SearchResultProfileModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return InkWell(
            //TODO on tap => navigate to profile
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
                      backgroundImage: model.data!.avatar != null
                          ? NetworkImage('$baseUrl/${model.data!.avatar}')
                          : null,
                      radius: 20,
                    ),
                  ),
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'u/${model.data!.username.toString()}',
                        style: const TextStyle(
                            fontSize: 16, color: ColorManager.eggshellWhite),
                      ), // const Spacer(),
                      Text(
                        '${model.data!.karma} karma',
                        style: const TextStyle(
                            color: ColorManager.lightGrey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Spacer(),

                  ///the button toggels the following state and sets it in the backend
                  MaterialButton(
                    shape: const StadiumBorder(),
                    color: ColorManager.darkGrey,
                    onPressed: () {
                      SearchCubit.get(context).folowUser(
                          username: model.data!.username,
                          follow: !model.data!.following!);
                      model.data!.following = !model.data!.following!;
                    },
                    child: Text(
                      model.data!.following! ? 'Following' : 'Follow',
                      style: const TextStyle(
                          color: ColorManager.blue, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
