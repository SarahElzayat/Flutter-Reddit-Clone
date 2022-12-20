part of 'subreddit_cubit.dart';

@immutable
abstract class SubredditState {}

class SubredditInitial extends SubredditState {}

class SubredditChange extends SubredditState {}

class LeaveSubredditState extends SubredditState {}

class JoinSubredditState extends SubredditState {}
