import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meta/meta.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/settings/settings_models/user_settings.dart';
import 'package:reddit/data/user_profile.dart/about_user_model.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/user_profile/user_profile_screen.dart';

import '../../../constants/constants.dart';
import '../../../data/post_model/post_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../screens/moderation/user_management_screens/invite_moderator.dart';
import '../../../screens/moderation/user_management_screens/moderators.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());
  static UserProfileCubit get(context) => BlocProvider.of(context);
  AboutUserModel? userData;
  String? username;

  late PagingController<String?, PostModel> postController;
  late PagingController<String?, Map<String, dynamic>> commentController;

  Future<void> fetchUserData(String userName, {bool navigate = true}) async {
    await DioHelper.getData(
        path: '/user/$userName/about',
        query: {'username': userName}).then((value) {
      if (value.statusCode == 200) {
        username = userName;
        userData = AboutUserModel.fromJson(value.data);
        print('All Done');
        print(userData!.displayName);
        if (userData!.displayName == null || userData!.displayName == '') {
          userData!.displayName = username;
        }
        if (navigate)
          navigatorKey.currentState!.pushNamed(UserProfileScreen.routeName);
        // return true;
      }
    }).catchError((error) {
      print('Error in fetch user data ==> $error');
    });
  }

  void setUsername(String usernamePass, {bool navigate = true}) {
    print('User Name : $usernamePass');
    print(token);
    fetchUserData(usernamePass);
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

  followOrUnfollowUser(bool follow) {
    print('Follow $follow');
    DioHelper.postData(
        path: followUser,
        data: {'username': username, 'follow': follow}).then((value) {
      if (value.statusCode == 200) {
        print('Success');
        userData!.followed = !(userData!.followed!);
        emit(FollowOrUnfollowState());
      }
    }).catchError((error) {
      print(error);
    });
  }

  showPopupUserWidget(BuildContext context, String userName) async {
    await fetchUserData(userName, navigate: false);
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              CircleAvatar(
                radius: 30,
                child: (userData!.picture == null || userData!.picture == '')
                    ? Image.asset('assets/images/Logo.png', fit: BoxFit.cover)
                    : Image.network(
                        userData!.picture!,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'u/${userData!.displayName ?? userName}',
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
                  onPressed: () {
                    navigatorKey.currentState!
                        .pushNamed(UserProfileScreen.routeName);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.person),
                      Text('  View profile')
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    blockUser(context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.block_flipped),
                      Text('  Block Account')
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => Moderators())));
                  },
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

  void blockUser(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Block u/${userData!.displayName}',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'They won\'t be able to contact you or view your profile, posts, or commentst',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Button(
                        buttonHeight: 30,
                        buttonWidth: MediaQuery.of(context).size.width * 0.35,
                        onPressed: () async {
                          await DioHelper.postData(
                            path: '/block-user',
                            data: {
                              'block': true,
                              'username': username,
                            },
                          ).then((value) {
                            print('Blocked');
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                responseSnackBar(
                                    message:
                                        'The author of this post has been blocked',
                                    error: false));
                          }).catchError((error) {
                            error = error as DioError;
                            ScaffoldMessenger.of(context).showSnackBar(
                                responseSnackBar(
                                    message: 'An Error', error: true));
                          });
                        },
                        text: 'Block account',
                        backgroundColor: ColorManager.red,
                        splashColor: Color.fromARGB(100, 0, 0, 0),
                        textColor: ColorManager.white,
                      ),
                      Button(
                        buttonHeight: 30,
                        buttonWidth: MediaQuery.of(context).size.width * 0.25,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Cancel',
                        backgroundColor: Colors.transparent,
                        splashColor: Color.fromARGB(100, 0, 0, 0),
                        textColor: ColorManager.eggshellWhite,
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
