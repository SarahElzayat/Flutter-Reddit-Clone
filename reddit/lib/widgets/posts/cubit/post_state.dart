abstract class PostState {}

class PostsInitial extends PostState {}

class PostsVoted extends PostState {}

class PostsVotedError extends PostState {}

class PostsSaved extends PostState {}

class PostsHideChange extends PostState {}

class PostsReported extends PostState {}

class PostsDeleted extends PostState {}

class PostsError extends PostState {}

class PostsLoaded extends PostState {}

class PostsLoading extends PostState {}
