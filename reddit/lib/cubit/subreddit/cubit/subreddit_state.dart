part of 'subreddit_cubit.dart';

@immutable
abstract class SubredditState {}

class SubredditInitial extends SubredditState {}

class subredditChange extends SubredditState {}

class leaveSubredditState extends SubredditState {}

class joinSubredditState extends SubredditState {}
