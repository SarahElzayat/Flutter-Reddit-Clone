import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/mocks/functions.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/networks/dio_helper.dart';

import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostModel post;
  PostCubit(this.post) : super(PostsInitial());

  static PostCubit get(context) => BlocProvider.of(context);

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
  /// @param [postId] the id of post to be voted on
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

    return mockDio.post('$base/vote', data: {
      'id': post.id,
      'direction': newDir,
      'type': 'post',
    }).then((value) {
      post.votingType = (post.votingType ?? 0) + direction;
      post.votes = (post.votes ?? 0) + direction;
      emit(PostsVoted());
    }).catchError((error) {
      emit(PostsVotedError());
    });
  }

  Future save() {
    return mockDio.post(
      '$base/save',
      data: {
        'id': post.id,
      },
    ).then((value) {
      print(post.saved);
      post.saved = !post.saved!;
      emit(PostsSaved());
    }).catchError((error) {
      emit(PostsSavedError());
    });
  }

  Future hide() {
    return mockDio.post(
      '$base/hide',
      data: {
        'id': post.id,
      },
    ).then((value) => print(value.data));
  }

  Future blockUser() {
    return mockDio.post(
      '$base/block',
      data: {
        'id': post.id,
      },
    ).then((value) => print(value.data));
  }

  Future delete() {
    return mockDio.post(
      '$base/delete',
      data: {
        'id': post.id,
      },
    ).then((value) => print(value.data));
  }

  int getVotingType() {
    return post.votingType ?? 0;
  }

  int getVotesCount() {
    return post.votes ?? 0;
  }
}