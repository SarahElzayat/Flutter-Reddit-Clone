abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsVoted extends PostsState {}

class PostsVotedError extends PostsState {}

class PostsSaved extends PostsState {}

class PostsHideChange extends PostsState {}

class PostsReported extends PostsState {}

class PostsDeleted extends PostsState {}

class PostsError extends PostsState {}

class PostsLoaded extends PostsState {}

class PostsLoading extends PostsState {}
