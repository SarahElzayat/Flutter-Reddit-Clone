/// This is the Cubit for the notifier of posts, resposible for rebuilding Posts when changed
/// date: 28/11/2022
/// @Author: Ahmed Atta
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_notifier_state.dart';

class PostNotifierCubit extends Cubit<PostNotifierState> {
  PostNotifierCubit() : super(PostNotifierInitial());

  /// static getter of the cubit through inhereted widgets
  static PostNotifierCubit get(context) => BlocProvider.of(context);

  /// updates the UI of the Posts
  void notifyPosts() {
    emit(PostChanged());
  }

  /// updates the UI if a Post is deleted
  /// [id] is the id of the deleted post
  void deletedPost(String id) {
    emit(PostDeleted(id));
  }

  /// updates the UI if a comment is deleted
  /// [id] is the id of the deleted comment
  void deletedComment(String id) {
    emit(CommentDeleted(id));
  }

  /// updates the UI if a post is saved
  /// [id] is the id of the saved post
  /// [type] is the type of the saved post
  /// [newState] is the new state of the post (saved or unsaved)
  /// and it is true if the post is saved
  void postsSaveChanged(String id, String type, bool newState) {
    PostSavedState(id, type, newState);
  }
}
