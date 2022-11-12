// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_post_cubit.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class PostTypeChanged extends AddPostState {
  final int postType;
  PostTypeChanged({
    required this.postType,
  });

  int get getPostType => postType;
}

class ImageAddedOrRemoved extends AddPostState {}

class ImagePaintedOrCropped extends AddPostState {}

class VideoAddedOrRemoved extends AddPostState {
  bool isAdded;
  VideoAddedOrRemoved({
    required this.isAdded,
  });
}

class CanCreatePost extends AddPostState {
  bool canPost;
  CanCreatePost({
    required this.canPost,
  });
}
