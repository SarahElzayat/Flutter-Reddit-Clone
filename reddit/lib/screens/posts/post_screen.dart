/// The Main Post Screen with the Comments
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_cubit.dart';
import 'package:reddit/screens/posts/post_screen_cubit/post_screen_state.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../cubit/post_notifier/post_notifier_state.dart';
import '../../data/post_model/post_model.dart';
import '../../widgets/comments/comment.dart';
import '../../widgets/posts/dropdown_list.dart';
import '../../widgets/posts/post_upper_bar.dart';
import '../comments/add_comment_screen.dart';

/// The Screen that displays the indvidual Posts
///
/// it will contain the [PostWidget] and the Comments
class PostScreen extends StatelessWidget {
  static const String routeName = 'post_screen';
  const PostScreen({
    super.key,
    required this.post,
    this.upperRowType = ShowingOtions.both,
  });

  /// The post to be displayed
  final PostModel post;

  /// if the single or a detailed row should be shown in the upper part of the post
  ///
  /// it's passed because the post don't require the subreddit to be shown in
  /// the sunreddit screen for example
  final ShowingOtions upperRowType;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostAndCommentActionsCubit(
            post: post,
          ),
        ),
        BlocProvider(
          create: (context) => PostScreenCubit(
            post: post,
          )..getCommentsOfPost(limit: 10),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(post.title ?? ''),
          actions: [
            BlocBuilder<PostNotifierCubit, PostNotifierState>(
              builder: (context, state) {
                return DropDownList(
                  // key: const Key('dropDownList-button'),
                  post: post,
                  itemClass: ItemsClass.posts,
                  outsideScreen: false,
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<PostScreenCubit, PostScreenState>(
          listener: (context, state) {
            if (state is CommentsLoadingMore) {
              Logger().i('loading more comments');
              PostScreenCubit.get(context).getCommentsOfPost(after: true);
            }
          },
          builder: (context, state) {
            var screenCubit = PostScreenCubit.get(context);
            bool locked = screenCubit.post.moderation?.lock ?? false;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: screenCubit.scrollController,
                    child: BlocConsumer<PostNotifierCubit, PostNotifierState>(
                      listener: (context, state) {
                        if (state is CommentsLoadingMore) {
                          Logger().i('loading more comments');
                          screenCubit.getCommentsOfPost(after: true);
                        }

                        if (state is PostDeleted) {
                          Navigator.of(context).pop();
                        }
                        if (state is CommentDeleted) {
                          screenCubit.deleteComment(state.id);
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            PostWidget(
                              post: post,
                              outsideScreen: false,
                              upperRowType: upperRowType,
                            ),
                            const SizedBox(height: 2),
                            ..._getCommentsList(screenCubit.comments),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // a container that when tabbed opens the edit comment screen
                if (!locked || (screenCubit.post.inYourSubreddit ?? false))
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => AddCommentScreen(
                          post: post,
                        ),
                      ))
                          .then((value) {
                        if (value != null && value) {
                          screenCubit.getCommentsOfPost();
                        }
                      });
                    },
                    child: Container(
                      color: ColorManager.betterDarkGrey,
                      height: 5.h,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Text(
                            'Add a comment',
                            style: TextStyle(color: ColorManager.lightGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  _getCommentsList(List<CommentModel> l) {
    return l
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
              child: Comment(
                key: ValueKey(e.id),
                post: post,
                comment: e,
              ),
            ))
        .toList();
  }
}
