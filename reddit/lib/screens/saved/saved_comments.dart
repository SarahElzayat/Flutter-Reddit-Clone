import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/saved_components/saved_comment_container.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';

import '../../components/helpers/color_manager.dart';
import '../../data/post_model/post_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import '../../widgets/posts/post_widget.dart';

class SavedCommentsScreen extends StatefulWidget {
  const SavedCommentsScreen({super.key});

  @override
  State<SavedCommentsScreen> createState() => _SavedCommentsScreenState();
}

class _SavedCommentsScreenState extends State<SavedCommentsScreen> {
  final _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      AppCubit.get(context)
          .getSaved(isComments: true, loadMore: true, after: true);
    }
  }

  @override
  void initState() {
    AppCubit.get(context).getSaved(isComments: true);
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! LoadedResultsState || state is! LoadedSavedState,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: ColorManager.blue,
            ),
          ),
          builder: (context) => cubit.savedCommentsList.isEmpty
              ? Center(
                  child: Text(
                    'Wow, such empty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: cubit.savedCommentsList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SavedCommentContainer(
                            model: cubit.savedCommentsList[index]),
                      )),
        );
      },
    );
  }
}
