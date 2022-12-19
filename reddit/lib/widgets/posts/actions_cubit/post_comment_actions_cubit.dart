/// The post cubit that handles the post state independently
/// date: 8/11/2022
/// @Author: Ahmed Atta
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/helpers/mocks/mock_functions.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
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
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        Logger().wtf(value.data);
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
      emit(VotedError(error: error));
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

<<<<<<< HEAD
=======
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

>>>>>>> 40631d0f69581fdc20be242bf49bcd860a53f2da
  dynamic get getModel => currentComment ?? post;

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
<<<<<<< HEAD
=======

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
>>>>>>> 40631d0f69581fdc20be242bf49bcd860a53f2da
}
