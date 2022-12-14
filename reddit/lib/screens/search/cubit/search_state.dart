part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class ResultEmptyState extends SearchState {}
class NoMoreResultsToLoadState extends SearchState {}



class LoadingResultsState extends SearchState{}
class LoadingMoreResultsState extends SearchState{}


// class LoadedPostsState extends SearchState{}
// class LoadedMorePostsState extends SearchState{}

class LoadedResultsState extends SearchState{}
class LoadedMoreResultsState extends SearchState{}

class FollowStateChanged extends SearchState{}
class JoinStateChanged extends SearchState{}



class SearchErrorState extends SearchState{}