import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../data/post_model/post_model.dart';
import '../../../data/settings/settings_models/user_settings.dart';
import '../../../data/subreddit/subreddit_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../shared/local/shared_preferences.dart';
import '../../../components/snack_bar.dart';
import '../../../data/subreddit/moderators_model.dart';
import '../../../screens/subreddit/subreddit_screen.dart';
part 'subreddit_state.dart';

class SubredditCubit extends Cubit<SubredditState> {
  SubredditCubit() : super(SubredditInitial());

  static SubredditCubit get(context) => BlocProvider.of(context);

  SubredditModel? subreddit;
  late String subredditName;
  late ModeratorModel moderators;
  List<PostModel> posts = [];
  late PagingController<String?, PostModel> pagingController;

  int selectedIndex = 0;

  void setSubredditName(BuildContext context, String name,
      {bool replace = false}) async {
    Map<String, String> query = {'subreddit': name};
    await DioHelper.getData(path: '$subredditInfo/$name', query: query)
        .then((value) {
      if (value.statusCode == 200) {
        // logger.wtf('Subreddit Info ====>');
        // logger.wtf(value.data);
        subreddit = SubredditModel.fromJson(value.data);
        subredditName = name;
        if (subreddit!.isMember == null) return;

        // emit(subredditChange());
      }
    }).catchError((error) {
      print('Error In Get Subreddit Info : $error');
      return;
    });

    print('Get Moderators');

    await DioHelper.getData(path: '/r/$name/about/moderators', query: {
      'subreddit': name,
    }).then((value) {
      if (value.statusCode == 200) {
        print('Success');
        print(value.data);
        moderators = ModeratorModel.fromJson(value.data);
        print('convert to mod model');
        if (!replace)
          Navigator.of(context).pushNamed(Subreddit.routeName);
        else
          Navigator.of(context).pushReplacementNamed(Subreddit.routeName);

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
        sentToken: token,
        path: leaveSubreddit,
        data: {'subredditName': subredditName}).then((value) {
      if (value.statusCode == 200) {
        print('Leaved Successfully');
        subreddit!.isMember = false;
        emit(leaveSubredditState());
      }
    }).catchError((error) {
      print('Error In Leave Subreddit : $error');
    });
  }

  void joinCommunity() {
    String token = CacheHelper.getData(key: 'token');
    DioHelper.postData(
        sentToken: token,
        path: joinSubreddit,
        data: {'subredditId': subreddit!.subredditId}).then((value) {
      if (value.statusCode == 200) {
        print('joined Successfully');
        subreddit!.isMember = true;
        emit(joinSubredditState());
      }
    }).catchError((error) {
      print('Error In Leave Subreddit : $error');
    });
  }

  void fetchPosts({String? after, required String sortBy}) {
    final query = {'after': after, 'subreddit': subredditName};
    print('URL : /r/$subredditName/$sortBy');
    print(query);
    DioHelper.getData(path: '/r/$subredditName/$sortBy', query: query)
        .then((value) {
      if (value.statusCode == 200) {
        List<PostModel> fetchedPosts = [];
        for (int i = 0; i < value.data['children'].length; i++) {
          // logger.wtf(i);
          final post = (PostModel.fromJsonwithData(value.data['children'][i]));
          fetchedPosts.add(post);
          print(i);
          print(post.title);
        }
        print(value.data['after'] as String);
        if (value.data['after'] as String == '') {
          pagingController.appendLastPage(fetchedPosts);
        } else {
          pagingController.appendPage(
              fetchedPosts, value.data['after'] as String);
        }
      }
    }).catchError((error) {
      print('Error In Fetch Posts ==> $error');
    });
  }
}
