import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Data/post_model/post_model.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/networks/dio_helper.dart';

import 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());

  static PostsCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  Map<String, PostModel> postsMap = {};

  void getPostsForHome() async {
    emit(PostsLoading());
    DioHelper.getData(path: '$base/posts').then((value) {
      posts = [];
      postsMap = {};
      value.data.forEach((element) {
        PostModel post = PostModel.fromJson(element);
        posts.add(post);
        postsMap[post.id!] = post;
      });
      emit(PostsLoaded());
    }).catchError((error) {
      emit(PostsError());
    });
  }

  /// this function is used to vote on a post
  /// @param [direction] the direction of the wanted vote
  /// @param [postId] the id of post to be voted on
  void vote({
    required int direction,
    required String postId,
  }) {
    PostModel currentPost = postsMap[postId]!;
    int postState = currentPost.votingType ?? 0;
    if (postState == direction) {
      // clicked the same button again
      direction = -direction;
    } else if (postState == -direction) {
      // clicked the opposite button
      direction = direction * 2;
    }
    int newDir = postState + direction;

    DioHelper.postData(path: '$base/vote', data: {
      'id': currentPost.id,
      'direction': newDir,
      'type': 'post',
    }).then((value) {
      currentPost.votingType = (currentPost.votingType ?? 0) + direction;
      currentPost.votes = (currentPost.votes ?? 0) + direction;
      emit(PostsVoted());
    }).catchError((error) {
      emit(PostsVotedError());
    });
  }
}
