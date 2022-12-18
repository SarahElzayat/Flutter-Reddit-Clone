/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the comments results of the main search
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

import '../../components/helpers/color_manager.dart';
import 'cubit/search_cubit.dart';

class ResultsComments extends StatefulWidget {
  const ResultsComments({super.key});

  @override
  State<ResultsComments> createState() => _ResultsCommentsState();
}

class _ResultsCommentsState extends State<ResultsComments> {
  final _scrollController = ScrollController();
  List<CommentModel> comments = [];
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      SearchCubit.get(context).getComments(loadMore: true, after: true);
    }
  }

  @override
  void initState() {
    SearchCubit.get(context).getComments();
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SearchCubit cubit = SearchCubit.get(context); //..getComments();
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:
              state is! LoadedResultsState || state is! LoadedMoreResultsState,
          fallback: (context) => const Center(
              child: CircularProgressIndicator(
            color: ColorManager.blue,
          )),
          builder: (context) => cubit.comments.isEmpty
              ? Center(
                  child: Text(
                    'Wow, such empty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              // :Placeholder()
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: cubit.comments.length,
                  itemBuilder: (context, index) => PostWidget(
                    post: cubit.commentsPosts[index],
                    comment: cubit.comments[index],
                    postView: PostView.withCommentsInSearch,
                  ),
                ),
        );
      },
    );
  }
}
