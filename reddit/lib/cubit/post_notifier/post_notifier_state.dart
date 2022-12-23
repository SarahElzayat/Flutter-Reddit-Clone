/// The States of the post notifier Cubit
/// date: 28/11/2022
/// @Author: Ahmed Atta

abstract class PostNotifierState {}

/// initial state of the post notifier Cubit
class PostNotifierInitial extends PostNotifierState {}

/// state of the post notifier Cubit when the Posts are changed
class PostChanged extends PostNotifierState {}

/// state of the post notifier Cubit when an error occurs
/// [error] is the error message
class PostNotifierError extends PostNotifierState {
  final String error;
  PostNotifierError(this.error);
}

/// state of the post notifier Cubit when a post is deleted
/// [id] is the id of the deleted post
class PostDeleted extends PostNotifierState {
  final String id;
  PostDeleted(this.id);
}

/// state of the post notifier Cubit when a comment is deleted
/// [id] is the id of the deleted comment
class CommentDeleted extends PostNotifierState {
  final String id;
  CommentDeleted(this.id);
}

/// state of the post notifier Cubit when a post is saved
/// [id] is the id of the saved post
/// [type] is the type of the saved post
/// [newState] is the new state of the post (saved or unsaved)
/// and it is true if the post is saved
class PostSavedState extends PostNotifierState {
  final String id;
  final String type;
  final bool newState;
  PostSavedState(this.id, this.type, this.newState);
}
