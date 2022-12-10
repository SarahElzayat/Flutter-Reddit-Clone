/// The Main Post Screen with the Comments
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/temp_data/tmp_data.dart';
import 'package:reddit/widgets/posts/cubit/post_cubit.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../cubit/post_notifier/post_notifier_state.dart';
import '../../data/post_model/post_model.dart';
import '../../widgets/comments/comment.dart';
import '../../widgets/posts/cubit/post_state.dart';
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
    return BlocProvider(
      create: (context) => PostAndCommentActionsCubit(
        post: post,
      )..getCommentsOfPost(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(post.title!),
          actions: [
            BlocBuilder<PostNotifierCubit, PostNotifierState>(
              builder: (context, state) {
                return DropDownList(
                  key: const Key('dropDownList-button'),
                  postId: post.id!,
                  itemClass: (post.saved ?? true)
                      ? ItemsClass.publicSaved
                      : ItemsClass.public,
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<PostAndCommentActionsCubit, PostState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = PostAndCommentActionsCubit.get(context);
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        PostWidget(
                          post: post,
                          outsideScreen: false,
                          upperRowType: upperRowType,
                        ),
                        ..._getCommentsList(cubit.comments),
                      ],
                    ),
                  ),
                ),
                // a container that when tabbed opens the edit comment screen
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddCommentScreen(
                          post: post,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: ColorManager.betterDarkGrey,
                    height: 5.h,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
        .map((e) => Comment(
              post: post,
              comment: e,
            ))
        .toList();
  }
}
