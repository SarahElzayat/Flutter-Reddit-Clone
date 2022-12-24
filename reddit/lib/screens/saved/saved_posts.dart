/// @author Sarah Elzayat
/// @description: the screen that shows the user's saved comeents
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/app_cubit/app_cubit.dart';

import '../../components/helpers/color_manager.dart';
import '../../components/helpers/enums.dart';
import '../../widgets/posts/post_upper_bar.dart';
import '../../widgets/posts/post_widget.dart';

class SavedPostsScreen extends StatefulWidget {
  const SavedPostsScreen({super.key});

  @override
  State<SavedPostsScreen> createState() => _SavedPostsScreenState();
}

class _SavedPostsScreenState extends State<SavedPostsScreen> {
  final _scrollController = ScrollController();

  ///  scroll listener to load more at the bottom of the screen
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      AppCubit.get(context)
          .getSaved(isPosts: true, loadMore: true, after: true);
    }
  }

  ///  the method that's callled on pull down to refresh
  Future<void> _onRefresh() async {
    setState(() {
      AppCubit.get(context).getSaved(isPosts: true);
    });
  }

  ///  initial state of the widget
  ///  loads posts on creation
  @override
  void initState() {
    AppCubit.get(context).getSaved(isPosts: true);
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
          builder: (context) => cubit.savedPostsList.isEmpty
              ? Center(
                  child: Text(
                    'Wow, such empty',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: cubit.savedPostsList.length,
                    itemBuilder: (context, index) => PostWidget(
                        key: Key(cubit.savedPostsList[index].id.toString()),
                        upperRowType:
                            cubit.savedPostsList[index].inYourSubreddit == null
                                ? ShowingOtions.onlyUser
                                : ShowingOtions.both,
                        post: cubit.savedPostsList[index],
                        postView: PostView.classic),
                  ),
                ),
        );
      },
    );
  }
}
