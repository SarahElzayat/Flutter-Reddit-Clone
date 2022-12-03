import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  /// [title] Title textField controller
  TextEditingController title = TextEditingController();

  /// [postType] Number indicate The post Type
  /// This number is the index of post Type in add post screen
  int postType = 5;

  /// [images] Images that User Added
  List<XFile> images = <XFile>[];

  /// [editableImage] Image that User will edit it
  late XFile editableImage;

  /// [video] Video that User Added
  XFile? video;

  /// [videoThumbnail] Image of the Video
  Uint8List? videoThumbnail;

  /// [optionalText] Optional Text controller
  TextEditingController optionalText = TextEditingController();

  /// [link] URL textField controller
  TextEditingController link = TextEditingController();

  /// [poll] Controller for each option in poll <List> (min 2 options)
  List<TextEditingController> poll = [
    TextEditingController(),
    TextEditingController()
  ];

  void changePostType({required int postTypeIndex}) {
    postType = postTypeIndex;
    emit(PostTypeChanged(postType: postTypeIndex));
  }

  /// Add Image To The List And Rebuild The widget
  void addImage({required XFile image}) {
    images.add(image);
    checkPostValidation();
    emit(ImageAddedOrRemoved());
  }

  /// Add List of Images To The List And Rebuild The widget
  void addImages({required List<XFile> images}) {
    images.forEach((element) {
      this.images.add(element);
    });
    checkPostValidation();
    emit(ImageAddedOrRemoved());
  }

  /// Remove Image From The List And Rebuild The widget
  void removeImage({required int index}) {
    images.removeAt(index);
    checkPostValidation();
    emit(ImageAddedOrRemoved());
  }

  /// Notify If Image Edited or Not
  void imagePaintedOrCropped() {
    emit(ImagePaintedOrCropped());
  }

  /// Add Video And its videoThumbnail
  void addVideo(XFile video) async {
    this.video = video;

    videoThumbnail = await VideoThumbnail.thumbnailData(
      video: this.video!.path,
      imageFormat: ImageFormat.JPEG,
      // maxWidth:
      //     128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      // quality: 0,
    );

    checkPostValidation();
    emit(VideoAddedOrRemoved(isAdded: true));
  }

  /// Reomve The Video
  void removeVideo() {
    video = null;
    videoThumbnail = null;
    emit(VideoAddedOrRemoved(isAdded: false));
    checkPostValidation();
  }

  /// The Function For Debugging only
  @override
  void onChange(Change<AddPostState> change) {
    print(change);
    super.onChange(change);
  }

  /// Check if Any Exist data before change the post type
  /// if Exist it notify User if would to remove data and continue or Not
  bool discardCheck() {
    switch (postType) {
      case 0:
        return (images.isNotEmpty);
      case 1:
        return (video != null && videoThumbnail != null);
      case 2:
        return (optionalText.text.isNotEmpty);
      case 3:
        return (link.text.isNotEmpty);
      case 4:
        if (poll[0].text.isNotEmpty || poll[1].text.isNotEmpty) {
          return true;
        } else {
          poll = [TextEditingController(), TextEditingController()];
          optionalText = TextEditingController();
          return false;
        }
      default:
        return false;
    }
  }

  /// Romove Exist data If User Choose To Remove the data when change the Post Type
  void removeExistData() {
    switch (postType) {
      case 0:
        images.clear();
        break;
      case 1:
        video = null;
        videoThumbnail = null;
        break;
      case 2:
        optionalText = TextEditingController();
        break;
      case 3:
        link = TextEditingController();
        break;
      case 4:
        poll = [TextEditingController(), TextEditingController()];
        break;
      default:
    }
  }

  /// Check Validation if the Post Content NOT Complete
  void checkPostValidation() {
    if (title.text.isEmpty) {
      emit(CanCreatePost(canPost: false));
      return;
    }
    switch (postType) {
      case 0:
        if (images.isNotEmpty) {
          emit(CanCreatePost(canPost: true));
        } else {
          emit(CanCreatePost(canPost: false));
        }
        break;
      case 1:
        if ((video != null && videoThumbnail != null)) {
          emit(CanCreatePost(canPost: true));
        } else {
          emit(CanCreatePost(canPost: false));
        }
        break;
      case 2:
        if (optionalText.text.isNotEmpty) {
          emit(CanCreatePost(canPost: true));
        } else {
          emit(CanCreatePost(canPost: false));
        }
        break;
      case 3:
        if (Uri.parse(link.text).isAbsolute) {
          emit(CanCreatePost(canPost: true));
        } else {
          emit(CanCreatePost(canPost: false));
        }
        break;
      case 4:
        if (poll[0].text.isNotEmpty && poll[1].text.isNotEmpty) {
          emit(CanCreatePost(canPost: true));
        } else {
          emit(CanCreatePost(canPost: false));
        }
        break;
      case 5:
        emit(CanCreatePost(canPost: true));
        break;
      default:
        emit(CanCreatePost(canPost: false));
    }
  }
}
