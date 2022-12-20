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

  void deletedPost(String id) {
    emit(PostDeleted(id));
  }

  void deletedComment(String id) {
    emit(CommentDeleted(id));
  }

  void postsSaveChanged(String id, String type, bool newState) {
    PostSavedState(id, type, newState);
  }
}
