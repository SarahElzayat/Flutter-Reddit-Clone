/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the posts results of the main search
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

class ResultsPosts extends StatefulWidget {
  const ResultsPosts({super.key});

  @override
  State<ResultsPosts> createState() => _ResultsPostsState();
}

class _ResultsPostsState extends State<ResultsPosts> {
  @override
  Widget build(BuildContext context) {
    final SearchCubit cubit = SearchCubit.get(context)..getPosts();
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) => PostWidget(
              post: cubit.posts[index], postView: PostView.classic),
        );
      },
    );
  }
}
