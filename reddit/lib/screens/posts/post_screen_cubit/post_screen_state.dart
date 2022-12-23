/// this file is used to define States of Post screen Cubit
/// date: 20/12/2022
/// @Author: Ahmed Atta

/// Base class for the States of Post screen Cubit
abstract class PostScreenState {}

/// initial state of Post screen Cubit
class PostScreenInitial extends PostScreenState {}

/// state of Post screen Cubit when the Comments Sort type are changed
class CommentsSortTypeChanged extends PostScreenState {}

/// state of Post screen Cubit when the Comments are being loaded
class CommentsLoading extends PostScreenState {}

/// state of Post screen Cubit when an error occurs
/// [error] is the error message
class CommentsError extends PostScreenState {
  final String error;
  CommentsError(this.error);
}

/// state of Post screen Cubit when the Comments are loaded
class CommentsLoaded extends PostScreenState {}

/// state of Post screen Cubit when the Comments are being loaded more
class CommentsLoadingMore extends PostScreenState {}

/// state of Post screen Cubit when an error occurs while loading the post
class PostError extends PostScreenState {}

/// state of Post screen Cubit when the post is loaded
class PostLoaded extends PostScreenState {}

/// state of Post screen Cubit when the post is being loaded
class PostLoading extends PostScreenState {}
