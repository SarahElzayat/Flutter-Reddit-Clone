///@author: Yasmine Ghanem
///@date: 16/12/2022
///this widget displays post or comment queues of a certain type in web

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_state.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class QueuesWidget extends StatefulWidget {
  QueuesWidget({super.key, required this.title});

  String title;

  @override
  State<QueuesWidget> createState() => _QueuesWidgetState();
}

class _QueuesWidgetState extends State<QueuesWidget> {
  /// scroll controller for a scrollable screen
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      ModerationCubit.get(context).getQueuePosts(after: true, loadMore: true);
    }
  }

  @override
  void initState() {
    ModerationCubit.get(context).getQueuePosts();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        final ModerationCubit cubit = ModerationCubit.get(context);
        return Container(
          child: Expanded(
            child: Padding(
              padding: (cubit.viewValue == 'Card')
                  ? const EdgeInsets.fromLTRB(200, 50, 200, 50)
                  : const EdgeInsets.all(50),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          underline: Container(color: Colors.transparent),
                          value: cubit.sortingValue,
                          items: sortingItems.map((item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                          onChanged: (value) => cubit.setSortType(value),
                        ),
                        DropdownButton(
                          underline: Container(color: Colors.transparent),
                          value: cubit.listingTypeValue,
                          items: listingTypes.map((item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
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
                      height: 60.h,
                      color: ColorManager.darkGrey,
                      child: (cubit.posts.isEmpty)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/cat_blep.png',
                                    width: 30.w, height: 30.h),
                                const SizedBox(height: 30),
                                Text('The queue is clean!',
                                    style: TextStyle(
                                        color: ColorManager.eggshellWhite,
                                        fontSize: 12.sp)),
                                Text('Kitteh is happy',
                                    style: TextStyle(
                                        color: ColorManager.eggshellWhite,
                                        fontSize: 12.sp))
                              ],
                            )
                          : BlocConsumer<PostNotifierCubit, PostNotifierState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return ListView.builder(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    itemCount: cubit.posts.length,
                                    itemBuilder: ((context, index) {
                                      return PostWidget(
                                          post: cubit.posts[index],
                                          postView: (cubit.viewValue == 'Card')
                                              ? PostView.card
                                              : PostView.classic);
                                    }));
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
