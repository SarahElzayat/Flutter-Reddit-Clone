import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:reddit/data/comment/comment_model.dart';
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

  late PagingController<String?, PostModel> postController;
  late PagingController<String?, Map<String, dynamic>> commentController;

  void setUsername(String usernamePass, {bool navigate = true}) {
    print('User Name : $usernamePass');
    print(token);
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
    print(token);
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
          print(post.id);
        }
        print(value.data['after'] as String);
        if (value.data['after'] as String == '') {
          postController.appendLastPage(fetchedPosts);
        } else {
          postController.appendPage(
              fetchedPosts, value.data['after'] as String);
        }
      }
    }).catchError((error) {
      print('Error In Fetch Posts ==> $error');
    });
  }

  void fetchComments({String? after}) {
    final query = {'after': after, 'username': username};
    print('URL : /user/$username/comments');
    print(query);
    DioHelper.getData(path: '/user/$username/comments', query: query)
        .then((value) {
      if (value.statusCode == 200) {
        List<Map<String, dynamic>> fetchedPosts = [];
        for (int i = 0; i < value.data['children'].length; i++) {
          // logger.wtf(i);
          final post =
              (PostModel.fromJson(value.data['children'][i]['data']['post']));
          print(value.data['children'][i]['data']['comments']);
          for (int j = 0;
              j < value.data['children'][i]['data']['comments'].length;
              j++) {
            final comment = (CommentModel.fromJson(
                value.data['children'][i]['data']['comments'][j]));
            var item = {
              'post': post,
              'comment': comment,
            };
            fetchedPosts.add(item);
          }

          // // fetchedPosts.add(post);
          // var data = {
          //   'post': post,
          //   'comment': comment,
          // };
          // fetchedPosts.add(data);
          // print(i);
          // print(post.title);
        }
        print(value.data['after'] as String);
        if (value.data['after'] as String == '') {
          commentController.appendLastPage(fetchedPosts);
        } else {
          commentController.appendPage(
              fetchedPosts, value.data['after'] as String);
        }
      }
    }).catchError((error) {
      print('Error In Fetch comments ==> $error');
    });
  }

  showPopupUserWidget(BuildContext context, String username) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              CircleAvatar(
                radius: 30,
                child: Image.asset(
                  'assets/images/Logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'u/${username}',
                style: TextStyle(fontSize: 16),
              ),
              ListTile(
                title: Text(
                  '${userData!.karma}',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text('Karma'),
              ),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.person),
                      Text('  View profile')
                    ],
                  )),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.block_flipped),
                      Text('  Block Account')
                    ],
                  )),
              TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(Icons.mail_outline_outlined),
                      Text('  Invite to Community')
                    ],
                  )),
            ]),
          );
        }));
  }
}
