/// The post cubit that handles the post state independently
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/helpers/mocks/mock_functions.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/comment/comment_model.dart';
import 'package:reddit/data/post_model/insights_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/data/user_data_model/user_data_model.dart';
import 'package:reddit/functions/post_functions.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/posts/post_screen.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import '../../../data/comment/sended_comment_model.dart';
import '../../../data/subreddit/rules_model/rules.dart';
import '../../../data/subreddit/subreddit_model.dart';
import '../../../networks/constant_end_points.dart';
import 'post_comment_actions_state.dart';

Logger logger = Logger();

/// A Cubit that handles the actions of a post and its comments
/// it's used in the [PostScreen] and the [PostWidget]
/// it's used to vote, save, report, hide, delete, edit, reply, and more
class PostAndCommentActionsCubit extends Cubit<PostActionsState> {
  /// the post that is being managed
  final PostModel post;

  /// the current comment that is being managed
  final CommentModel? currentComment;

  /// the current comment that is being managed
  final List<CommentModel> comments = [];

  /// the subreddits details fetched from the server
  /// its the [SubredditModel] of the post's or comments subreddit
  SubredditModel? subreddit;

  /// whether the Mod Tools Row are shown or not
  /// this is used in the [PostScreen]
  bool showModTools = false;

  /// [user] is the user of the post or the comment
  UserDataModel? user;

  /// The [Rules] of the [subreddit] of the post
  Rules? rules;

  PostAndCommentActionsCubit({
    required this.post,
    this.currentComment,
  }) : super(PostsInitial());

  static PostAndCommentActionsCubit get(context) => BlocProvider.of(context);

  /// Votes on a Post or a Comment
  /// @param [oldDir] the direction of the wanted post or comment
  Future vote({
    required int oldDir,
    bool isTesting = false,
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
    if (isTesting) {
      return mockDio.post(
        '/vote',
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

  /// Saves a Post or a Comment
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
  Future<bool?> hide() {
    String path = post.hidden ?? false ? '/unhide' : '/hide';

    return DioHelper.postData(
      path: path,
      data: {
        'id': post.id,
      },
    ).then((value) {
      post.hidden = !post.hidden!;

      emit(HiddenChangedState());
      return post.hidden;
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response?.data);
      emit(OpError(error: error.response?.data['error'] ?? ''));
    });
  }

  /// this function is used to block the author of a post or a comment
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
  Future<bool?> delete() {
    return DioHelper.deleteData(
      path: '/delete',
      data: {
        'id': isPost ? post.id : currentComment!.id,
        'type': isPost ? 'post' : 'comment'
      },
    ).then((value) {
      emit(PostsDeleted());
      return isPost;
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response?.data);
      emit(OpError(error: error.response?.data['error'] ?? ''));
    });
  }

  /// this function is used to toggle follow/unfollow a post or a comment
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
      logger.d('followed: ${post.followed}');
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

  /// Toggle the mod tools (show/hide)
  void toggleModTools() {
    showModTools = !showModTools;
    emit(CommentsModToolsToggled());
  }

  /// this function is used to copy the text of a post or a comment
  Future<void> copyText() {
    String text = post.title ?? '';

    if (currentComment != null) {
      text = getPlainText(currentComment!.commentBody);
    }

    return Clipboard.setData(ClipboardData(text: text));
  }

  /// this function is used to edit a post or a comment
  /// [newContent] is the new content of the post or the comment
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

  /// this function is used to get the insights of a post
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
    logger.d(c.toJson());
    DioHelper.postData(path: '/comment', data: c.toJson()).then((value) {
      onSuccess();
      return null;
    }).catchError((e) {
      onError(e as DioError);
      Map<String, dynamic> error = e.response!.data;

      logger.w(error['error']);
    });
  }

  /// used to toggle the collapse of a Comments Tree
  void collapse() {
    currentComment!.isCollapsed = !((currentComment?.isCollapsed) ?? true);
  }

  /// this function is used to get the details of the [subreddit] of the post
  /// or the comment
  void getSubDetails() {
    DioHelper.getData(
        path: '$subredditInfo/${post.subreddit}',
        query: {'subreddit': post.subreddit}).then((value) {
      if (value.statusCode == 200) {
        subreddit = SubredditModel.fromJson(value.data);
        emit(SubDetailsFetched());
        // emit(subredditChange());
      }
    }).catchError((error) {
      return;
    });
  }

  /// This function is used to get the details of the [user] of the post
  /// or the comment
  void getUserDetails() {
    String? a = isPost ? post.postedBy : currentComment!.commentedBy;
    DioHelper.getData(path: '/user/$a/about').then((value) {
      if (value.statusCode == 200) {
        user = UserDataModel.fromJson(value.data);
        emit(UserDetailsFetched());
      }
    }).catchError((error) {
      // logger.wtf('USER:' + (error as DioError?)?.response?.data);

      return;
    });
  }

  /// Join the [subreddit] of the post or the comment
  /// if the user is not a member of it
  void joinCommunity() {
    DioHelper.postData(
        path: joinSubreddit,
        data: {'subredditId': subreddit?.subredditId}).then((value) {
      if (value.statusCode == 200) {
        subreddit!.isMember = true;
        emit(JoinSubredditState());
      }
    }).catchError((error) {});
  }

  /// Leave the [subreddit] of the post or the comment
  /// if the user is a member of it
  void leaveCommunity() {
    DioHelper.postData(
        path: leaveSubreddit,
        data: {'subredditName': subreddit?.title}).then((value) {
      if (value.statusCode == 200) {
        subreddit!.isMember = false;
        emit(LeaveSubredditState());
      }
    }).catchError((error) {
      logger.d(error.response.data);
    });
  }

  /// this function is used to get the rules of the [subreddit] of the post
  /// Its used in the [PostScreen]
  void getRules() {
    DioHelper.getData(
      path: '/r/${post.subreddit}/about/rules',
    ).then((value) {
      if (value.statusCode == 200) {
        rules = Rules.fromJson(value.data);
        emit(RulesFetched());
      }
    }).catchError((error) {
      logger.d(error.response.data);
    });
  }
}
