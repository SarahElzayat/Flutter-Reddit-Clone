///@author: Yasmine Ghanem
///@date: 16/12/2022
///this widget displays post or comment queues of a certain type in web

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/style.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_cubit.dart';
import 'package:reddit/cubit/post_notifier/post_notifier_state.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool test = false;
  void _scrollListener() {
    logger.wtf('ALOOOO LISTENERRRRR');

    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      logger.wtf('ALOOOO');
      ModerationCubit.get(context).getQueuePosts(after: true, loadMore: true);
    }
  }

  @override
  void initState() {
    logger.wtf('ALOOOO INIT STATEEEE');
    //ModerationCubit.get(context).getQueuePosts();
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
        return
            // SingleChildScrollView(
            //   controller: _scrollController,
            //   child: Padding(
            //     padding: (cubit.viewValue == 'Card')
            //         ? const EdgeInsets.fromLTRB(200, 50, 200, 50)
            //         : const EdgeInsets.all(50),
            //     child: Container(
            //       width: ,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             widget.title,
            //             style: TextStyle(fontSize: 14.sp),
            //           ),
            //           Row(
            //             children: [
            //               DropdownButton(
            //                 underline: Container(color: Colors.transparent),
            //                 value: cubit.sortingValue,
            //                 items: sortingItems.map((item) {
            //                   return DropdownMenuItem(
            //                       value: item, child: Text(item));
            //                 }).toList(),
            //                 onChanged: (value) => cubit.setSortType(value),
            //               ),
            //               DropdownButton(
            //                 underline: Container(color: Colors.transparent),
            //                 value: cubit.listingTypeValue,
            //                 items: listingTypes.map((item) {
            //                   return DropdownMenuItem(
            //                       value: item, child: Text(item));
            //                 }).toList(),
            //                 onChanged: (value) => cubit.setListType(value),
            //               ),
            //               DropdownButton(
            //                   underline: Container(color: Colors.transparent),
            //                   value: cubit.viewValue,
            //                   items: view.map((item) {
            //                     return DropdownMenuItem(
            //                         value: item, child: Text(item));
            //                   }).toList(),
            //                   onChanged: (value) => cubit.setView(value)),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // );

            Container(
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
                    // state is EmptyQueue
                    //     ? Container(
                    //         width: double.infinity,
                    //         height: 60.h,
                    //         color: ColorManager.darkGrey,
                    //         child: Center(
                    //             child: Text('The queue is clean!',
                    //                 style: TextStyle(
                    //                     color: ColorManager.eggshellWhite,
                    //                     fontSize: 12.sp))))
                    //     :

                    //     /// a conditional builder on showing the history list
                    //     /// it shows a circular progress indicator while loading
                    //     ConditionalBuilder(
                    //         condition: state is! LoadingQueue ||
                    //             state is! LoadedMoreQueue,
                    //         fallback: (context) => const Center(
                    //             child: CircularProgressIndicator(
                    //           color: ColorManager.blue,
                    //         )),
                    //         builder: (context) {
                    //           return BlocConsumer<PostNotifierCubit,
                    //               PostNotifierState>(
                    //             listener: (context, state) {},
                    //             builder: (context, state) {
                    //               return Expanded(
                    //                 child: ListView.builder(
                    //                   physics:
                    //                       const NeverScrollableScrollPhysics(),
                    //                   itemBuilder: (context, index) =>
                    //                       // index < cubit.history.length ?
                    //                       PostWidget(
                    //                     postView: cubit.viewValue == 'Card'
                    //                         ? PostView.card
                    //                         : PostView.classic,
                    //                     post: cubit.posts[index],
                    //                   ),
                    //                   itemCount: cubit.posts.length,
                    //                   shrinkWrap: true,
                    //                 ),
                    //               );
                    //             },
                    //           );
                    //         },
                    //       ),
                    (cubit.posts.isEmpty)
                        ? Container(
                            height: 60.h,
                            color: ColorManager.darkGrey,
                            child: Center(
                                child: Text('The queue is clean!',
                                    style: TextStyle(
                                        color: ColorManager.eggshellWhite,
                                        fontSize: 12.sp))))
                        : BlocConsumer<PostNotifierCubit, PostNotifierState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: ((context, index) {
                                    return PostWidget(
                                        post: PostModel(title: 'HElloooo'));
                                  }));
                            },
                          ),
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
