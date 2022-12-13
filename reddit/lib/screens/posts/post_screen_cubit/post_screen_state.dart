abstract class PostScreenState {}

class PostScreenInitial extends PostScreenState {}

class CommentsSortTypeChanged extends PostScreenState {}

class CommentsLoading extends PostScreenState {}

class CommentsError extends PostScreenState {
  final String error;
  CommentsError(this.error);
}

class CommentsLoaded extends PostScreenState {}
