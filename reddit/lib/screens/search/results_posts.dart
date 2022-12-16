/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the posts results of the main search
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';
import 'package:reddit/widgets/posts/post_upper_bar.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

import '../../Components/Helpers/color_manager.dart';

class ResultsPosts extends StatefulWidget {
  const ResultsPosts({super.key});

  @override
  State<ResultsPosts> createState() => _ResultsPostsState();
}

class _ResultsPostsState extends State<ResultsPosts> {
  final _scrollController = ScrollController();
  // List<PostModel> posts = [];
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      SearchCubit.get(context).getPosts(loadMore: true, after: true);
    }
  }

  @override
  void initState() {
    SearchCubit.get(context).getPosts();
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SearchCubit cubit = SearchCubit.get(context);
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              state is! LoadedResultsState || state is! LoadedMoreResultsState,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: ColorManager.blue,
            ),
          ),
          builder: (context) => cubit.posts.isEmpty
              ? Center(
                  child: Text(
                    'Wow, such empty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: cubit.posts.length,
                  itemBuilder: (context, index) => PostWidget(
                      key: Key(cubit.posts[index].id.toString()),
                      upperRowType: cubit.posts[index].inYourSubreddit == null
                          ? ShowingOtions.onlyUser
                          : ShowingOtions.both,
                      // TODO check this
                      // upperRowType: ShowingOtions.onlyUser,
                      post: cubit.posts[index],
                      postView: PostView.classic),
                ),
        );
      },
    );
  }
}
