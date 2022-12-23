/// @author Ahmed Atta
/// @date 9/11/2022

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reddit/components/back_to_top_button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/functions/post_functions.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_cubit.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_state.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_state.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/home_app_bar.dart';
import '../../components/snack_bar.dart';
import '../../data/comment/comment_model.dart';
import '../../data/post_model/post_model.dart';
import '../../widgets/comments/comment_web.dart';
import '../comments/add_comment_web.dart';

class PostScreenWeb extends StatelessWidget {
  PostScreenWeb({
    super.key,
    required this.post,
  });

  final PostModel post;

  final ScrollController scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostScreenCubit(
            post: post,
          )
            ..getCommentsOfPost()
            ..getPostDetails(),
        ),
        BlocProvider(
          create: (context) => PostAndCommentActionsCubit(post: post)
            ..getSubDetails()
            ..getRules(),
        ),
      ],
      child: BlocConsumer<PostScreenCubit, PostScreenState>(
        listener: (context, state) {
          if (state is CommentsError) {
            ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
              message: state.error.toString(),
              error: true,
            ));
          }

          if (state is CommentsLoadingMore) {
            PostScreenCubit.get(context).getCommentsOfPost(after: true);
          }
        },
        builder: (context, state) {
          final screenCubit = PostScreenCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            appBar: kIsWeb ? homeAppBar(context, 0) : null,
            floatingActionButton: kIsWeb
                ? BackToTopButton(
                    scrollController: screenCubit.scrollController)
                : null,
            drawer: kIsWeb ? const LeftDrawer() : null,
            endDrawer: kIsWeb ? const RightDrawer() : null,
            body: SingleChildScrollView(
              controller: screenCubit.scrollController, //set controller

              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PostWidget(
                              post: post,
                              outsideScreen: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // quil editor for web
                            AddCommentWeb(
                              post: post,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: PostScreenCubit.labels
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: screenCubit.selectedItem,
                                onChanged: (value) {
                                  screenCubit.changeSortType(value!);
                                },
                              ),
                            ),
                            ..._getCommentsList(screenCubit.comments),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      SizedBox(
                        width: 20.w,
                        child: Column(
                          children: [
                            BlocConsumer<PostAndCommentActionsCubit,
                                PostActionsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                final actionsCubit =
                                    PostAndCommentActionsCubit.get(context);
                                return actionsCubit.subreddit == null
                                    ? Container()
                                    : Container(
                                        width: 20.w,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: ColorManager.blue,
                                            width: 2,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                SubredditCubit.get(context)
                                                    .setSubredditName(
                                                        context,
                                                        actionsCubit.subreddit
                                                                ?.title ??
                                                            '');
                                              },
                                              child: Row(
                                                children: [
                                                  subredditAvatar(
                                                      imageUrl: actionsCubit
                                                              .subreddit
                                                              ?.picture ??
                                                          ''),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(actionsCubit
                                                          .subreddit?.title ??
                                                      '')
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                'Created At : ${DateFormat.yMMMMd('en_US').format(DateTime.tryParse(actionsCubit.subreddit?.dateOfCreation ?? '') ?? DateTime.now())}'),
                                            const Divider(
                                              color: Colors.grey,
                                              height: 10,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'Subscribers : ${actionsCubit.subreddit?.members ?? ''}',
                                            ),
                                            const Divider(
                                              color: Colors.grey,
                                              height: 10,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if ((actionsCubit.subreddit
                                                          ?.isMember ??
                                                      false)) {
                                                    actionsCubit
                                                        .leaveCommunity();
                                                  } else {
                                                    actionsCubit
                                                        .joinCommunity();
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: ColorManager
                                                      .betterDarkGrey,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                child: Text((actionsCubit
                                                            .subreddit
                                                            ?.isMember ??
                                                        false)
                                                    ? 'Joined'
                                                    : 'Join')),
                                          ],
                                        ),
                                      );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<PostAndCommentActionsCubit,
                                PostActionsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                final actionsCubit =
                                    PostAndCommentActionsCubit.get(context);
                                return (actionsCubit.rules?.rules?.isEmpty ??
                                            true) ==
                                        true
                                    ? Container()
                                    : Container(
                                        width: 20.w,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: ColorManager.blue,
                                            width: 2,
                                          ),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemBuilder: (context, index) {
                                            return Text(
                                              actionsCubit.rules!.rules![index]
                                                  .description!,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            );
                                          },
                                          itemCount: actionsCubit
                                                  .rules!.rules?.length ??
                                              0,
                                        ),
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _getCommentsList(List<CommentModel> l) {
    return l
        .map((e) => Padding(
              key: Key(e.id!),
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
              child: CommentWeb(
                post: post,
                comment: e,
              ),
            ))
        .toList();
  }
}
