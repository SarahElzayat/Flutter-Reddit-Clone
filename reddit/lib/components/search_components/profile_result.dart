import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/search/search_result_profile_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';

class ProfileResult extends StatelessWidget {
  const ProfileResult({super.key, required this.model});
  final SearchResultProfileModel model;
  @override
  Widget build(BuildContext context) {
    // SearchCubit cubit = SearchCubit.get(context);
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
                          ? NetworkImage(model.data!.avatar.toString())
                          : const NetworkImage(unknownAvatar),
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
                      ),
                      // const Spacer(),
                      Text(
                        '${model.data!.karma} karma',
                        style: const TextStyle(
                            color: ColorManager.lightGrey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Spacer(),
                  //TODO
                  MaterialButton(
                    shape: const StadiumBorder(),
                    color: ColorManager.darkGrey,
                    onPressed: () {}, //=> cubit.folowUser(model.id),
                    child: const Text(
                      'Follow',
                      style: TextStyle(color: ColorManager.blue, fontSize: 16),
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
