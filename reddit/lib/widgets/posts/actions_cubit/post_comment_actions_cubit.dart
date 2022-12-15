/// The post cubit that handles the post state independently
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/helpers/mocks/mock_functions.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/functions/post_functions.dart';
import 'package:reddit/networks/dio_helper.dart';

import '../../../networks/constant_end_points.dart';
import 'post_comment_actions_state.dart';

Logger logger = Logger();

class PostAndCommentActionsCubit extends Cubit<PostState> {
  final PostModel post;
  final CommentModel? currentComment;
  final List<CommentModel> comments = [];

  PostAndCommentActionsCubit({
    required this.post,
    this.currentComment,
  }) : super(PostsInitial());

  static PostAndCommentActionsCubit get(context) => BlocProvider.of(context);

  /// this function is used to vote on a post
  /// @param [oldDir] the direction of the wanted vote
  Future vote({
    required int oldDir,
  }) {
    int postState = getModel.votingType ?? 0;
    int direction = oldDir;
    if (postState == oldDir) {
      // clicked the same button again
      direction = -oldDir;
    } else if (postState == -oldDir) {
      // clicked the opposite button
      direction = oldDir * 2;
    }

    // int newDir = postState + direction;
    Logger().d(token);
    return DioHelper.postData(
      path: '/vote',
      data: {
        'id': getModel.id,
        'direction': oldDir,
        'type': currentComment == null ? 'post' : 'comment',
      },
    ).then((value) {
      if (value.statusCode == 200) {
        getModel.votingType = (getModel.votingType ?? 0) + direction;
        getModel.votes = (getModel.votes ?? 0) + direction;
        emit(VotedSuccess());
      } else {
        emit(VotedError());
      }
    }).catchError((error) {
      error = error as DioError;
      debugPrint('error in vote: ${error.response?.data}');
      emit(VotedError(error: error));
    });
  }

  /// this function is used to vote on a post
  Future save() {
    bool isSaved = getModel.saved ?? false;
    String path = isSaved ? '/unsave' : '/save';
    return DioHelper.postData(
      path: path,
      data: {
        'id': post.id,
        'type': isPost ? 'post' : 'comment',
      },
    ).then((value) {
      getModel.saved = !getModel.saved!;
      emit(SavedChangedState());
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response?.data);
      emit(OpError(error: error.response?.data['error'] ?? ''));
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

  dynamic get getModel => currentComment ?? post;
  bool get isPost => currentComment == null;

  /// gets the voting type of the post (up, down ,..)
  int getVotingType() {
    return getModel.votingType ?? 0;
  }

  /// gets the number of votes of the post
  int getVotesCount() {
    return getModel.votes ?? 0;
  }

  bool showModTools = false;
  void toggleModTools() {
    showModTools = !showModTools;
    emit(CommentsModToolsToggled());
  }

  Future<void> copyText() {
    String text = post.title ?? '';

    if (currentComment != null) {
      text = getPlainText(currentComment!.commentBody);
    }

    return Clipboard.setData(ClipboardData(text: text));
  }
}
