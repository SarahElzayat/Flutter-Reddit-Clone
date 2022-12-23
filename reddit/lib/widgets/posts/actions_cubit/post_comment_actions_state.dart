/// the States of the Post cubit
/// date: 28/11/2022
/// @Author: Ahmed Atta
import 'package:dio/dio.dart';

/// The States of the Post Actions Cubit
abstract class PostActionsState {}

/// The Initial State of the Post Actions Cubit
class PostsInitial extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being Hiden
class HiddenChangedState extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being Voted and the Vote is Success
class VotedSuccess extends PostActionsState {}

/// The State of the Post Actions Cubit when the User is being Blocked
class BlockedChangedState extends PostActionsState {}

/// The State of the Post Actions Cubit when the post is being Followed or Unfollowed
class FollowedChangedState extends PostActionsState {}

/// The State of the Post Actions Cubit when the post has been Edited
class EditedState extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being Voted and the Vote is Error
///
/// it contains the [error] that is returned from the server
class VotedError extends PostActionsState {
  final DioError? error;
  VotedError({this.error});
}

/// The State of the Post Actions Cubit when the Post is being operated on and the operation is in Error State
///
/// it contains the [error] that is returned from the server
class OpError extends PostActionsState {
  final String? error;
  OpError({this.error});
}

/// The State of the Post Actions Cubit when the Subreddit is fetched
class SubDetailsFetched extends PostActionsState {}

/// The State of the Post Actions Cubit when the Subreddit is Joined
class JoinSubredditState extends PostActionsState {}

/// The State of the Post Actions Cubit when Mod Tools view are Toggled
class CommentsModToolsToggled extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being Saved or Unsaved
class SavedChangedState extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being saved and the operation is in Error State
class PostsSavedError extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being hidden/unhidden and the operation is in Success State
class PostsHideChange extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being Reported and the operation is in Success State
class PostsReported extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being Deleted
class PostsDeleted extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post Operatin is in Error State
class PostsError extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post have been loaded
class PostsLoaded extends PostActionsState {}

/// The State of the Post Actions Cubit when the Post is being loaded
class PostsLoading extends PostActionsState {}

/// The State of the Post Actions Cubit when the user details are fetched
class UserDetailsFetched extends PostActionsState {}

/// The State of the Post Actions Cubit when the rules  are fetched
class RulesFetched extends PostActionsState {}

/// The State of the Post Actions Cubit when the Subreddit is Left
class LeaveSubredditState extends PostActionsState {}
