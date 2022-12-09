/// The post cubit that handles the post state independently
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/mocks/mock_functions.dart';
import 'package:reddit/data/post_model/post_model.dart';

import '../../../networks/constant_end_points.dart';
import 'post_state.dart';

class PostAndCommentActionsCubit extends Cubit<PostState> {
  final PostModel post;
  PostAndCommentActionsCubit({required this.post}) : super(PostsInitial());

  static PostAndCommentActionsCubit get(context) => BlocProvider.of(context);

  // void getPostsForHome() async {
  //   mockDio.get('$base/posts').then((value) {
  //     posts = [];
  //     postsMap = {};
  //     value.data.forEach((element) {
  //       PostModel post = PostModel.fromJson(element);
  //       posts.add(post);
  //       postsMap[post.id!] = post;
  //     });
  //     emit(PostsLoaded());
  //   }).catchError((error) {
  //     debugPrint('error in getPosts: $error');
  //     emit(PostsError());
  //   });

  //   emit(PostsLoading());
  // }

  /// this function is used to vote on a post
  /// @param [direction] the direction of the wanted vote
  Future vote({
    required int direction,
  }) {
    int postState = post.votingType ?? 0;
    if (postState == direction) {
      // clicked the same button again
      direction = -direction;
    } else if (postState == -direction) {
      // clicked the opposite button
      direction = direction * 2;
    }
    int newDir = postState + direction;

    return mockDio.post('$baseUrl/vote', data: {
      'id': post.id,
      'direction': newDir,
      'type': 'post',
    }
        // return DioHelper.postData(
        //   path: '/vote',
        //   data: {
        //     'id': post.id,
        //     'direction': newDir,
        //     'type': 'post',
        //   },
        //   token: token,
        ).then((value) {
      if (value.statusCode == 200) {
        post.votingType = (post.votingType ?? 0) + direction;
        post.votes = (post.votes ?? 0) + direction;
        emit(PostsVoted());
      } else {
        emit(PostsVotedError());
      }
    }).catchError((error) {
      print(error);
      emit(PostsVotedError(error: error));
    });
  }

  /// this function is used to vote on a post
  Future save() {
    return mockDio.post(
      '$baseUrl/save',
      data: {
        'id': post.id,
      },
    ).then((value) {
      print(post.saved);
      post.saved = !post.saved!;
      emit(PostsSaved());
    }).catchError((error) {
      emit(PostsVotedError(error: error));
    });
  }

  /// this function is used to hide a post
  Future hide() {
    return mockDio.post(
      '$baseUrl/hide',
      data: {
        'id': post.id,
      },
    ).then((value) => print(value.data));
  }

  /// this function is used to block the author of a post
  Future blockUser() {
    return mockDio.post(
      '$baseUrl/block-user',
      data: {
        'id': post.id,
      },
    ).then((value) => print(value.data));
  }

  /// this function is used to delete a post
  Future delete() {
    return mockDio.post(
      '$baseUrl/delete',
      data: {
        'id': post.id,
      },
    ).then((value) => print(value.data));
  }

  /// gets the voting type of the post (up, down ,..)
  int getVotingType() {
    return post.votingType ?? 0;
  }

  /// gets the number of votes of the post
  int getVotesCount() {
    return post.votes ?? 0;
  }

  static final List<String> labels = ['Best', 'Top', 'New', 'Old'];
  static final List<IconData> icons = [
    Icons.rocket_outlined,
    Icons.star_border_outlined,
    Icons.new_releases_outlined,
    Icons.access_time_outlined,
  ];

  static final Map<String, IconData> sortIcons = {
    labels[0]: icons[0],
    labels[1]: icons[1],
    labels[2]: icons[2],
    labels[3]: icons[3],
  };

  String selectedItem = 'Best';
  IconData getSelectedIcon() {
    return sortIcons[selectedItem]!;
  }

  void changeSortType(String item) {
    selectedItem = item;
    emit(CommentsSortTypeChanged());
  }

  bool showModTools = false;
  void toggleModTools() {
    showModTools = !showModTools;
    emit(CommentsModToolsToggled());
  }
}
