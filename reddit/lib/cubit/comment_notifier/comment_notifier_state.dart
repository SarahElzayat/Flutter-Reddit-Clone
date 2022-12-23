/// The States of the Comment notifier Cubit
/// date: 28/11/2022
/// @Author: Ahmed Atta

abstract class CommentsNotifierState {}

/// initial state of the Comment notifier Cubit
class CommentsNotifierInitial extends CommentsNotifierState {}

/// state of the Comment notifier Cubit when the Comments are changed
class CommentsContentChanged extends CommentsNotifierState {}

/// state of the Comment notifier Cubit when an error occurs
/// [error] is the error message
class CommentsNotifierError extends CommentsNotifierState {
  final String error;
  CommentsNotifierError(this.error);
}
