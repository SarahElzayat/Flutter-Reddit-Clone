import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/helpers/enums.dart';
import '../../cubit/user_profile/cubit/user_profile_cubit.dart';
import '../../screens/posts/post_screen.dart';
import '../comments/comment.dart';

class UserProfileComments extends StatefulWidget {
  const UserProfileComments({Key? key}) : super(key: key);

  @override
  State<UserProfileComments> createState() => _UserProfileCommentsState();
}

class _UserProfileCommentsState extends State<UserProfileComments> {
  // int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileCubit = UserProfileCubit.get(context);
    final navigator = Navigator.of(context);

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                Future.sync(() => userProfileCubit.commentController.refresh()),
            child: PagedListView<String?, Map<String, dynamic>>(
              pagingController: userProfileCubit.commentController,
              builderDelegate: PagedChildBuilderDelegate<Map<String, dynamic>>(
                itemBuilder: (context, item, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: () {
                      navigator.push(MaterialPageRoute(
                        builder: (context) => PostScreen(
                          post: item['post'],
                        ),
                      ));
                    },
                    child: Comment(
                      viewType: CommentView.inSubreddits,
                      post: item['post'],
                      comment: item['comment'],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
