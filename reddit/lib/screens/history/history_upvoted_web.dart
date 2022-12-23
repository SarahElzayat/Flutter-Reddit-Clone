import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/cubit/app_cubit/app_cubit.dart';

import '../../widgets/posts/post_upper_bar.dart';
import '../../widgets/posts/post_widget.dart';

class UpvotedHistoryWeb extends StatefulWidget {
  const UpvotedHistoryWeb({super.key});

  @override
  State<UpvotedHistoryWeb> createState() => _UpvotedHistoryWebState();
}

class _UpvotedHistoryWebState extends State<UpvotedHistoryWeb> {
    final ScrollController _scrollController = ScrollController();
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      AppCubit.get(context).getHistory(after: true, loadMore: true);
    }
  }

  @override
  void initState() {
    AppCubit.get(context).changeHistoryCategory(HistoyCategory.upvoted);

    _scrollController.addListener(_scrollListener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return 
         state is HistoryEmptyState
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: Center(
                        child: Text(
                          'Wow, such empty',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  :ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) => PostWidget(
            post: cubit.history[index],
            upperRowType: cubit.history[index].subreddit != null
                ? ShowingOtions.both
                : ShowingOtions.onlyUser,
          ),
          itemCount: cubit.history.length,
          shrinkWrap: true,
        );
      },
    );
  }
}
