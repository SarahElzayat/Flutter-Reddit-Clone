/// The States of the post notifier Cubit
/// date: 28/11/2022
/// @Author: Ahmed Atta

abstract class PostNotifierState {}

class PostNotifierInitial extends PostNotifierState {}

class PostChanged extends PostNotifierState {}

class PostNotifierError extends PostNotifierState {
  final String error;
  PostNotifierError(this.error);
}

class PostDeleted extends PostNotifierState {
  final String id;
  PostDeleted(this.id);
}

class CommentDeleted extends PostNotifierState {
  final String id;
  CommentDeleted(this.id);
}

class PostSavedState extends PostNotifierState {
  final String id;
  final String type;
  final bool newState;
  PostSavedState(this.id, this.type, this.newState);
}
