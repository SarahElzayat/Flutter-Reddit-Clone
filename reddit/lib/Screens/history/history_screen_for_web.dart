///@author Sarah Elzayat

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

import '../../Components/Helpers/color_manager.dart';
import '../../cubit/app_cubit.dart';
import '../../widgets/posts/post_upper_bar.dart';

class HistoryScreenForWeb extends StatelessWidget {
  const HistoryScreenForWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context)..changeHistoryCategory(HistoyCategory.recent);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: homeAppBar(context, 0),
          body: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaterialButton(
                    onPressed: () => cubit.changeHistoryCategory(HistoyCategory.recent),
                    child: const Text('History'),
                  ),
                  MaterialButton(
                    onPressed: () => cubit.changeHistoryCategory(HistoyCategory.upvoted),
                    child: const Text('Upvoted'),
                  ),
                  MaterialButton(
                    onPressed: () => cubit.changeHistoryCategory(HistoyCategory.downvoted),
                    child: const Text('Downvoted'),
                  ),
                  MaterialButton(
                    onPressed: () => cubit.changeHistoryCategory(HistoyCategory.hidden),
                    child: const Text('Hiddden'),
                  ),
          
                ],
              ),
                  state is HistoryEmptyState?
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: Center(
                        child: Text(
                          'Wow, such empty',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ):
                  // if (cubit.history.isNotEmpty)
                    ConditionalBuilder(
                        condition: state is! LoadingHistoryState,
                        fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: ColorManager.blue,
                            )),
                        builder: (context) {
                          return ListView.builder(
                            itemBuilder: (context, index) => PostWidget(
                              post: cubit.history[index],
                              upperRowType:
                                  cubit.history[index].subreddit != null
                                      ? ShowingOtions.both
                                      : ShowingOtions.onlyUser,
                            ),
                            itemCount: cubit.history.length,
                            shrinkWrap: true,
                            // ),
                          );
                        })
            ]),
          ),
        );
      },
    );
  }
}
