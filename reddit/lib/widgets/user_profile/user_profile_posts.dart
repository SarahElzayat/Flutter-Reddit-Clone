import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../cubit/user_profile/cubit/user_profile_cubit.dart';
import '../../data/post_model/post_model.dart';
import '../posts/post_widget.dart';


/// Get User Posts
class UserProfilePosts extends StatefulWidget {
  UserProfilePosts({Key? key}) : super(key: key);

  @override
  State<UserProfilePosts> createState() => _UserProfilePostsState();
}

class _UserProfilePostsState extends State<UserProfilePosts> {
  // int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final userProfileCubit = UserProfileCubit.get(context);

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                Future.sync(() => userProfileCubit.postController.refresh()),
            child: PagedListView<String?, PostModel>(
              // physics: (kIsWeb) ? NeverScrollableScrollPhysics() : null,
              // shrinkWrap: (kIsWeb) ? true : false,
              pagingController: userProfileCubit.postController,
              builderDelegate: PagedChildBuilderDelegate<PostModel>(
                itemBuilder: (context, item, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: PostWidget(
                    insideProfiles: true,
                    post: item,
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
