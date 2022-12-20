/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen fpr the main home
///
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/back_to_top_button.dart';
import 'package:reddit/components/home_components/left_drawer.dart';
import 'package:reddit/components/home_components/right_drawer.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_cubit.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_state.dart';
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
    return BlocProvider(
      create: (context) => PostScreenCubit(
        post: post,
      )..getCommentsOfPost(),
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
                        height: 500,
                        width: 300,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.red,
                              height: 200,
                              width: 200,
                              child: Text(
                                'Communities near you',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: Colors.blue,
                              height: 200,
                              width: 200,
                              child: Text(
                                'Create post',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
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
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
              child: CommentWeb(
                key: Key(e.id!),
                post: post,
                comment: e,
              ),
            ))
        .toList();
  }
}
