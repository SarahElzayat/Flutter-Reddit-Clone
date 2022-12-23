import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../constants/constants.dart';
import '../../../data/post_model/post_model.dart';
import '../../../data/settings/settings_models/user_settings.dart';
import '../../../data/subreddit/subreddit_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../shared/local/shared_preferences.dart';
import '../../../components/snack_bar.dart';
import '../../../data/subreddit/moderators_model.dart';
import '../../../screens/comments/add_comment_screen.dart';
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
    print(query);
    print('Set Subreddit');
    print(token);
    await DioHelper.getData(path: '$subredditInfo/$name', query: query)
        .then((value) {
      if (value.statusCode == 200) {
        subreddit = SubredditModel.fromJson(value.data);
        subredditName = name;
        if (subreddit!.isMember == null) return;

        if (subreddit!.type == 'private' && subreddit!.isMember == false) {
          ScaffoldMessenger.of(context).showSnackBar(
              responseSnackBar(message: 'Subreddit is Private', error: true));
          return;
        }

        if (CacheHelper.getData(key: 'nfsw') == false &&
            subreddit!.nsfw != null &&
            subreddit!.nsfw == true) {
          ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
              message: 'Subreddit is NSFW , Edit Setting', error: true));
          return;
        }
      }
    }).catchError((error) {
      return;
    });

    DioHelper.getData(path: '/r/$name/about/moderators', query: {
      'subreddit': name,
    }).then((value) {
      if (value.statusCode == 200) {
        moderators = ModeratorModel.fromJson(value.data);
        if (replace) {
          Navigator.of(context).pushReplacementNamed(Subreddit.routeName);
        } else {
          Navigator.of(context).pushNamed(Subreddit.routeName);
        }
      }
    }).catchError((error) {});
  }

  void leaveCommunity() {
    String token = CacheHelper.getData(key: 'token');
    DioHelper.postData(
        sentToken: token,
        path: leaveSubreddit,
        data: {'subredditName': subredditName}).then((value) {
      if (value.statusCode == 200) {
        subreddit!.isMember = false;
        emit(LeaveSubredditState());
      }
    }).catchError((error) {});
  }

  void joinCommunity() {
    String token = CacheHelper.getData(key: 'token');
    DioHelper.postData(
        sentToken: token,
        path: joinSubreddit,
        data: {'subredditId': subreddit!.subredditId}).then((value) {
      if (value.statusCode == 200) {
        subreddit!.isMember = true;
        emit(JoinSubredditState());
      }
    }).catchError((error) {});
  }

  void fetchPosts({String? after, required String sortBy}) {
    final query = {'after': after, 'subreddit': subredditName};
    DioHelper.getData(path: '/r/$subredditName/$sortBy', query: query)
        .then((value) {
      if (value.statusCode == 200) {
        List<PostModel> fetchedPosts = [];
        for (int i = 0; i < value.data['children'].length; i++) {
          // logger.wtf(i);
          final post = (PostModel.fromJsonwithData(value.data['children'][i]));
          fetchedPosts.add(post);
        }
        if (value.data['after'] as String == '') {
          pagingController.appendLastPage(fetchedPosts);
        } else {
          pagingController.appendPage(
              fetchedPosts, value.data['after'] as String);
        }
      }
    }).catchError((error) {});
  }
}
