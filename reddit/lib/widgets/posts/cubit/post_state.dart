/// the States of the Post cubit
/// date: 28/11/2022
/// @Author: Ahmed Atta
import 'package:dio/dio.dart';

abstract class PostState {}

class PostsInitial extends PostState {}

class VotedSuccess extends PostState {}

class VotedError extends PostState {
  final DioError? error;
  VotedError({this.error});
}

class PostsSaved extends PostState {}

class PostsSavedError extends PostState {}

class PostsHideChange extends PostState {}

class PostsReported extends PostState {}

class PostsDeleted extends PostState {}

class PostsError extends PostState {}

class PostsLoaded extends PostState {}

class PostsLoading extends PostState {}

class CommentsSortTypeChanged extends PostState {}

class CommentsModToolsToggled extends PostState {}

class CommentsLoading extends PostState {}

class CommentsError extends PostState {}

class CommentsLoaded extends PostState {}
