/// this file is used to define Cubit used to manage the post screen.
/// date: 20/12/2022
/// @Author: Ahmed Atta

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/helpers/posts/helper_funcs.dart';
import '../../../data/comment/comments_listing.dart';

import '../../../data/comment/comment_model.dart';
import '../../../data/post_model/post_model.dart';
import '../../../networks/dio_helper.dart';
import 'post_screen_state.dart';

Logger logger = Logger();

/// Cubit used to manage the post screen.
///
/// it is used to get the Comments of the Post and to sort them.
/// it is also used to get the replies of the comments.
/// it is also used to get the replies of the replies.
class PostScreenCubit extends Cubit<PostScreenState> {
  /// the post that is shown in the post screen
  final PostModel post;

  /// the list of comments of the post
  final List<CommentModel> comments = [];

  /// Map of all comments of the post
  Map<String, CommentModel> allCommentsMap = {};

  /// show the button to scroll to the top of the comments
  bool? showbtn;

  /// the controller of the scroll view of the comments
  final ScrollController scrollController = ScrollController();

  /// labels of the sort types with the same order of the icons
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

  /// the selected sort type
  String selectedItem = 'Best';

  /// the last after of the comments Pagination
  String? lastafter;

  /// the last before of the comments Pagination
  String? lastbefore;

  PostScreenCubit({
    required this.post,
  }) : super(PostScreenInitial()) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        emit(CommentsLoadingMore());

        //scroll listener
        showbtn = scrollController.offset > 50.h;
      }
    });
  }

  static PostScreenCubit get(context) => BlocProvider.of(context);

  /// get the icon of the selected sort type
  IconData getSelectedIcon() {
    return sortIcons[selectedItem]!;
  }

  /// change the sort type of the comments
  void changeSortType(String item) {
    selectedItem = item;
    getCommentsOfPost(
      sort: item.toLowerCase(),
    );
    emit(CommentsSortTypeChanged());
  }

  /// get all comments in screen
  /// @param [limit] the number of replies to show
  /// @param [sort] the sort type of the replies
  void getCommentsOfPost({
    bool? before,
    bool? after,
    String? sort,
    int? limit,
  }) {
    emit(CommentsLoading());
    sort ??= selectedItem.toLowerCase();
    DioHelper.getData(
      path: '/comments/${post.id}',
      query: {
        'before': (before ?? false) ? lastbefore : null,
        'after': (after ?? false) ? lastafter : null,
        'limit': limit,
        'sort': sort,
      },
    ).then((value) {
      if ((after ?? false) && comments.isNotEmpty) {
        return;
      }
      if (!(after ?? false)) {
        comments.clear();
        allCommentsMap.clear();
      }

      CommentsListingModel commentsListingModel =
          CommentsListingModel.fromJson(value.data);

      lastafter = commentsListingModel.after;
      lastbefore = commentsListingModel.before;
      logger.wtf(commentsListingModel.toJson());

      commentsListingModel.children?.forEach((element) {
        comments.add(element);
        allCommentsMap[element.id!] = element;
        getChildrenOfComment(element).forEach((element) {
          allCommentsMap[element.id!] = element;
        });
      });
      emit(CommentsLoaded());
    }).catchError((error) {
      logger.e('error in coments $error');
      emit(CommentsError((error as DioError).response!.data['error']));
    });
  }

  /// show more in comments section (show more replies)
  /// @param [commentId] the comment to show more replies for
  /// @param [limit] the number of replies to show
  /// @param [before] the id of the comment to show replies before
  /// @param [after] the id of the comment to show replies after
  /// @param [sort] the sort type of the replies
  void showMoreComments({
    required String commentId,
    String? before,
    String? after,
    String sort = 'best',
    int? limit,
  }) {
    emit(CommentsLoading());

    DioHelper.getData(
      path: '/comments/${post.id}/$commentId',
      query: {
        'before': before,
        'after': after,
        'limit': limit,
        'sort': sort,
      },
    ).then((value) {
      var currentComment = allCommentsMap[commentId];

      CommentsListingModel commentsListingModel =
          CommentsListingModel.fromJson(value.data);
      // there is only one comment as the parent

      for (var child in commentsListingModel.children!) {
        if (allCommentsMap.containsKey(child.id!)) {
          allCommentsMap[child.id!]!.overrideWithOther(child);
        } else {
          allCommentsMap[child.id!] = child;
          currentComment!.children!.add(child);
        }

        getChildrenOfComment(child).forEach((element) {
          allCommentsMap[element.id!] = element;
        });
      }

      emit(CommentsLoaded());
    }).catchError((error) {
      logger.e('error in show More $error');

      emit(CommentsError('error in show more'));
    });
  }

  /// get post details
  Future<void> getPostDetails() async {
    emit(PostLoading());
    DioHelper.getData(
      path: '/post-details',
      query: {
        'id': post.id,
      },
    ).then((value) {
      post.overrideWithOther(PostModel.fromJson(value.data));
      emit(PostLoaded());
    }).catchError((error) {
      logger.e('error in post details $error');
      emit(PostError());
    });
  }

  /// deletes comment from the post
  /// @param [commentId] the id of the comment to delete
  void deleteComment(String commentId) {
    emit(CommentsLoading());
    
    allCommentsMap.remove(commentId);
    comments.removeWhere((element) => element.id == commentId);

    emit(CommentsLoaded());
  }
}
