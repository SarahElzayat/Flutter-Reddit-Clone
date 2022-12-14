/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is the screen for the people results of the main search
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/search_components/profile_result_container.dart';
import 'package:reddit/data/search/search_result_profile_model.dart';
import 'package:reddit/screens/search/cubit/search_cubit.dart';

import '../../components/helpers/color_manager.dart';

class ResultsUsers extends StatefulWidget {
  const ResultsUsers({super.key});

  @override
  State<ResultsUsers> createState() => _ResultsUsersState();
}

class _ResultsUsersState extends State<ResultsUsers> {
  final _scrollController = ScrollController();
  List<SearchResultProfileModel> users = [];
  void _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      SearchCubit.get(context).getUsers(loadMore: true, after: true);
    }
  }

  @override
  void initState() {
    SearchCubit.get(context).getUsers();
    // cubit.users =
    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit = SearchCubit.get(context);
    // cubit.users = cubit.cubit.users;

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
          builder: (context) {
            return cubit.users.isEmpty
                ? Center(
                    child: Text(
                      'Wow, such empty',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    // itemExtent: 400,
                    controller: _scrollController,
                    itemCount: cubit.users.length, //cubit.cubit.users.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => IntrinsicHeight(
                          child: ProfileResultContainer(
                            model: cubit.users[index],
                          ),
                        ));
          },
        );
      },
    );
  }
}
