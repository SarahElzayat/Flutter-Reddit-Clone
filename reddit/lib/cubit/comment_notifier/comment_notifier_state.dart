/// The States of the post notifier Cubit
/// date: 28/11/2022
/// @Author: Ahmed Atta

abstract class CommentsNotifierState {}

class CommentsNotifierInitial extends CommentsNotifierState {}

class CommentsContentChanged extends CommentsNotifierState {}

class CommentsNotifierError extends CommentsNotifierState {
  final String error;
  CommentsNotifierError(this.error);
}
