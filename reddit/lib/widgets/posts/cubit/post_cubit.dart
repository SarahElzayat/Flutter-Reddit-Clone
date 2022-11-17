/// this defines the Cubit that controls the state of each Post individually
/// date: 16/11/2022
/// @Author: Ahmed Atta

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/networks/dio_helper.dart';
import '../../../data/post_model/post_model.dart';
import 'post_cubit_state.dart';

class PostCubit extends Cubit<PostCubitState> {
  PostModel currentPost;
  PostCubit(this.currentPost) : super(PostCubitInitial());

  /// this is used to get an instance of the post cubit
  static PostCubit get(context) => BlocProvider.of(context);

  /// this function is used to vote on a post
  /// @param [direction] the direction of the wanted vote
  void vote(int direction) {
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

      emit(PostCubitvoted());
    }).catchError((error) {
      emit(PostCubitvotedError());
    });
  }
}
