abstract class PostScreenState {}

class PostScreenInitial extends PostScreenState {}

class CommentsSortTypeChanged extends PostScreenState {}

class CommentsLoading extends PostScreenState {}

class CommentsError extends PostScreenState {
  final String error;
  CommentsError(this.error);
}

class CommentsLoaded extends PostScreenState {}

class CommentsLoadingMore extends PostScreenState {}

class PostError extends PostScreenState {}

class PostLoaded extends PostScreenState {}

class PostLoading extends PostScreenState {}
