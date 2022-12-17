///@author: Yasmine Ghanem
///@date: 16/12/2022
///this widget displays post or comment queues of a certain type in web

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class QueuesWidget extends StatelessWidget {
  QueuesWidget({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: (cubit.viewValue == 'Card')
                ? const EdgeInsets.fromLTRB(200, 50, 200, 50)
                : const EdgeInsets.all(50),
            child: ListView(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14.sp),
                ),
                Row(
                  children: [
                    DropdownButton(
                      underline: Container(color: Colors.transparent),
                      value: cubit.sortingValue,
                      items: sortingItems.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (value) => cubit.setSortType(value),
                    ),
                    DropdownButton(
                      underline: Container(color: Colors.transparent),
                      value: cubit.listingTypeValue,
                      items: listingTypes.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (value) => cubit.setListType(value),
                    ),
                    const Spacer(),
                    DropdownButton(
                        underline: Container(color: Colors.transparent),
                        value: cubit.viewValue,
                        items: view.map((item) {
                          return DropdownMenuItem(
                              value: item, child: Text(item));
                        }).toList(),
                        onChanged: (value) => cubit.setView(value)),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 60.h,
                  color: ColorManager.darkGrey,
                  child: (cubit.posts.isEmpty)
                      ? Center(
                          child: Text('The queue is clean!',
                              style: TextStyle(
                                  color: ColorManager.eggshellWhite,
                                  fontSize: 12.sp)))
                      : Expanded(
                          child: ListView.builder(
                              itemCount: cubit.posts.length,
                              itemBuilder: ((context, index) {
                                return const ListTile();
                              })),
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
