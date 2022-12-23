/// the States of the Post cubit
/// date: 28/11/2022
/// @Author: Ahmed Atta
import 'package:dio/dio.dart';

abstract class PostActionsState {}

class PostsInitial extends PostActionsState {}

class HiddenChangedState extends PostActionsState {}

class VotedSuccess extends PostActionsState {}

class BlockedChangedState extends PostActionsState {}

class FollowedChangedState extends PostActionsState {}

class EditedState extends PostActionsState {}

class VotedError extends PostActionsState {
  final DioError? error;
  VotedError({this.error});
}

class OpError extends PostActionsState {
  final String? error;
  OpError({this.error});
}

class SubDetailsFetched extends PostActionsState {}

class JoinSubredditState extends PostActionsState {}

class CommentsModToolsToggled extends PostActionsState {}

class SavedChangedState extends PostActionsState {}

class PostsSavedError extends PostActionsState {}

class PostsHideChange extends PostActionsState {}

class PostsReported extends PostActionsState {}

class PostsDeleted extends PostActionsState {}

class PostsError extends PostActionsState {}

class PostsLoaded extends PostActionsState {}

class PostsLoading extends PostActionsState {}

class UserDetailsFetched extends PostActionsState {}

class RulesFetched extends PostActionsState {}

class LeaveSubredditState extends PostActionsState {}
