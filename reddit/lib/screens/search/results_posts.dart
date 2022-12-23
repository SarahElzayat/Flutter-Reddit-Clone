/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the posts results of the main search

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/helpers/enums.dart';
import '../../components/search_components/profile_result_container.dart';
import '../../components/search_components/subreddit_results_container.dart';
import '../../components/snack_bar.dart';
import '../../cubit/user_profile/cubit/user_profile_cubit.dart';
import '../../screens/search/cubit/search_cubit.dart';
import '../../widgets/posts/post_upper_bar.dart';
import '../../widgets/posts/post_widget.dart';

class ResultsPosts extends StatefulWidget {
  /// bool to check if the search is called inside a subreddit or
  /// not to preview the results accordingly
  final bool isSubreddit;

  const ResultsPosts({super.key, this.isSubreddit = false});

  @override
  State<ResultsPosts> createState() => _ResultsPostsState();
}

class _ResultsPostsState extends State<ResultsPosts> {
  final _scrollController = ScrollController();

  /// scroll listener to load more at the bottom of the screen
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      SearchCubit.get(context).getPosts(loadMore: true, after: true);
    }
  }

  @override
  void initState() {
    SearchCubit.get(context).getPosts();

    if (kIsWeb) {
      SearchCubit.get(context).getUsers();
      SearchCubit.get(context).getSubbreddits();
    }
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SearchCubit cubit = SearchCubit.get(context);
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is NoMoreResultsToLoadState) {
          ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'No more results!',
            error: false,
          ));
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment:
              kIsWeb ? MainAxisAlignment.end : MainAxisAlignment.center,
          crossAxisAlignment:
              kIsWeb ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (cubit.posts.isEmpty && kIsWeb)
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.3,
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Text(
                  'Wow, such empty',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            cubit.posts.isEmpty && !kIsWeb
                ? Center(
                    child: Text(
                      'Wow, such empty',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: kIsWeb
                              ? MediaQuery.of(context).size.width * 0.1
                              : 0),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: cubit.posts.length,
                        itemBuilder: (context, index) => PostWidget(
                            key: Key(cubit.posts[index].id.toString()),
                            inSearch: true,
                            upperRowType:
                                cubit.posts[index].inYourSubreddit == null
                                    ? ShowingOtions.onlyUser
                                    : ShowingOtions.both,
                            post: cubit.posts[index],
                            postView: PostView.card),
                      ),
                    ),
                  ),
            if (kIsWeb && !widget.isSubreddit)
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      decoration: BoxDecoration(
                          color: ColorManager.darkGrey,
                          border: Border.all(color: ColorManager.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 8),
                            child: Text(
                              'People',
                              style: TextStyle(
                                  color: ColorManager.eggshellWhite,
                                  fontSize: 20),
                            ),
                          ),
                          cubit.users.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('No people found'),
                                )
                              : ListView.builder(
                                  itemCount: cubit.users.length > 3
                                      ? 3
                                      : cubit.users
                                          .length, //cubit.cubit.users.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () =>
                                            UserProfileCubit.get(context)
                                                .showPopupUserWidget(
                                                    context,
                                                    cubit.users[index].data!
                                                        .username!),
                                        child: IntrinsicHeight(
                                          child: ProfileResultContainer(
                                            model: cubit.users[index],
                                          ),
                                        ),
                                      )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      decoration: BoxDecoration(
                          color: ColorManager.darkGrey,
                          border: Border.all(color: ColorManager.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0, left: 8),
                            child: Text(
                              'Communities',
                              style: TextStyle(
                                  color: ColorManager.eggshellWhite,
                                  fontSize: 20),
                            ),
                          ),
                          cubit.subbreddits.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('No communitites found'),
                                )
                              : ListView.builder(
                                  // controller: _scrollController,
                                  itemCount: cubit.subbreddits.length > 3
                                      ? 3
                                      : cubit.subbreddits.length,
                                  // itemCount: cubit.subbreddits.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      IntrinsicHeight(
                                        child: SubredditResultsContainer(
                                          model: cubit.subbreddits[index],
                                        ),
                                      )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
