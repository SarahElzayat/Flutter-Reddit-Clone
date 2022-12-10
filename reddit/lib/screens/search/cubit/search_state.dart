part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class ResultEmptyState extends SearchState {}
class NoMoreResultsToLoadState extends SearchState {}

class LoadingPostsState extends SearchState{}
class LoadingMorePostsState extends SearchState{}

class LoadedPostsState extends SearchState{}
class LoadedMorePostsState extends SearchState{}
