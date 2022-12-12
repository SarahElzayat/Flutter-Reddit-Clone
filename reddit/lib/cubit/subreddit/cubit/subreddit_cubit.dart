import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/subreddit/subreddit_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/moderation/user_management_screens/moderators.dart';

import '../../../screens/subreddit/subreddit_screen.dart';
import '../../../shared/local/shared_preferences.dart';

part 'subreddit_state.dart';

class SubredditCubit extends Cubit<SubredditState> {
  SubredditCubit() : super(SubredditInitial());

  SubredditModel? subreddit;
  Moderators? moderators;

  void setSubredditName(BuildContext context, String name) {
    Map<String, String> query = {'subreddit': name};
    DioHelper.getData(
            path: '$subredditInfo/$name',
            token: CacheHelper.getData(key: 'token'),
            query: query)
        .then((value) {
      if (value.statusCode == 200) {
        print('Subreddit Info ====>');
        print(value.data);
        subreddit = SubredditModel.fromJson(value.data);
        Navigator.of(context).pushNamed(Subreddit.routeName);
        // emit(subredditChange());
      }
    }).catchError((error) {
      print('Error In Get Subreddit Info : $error');
    });
  }
}
