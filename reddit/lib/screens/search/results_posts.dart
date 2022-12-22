/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the posts results of the main search
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/helpers/enums.dart';
import '../../components/snack_bar.dart';
import '../../screens/search/cubit/search_cubit.dart';
import '../../widgets/posts/post_upper_bar.dart';
import '../../widgets/posts/post_widget.dart';

class ResultsPosts extends StatefulWidget {
  const ResultsPosts({super.key});

  @override
  State<ResultsPosts> createState() => _ResultsPostsState();
}

class _ResultsPostsState extends State<ResultsPosts> {
  final _scrollController = ScrollController();
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
      listener: (context, state) {
        if (state is NoMoreResultsToLoadState) {
          ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'No more results!',
            error: false,
          ));
        }
      },
      builder: (context, state) {
        return cubit.posts.isEmpty
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
                    inSearch: true,
                    upperRowType: cubit.posts[index].inYourSubreddit == null
                        ? ShowingOtions.onlyUser
                        : ShowingOtions.both,
                    post: cubit.posts[index],
                    postView: PostView.card),
              );
      },
    );
  }
}
