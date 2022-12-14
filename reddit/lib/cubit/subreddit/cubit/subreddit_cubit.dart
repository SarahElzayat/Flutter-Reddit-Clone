import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/subreddit/subreddit_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../../data/subreddit/moderators_model.dart';
import '../../../data/subreddit/subreddit_model.dart';
import '../../../screens/subreddit/subreddit_screen.dart';
part 'subreddit_state.dart';

class SubredditCubit extends Cubit<SubredditState> {
  SubredditCubit() : super(SubredditInitial());

  static SubredditCubit get(context) => BlocProvider.of(context);

  late SubredditModel subreddit;
  late String subredditName;
  late ModeratorModel moderators;

  void setSubredditName(BuildContext context, String name) {
    Map<String, String> query = {'subreddit': name};
    DioHelper.getData(path: '$subredditInfo/$name', query: query).then((value) {
      if (value.statusCode == 200) {
        print('Subreddit Info ====>');
        print(value.data);
        subreddit = SubredditModel.fromJson(value.data);
        subredditName = name;
        if (subreddit.isMember == null) return;

        // emit(subredditChange());
      }
    }).catchError((error) {
      print('Error In Get Subreddit Info : $error');
      return;
    });

    print('Get Moderators');

    DioHelper.getData(path: '/r/$name/about/moderators', query: {
      'subreddit': name,
    }).then((value) {
      if (value.statusCode == 200) {
        print('Success');
        print(value.data);
        moderators = ModeratorModel.fromJson(value.data);
        print('convert to mod model');
        Navigator.of(context).pushNamed(Subreddit.routeName);
        print('navigate');
      }
    }).catchError((error) {
      print('Error in gettin moderators');
    });
  }

  void leaveCommunity() {
    print('In leave subreddit');
    String token = CacheHelper.getData(key: 'token');
    print('Token');
    print(token);
    DioHelper.postData(
        token: token,
        path: leaveSubreddit,
        data: {'subredditName': subredditName}).then((value) {
      if (value.statusCode == 200) {
        print('Leaved Successfully');
        subreddit.isMember = false;
        emit(leaveSubredditState());
      }
    }).catchError((error) {
      print('Error In Leave Subreddit : $error');
    });
  }

  void joinCommunity() {
    String token = CacheHelper.getData(key: 'token');
    DioHelper.postData(
        token: token,
        path: joinSubreddit,
        data: {'subredditId': subreddit.subredditId}).then((value) {
      if (value.statusCode == 200) {
        print('joined Successfully');
        subreddit.isMember = true;
        emit(joinSubredditState());
      }
    }).catchError((error) {
      print('Error In Leave Subreddit : $error');
    });
  }
}
