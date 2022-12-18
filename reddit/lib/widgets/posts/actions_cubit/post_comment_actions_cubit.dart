/// The post cubit that handles the post state independently
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:logger/logger.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/post_model/insights_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/functions/post_functions.dart';
import 'package:reddit/networks/dio_helper.dart';
import '../../../data/comment/sended_comment_model.dart';
import 'post_comment_actions_state.dart';

Logger logger = Logger();

class PostAndCommentActionsCubit extends Cubit<PostActionsState> {
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
      sentToken: token,
      data: {
        'id': isPost ? post.id : currentComment!.id,
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
    String path = post.hidden ?? false ? '/unhide' : '/hide';

    return DioHelper.postData(
      path: path,
      data: {
        'id': post.id,
      },
    ).then((value) {
      post.hidden = !post.hidden!;
      emit(HiddenChangedState());
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response?.data);
      emit(OpError(error: error.response?.data['error'] ?? ''));
    });
  }

  /// this function is used to block the author of a post
  Future blockUser() {
    String? username = isPost ? post.postedBy : currentComment!.commentedBy;
    return DioHelper.postData(
      path: '/block-user',
      data: {
        'block': true,
        'username': username,
      },
    ).then((value) {
      emit(BlockedChangedState());
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response?.data);
      emit(OpError(error: error.response?.data['error'] ?? ''));
    });
  }

  /// this function is used to delete a post
  Future delete() {
    return DioHelper.postData(
      path: '/delete',
      data: {
        'id': isPost ? post.id : currentComment!.id,
        'type': isPost ? 'post' : 'comment'
      },
    ).then((value) {
      emit(PostsDeleted());
    }).catchError((error) {
      logger.e(error.toString());
      error = error as DioError;
      emit(OpError(error: error.response?.data['error'] ?? ''));
    });
  }

  Future follow() {
    String path = isPost
        ? '/follow-post'
        : (currentComment!.followed ?? false)
            ? '/unfollow-comment'
            : '/follow-comment';

    return DioHelper.postData(
      path: path,
      data: {
        'id': post.id,
        'follow': !(post.followed ?? false),
        'commentId': currentComment?.id,
      },
    ).then((value) {
      logger.w('followed: ${post.followed}');
      if (isPost) {
        post.followed = !post.followed!;
      } else {
        currentComment!.followed = !currentComment!.followed!;
      }
      emit(FollowedChangedState());
    }).catchError((error) {
      logger.e(error.toString());
      error = error as DioError;
      emit(OpError(error: error.response?.data['error'] ?? ''));
    });
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

  Future<void> editIt(Map<String, dynamic> newContent) {
    String path = isPost ? '/edit-post' : '/edit-user-text';

    if (isPost) {
      return DioHelper.postData(
        path: path,
        data: {
          'postId': post.id,
          'id': currentComment?.id,
          'content': newContent,
        },
      ).then((value) {
        if (isPost) {
          post.content = newContent;
        } else {
          currentComment!.commentBody = newContent;
        }
        emit(EditedState());
      }).catchError((error) {
        error = error as DioError;
        logger.e(error.response?.data);
        emit(OpError(error: error.response?.data['error'] ?? ''));
      });
    }

    return DioHelper.putData(
      path: path,
      data: {
        'postId': post.id,
        'id': currentComment?.id,
        'content': newContent,
      },
    ).then((value) {
      if (isPost) {
        post.title = Document.fromJson(newContent['ops']).toPlainText();
      } else {
        currentComment!.commentBody = newContent;
      }
      emit(EditedState());
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response?.data);
      emit(OpError(error: error.response?.data['error'] ?? ''));
    });
  }

  Future<InsightsModel> getInsights() {
    return DioHelper.getData(
      path: '/post-insights',
      query: {
        'id': post.id,
      },
    ).then((value) {
      return InsightsModel.fromJson(value.data);
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response?.data);
      emit(OpError(error: error.response?.data['error'] ?? ''));
      throw error;
    });
  }

  static postComment({
    required VoidCallback onSuccess,
    required void Function(DioError) onError,
    required SendedCommentModel c,
  }) {
    logger.e(c.toJson());
    DioHelper.postData(path: '/comment', data: c.toJson()).then((value) {
      onSuccess();
      return null;
    }).catchError((e) {
      onError(e as DioError);
      Map<String, dynamic> error = e.response!.data;

      logger.w(error['error']);
    });
  }

  void collapse() {
    currentComment!.isCollapsed = !((currentComment?.isCollapsed) ?? true);
  }
}
