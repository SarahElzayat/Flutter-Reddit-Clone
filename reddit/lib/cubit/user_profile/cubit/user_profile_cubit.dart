import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/user_profile.dart/about_user_model.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/user_profile/user_profile_screen.dart';

import '../../../constants/constants.dart';
import '../../../data/post_model/post_model.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  static UserProfileCubit get(context) => BlocProvider.of(context);
  AboutUserModel? userData;
  String? username;

  late PagingController<String?, PostModel> pagingController;

  void setUsername(String usernamePass, {bool navigate = true}) {
    print(username);
    DioHelper.getData(
        path: '/user/$usernamePass/about',
        query: {'username': usernamePass}).then((value) {
      if (value.statusCode == 200) {
        username = usernamePass;
        userData = AboutUserModel.fromJson(value.data);
        print('All Done');
        print(userData!.displayName);
        if (userData!.displayName == null || userData!.displayName == '') {
          userData!.displayName = username;
        }
        navigatorKey.currentState!.pushNamed(UserProfileScreen.routeName);
        // return true;
      }
    }).catchError((error) {
      print('Error in fetch user data ==> $error');
    });
  }

  void fetchPosts({String? after}) {
    final query = {'after': after, 'username': username};
    print('URL : /user/$username/posts');
    print(query);
    DioHelper.getData(path: '/user/$username/posts', query: query)
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
