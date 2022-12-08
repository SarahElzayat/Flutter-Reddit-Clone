import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../components/button.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../constants/constants.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../screens/main_screen.dart';
import '../../../shared/local/shared_preferences.dart';

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

  List<TextEditingController> captionController = [];
  List<TextEditingController> captionControllerTemp = [];

  List<TextEditingController> imagesLinkController = [];
  List<TextEditingController> imagesLinkControllerTemp = [];

  int imageCurrentIndex = 0;

  /// [editableImage] Image that User will edit it
  late XFile editableImage;

  /// [video] Video that User Added
  XFile? video;

  /// [vidoePath] The path of the Video that User Added
  String? vidoePath;

  VideoPlayerController? vidoeController;

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

  String? subredditName;

  bool nsfw = false;
  bool spoiler = false;

  void changePostType({required int postTypeIndex}) {
    postType = postTypeIndex;
    checkPostValidation();
    emit(PostTypeChanged(postType: postTypeIndex));
  }

  void addSubredditName(String subredditName) {
    this.subredditName = subredditName;
  }

  /// Add Image To The List And Rebuild The widget
  void addImage({required XFile image}) {
    images.add(image);
    captionController.add(TextEditingController());
    imagesLinkController.add(TextEditingController());
    captionControllerTemp.add(TextEditingController());
    imagesLinkControllerTemp.add(TextEditingController());
    checkPostValidation();
    emit(ImageAddedOrRemoved());
  }

  /// Add List of Images To The List And Rebuild The widget
  void addImages({required List<XFile> images}) {
    images.forEach((element) {
      this.images.add(element);
      captionController.add(TextEditingController());
      imagesLinkController.add(TextEditingController());
      captionControllerTemp.add(TextEditingController());
      imagesLinkControllerTemp.add(TextEditingController());
    });
    checkPostValidation();
    emit(ImageAddedOrRemoved());
  }

  /// Remove Image From The List And Rebuild The widget
  void removeImage({required int index}) {
    images.removeAt(index);
    captionController.removeAt(index);
    imagesLinkController.removeAt(index);
    captionControllerTemp.removeAt(index);
    imagesLinkControllerTemp.removeAt(index);
    checkPostValidation();
    emit(ImageAddedOrRemoved());
  }

  void imageCaptionEdited() {
    for (int i = 0; i < captionController.length; i++) {
      if (captionController[i].text.toString() !=
          captionControllerTemp[i].text.toString()) {
        emit(ImageCaptionOrLinkEdited(isChange: true));
        return;
      }
    }
    for (int i = 0; i < captionController.length; i++) {
      if (imagesLinkController[i].text.toString() !=
          imagesLinkControllerTemp[i].text.toString()) {
        if ((Uri.parse(imagesLinkControllerTemp[i].text).isAbsolute) ||
            imagesLinkControllerTemp[i].text.isEmpty) {
          emit(ImageCaptionOrLinkEdited(isChange: true));
          return;
        }
      }
    }
    emit(ImageCaptionOrLinkEdited(isChange: false));
  }

  void editCaptions(bool editOrRemove) {
    if (editOrRemove) {
      for (int i = 0; i < captionController.length; i++) {
        captionController[i].text = captionControllerTemp[i].text.toString();
      }
      for (int i = 0; i < captionController.length; i++) {
        imagesLinkController[i].text =
            imagesLinkControllerTemp[i].text.toString();
      }
    } else {
      for (int i = 0; i < captionController.length; i++) {
        captionControllerTemp[i].text = captionController[i].text.toString();
      }
      for (int i = 0; i < captionController.length; i++) {
        imagesLinkControllerTemp[i].text =
            imagesLinkController[i].text.toString();
      }
    }
    emit(ImageCaptionOrLinkEdited(isChange: false));
  }

  /// Notify If Image Edited or Not
  void imagePaintedOrCropped() {
    emit(ImagePaintedOrCropped());
  }

  /// This function allow you to choose video
  /// you are allowed to choose one video only after that it will navigate to Video Trimmer Screen
  void pickVideo(bool pickVideo) async {
    if (pickVideo) {
      XFile? result = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
      if (result != null) {
        vidoePath = result.path;
        File file = File(result.path);
        vidoeController = VideoPlayerController.file(file);
        // print('Video PAth in cuibt = $vidoePath');
        emit(EditVideo());
      }
    } else {
      vidoePath = video!.path;
      File file = File(vidoePath!);
      vidoeController = VideoPlayerController.file(file);
      emit(EditVideo());
    }
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
    nsfw = false;
    spoiler = false;
    subredditName = null;
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

  /// This function allow you to choose images
  /// if the number of images is one so it will navigate to Preview Screen that can make edit in image
  /// else it will add images and navigate back
  imageFunc(BuildContext context, ImageSource source) async {
    List<XFile> images = <XFile>[];
    if (source == ImageSource.gallery) {
      images = await ImagePicker().pickMultiImage();
    } else {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image != null) images.add(image);
    }
    if (images.length == 1) {
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) {
      //     return ImageScreen(image: image[0], imageKey: imageKey);
      //   },
      // ));
      editableImage = images[0];

      emit(PreviewImage());
    } else if (images.length > 1) {
      addImages(images: images);
    }
  }

  /// Make User Choose The Source of Image that Want to Add
  /// Note He Choose in Image Post Only in Video will be implement later
  void chooseSourceWidget(BuildContext context, MediaQueryData mediaQuery,
      NavigatorState navigator) {
    showDialog(
        context: context,
        builder: ((context2) => AlertDialog(
              backgroundColor: ColorManager.grey,
              insetPadding: EdgeInsets.zero,
              title: const Text('Choose The Source'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      ImageSource source = ImageSource.gallery;
                      Navigator.of(context2).pop();
                      imageFunc(context, source);
                      return;
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.image_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                              fontSize: 20 * mediaQuery.textScaleFactor),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      ImageSource source = ImageSource.camera;
                      Navigator.of(context2).pop();
                      imageFunc(context, source);
                      return;
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.camera_alt_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Camera',
                            style: TextStyle(
                                fontSize: 20 * mediaQuery.textScaleFactor)),
                      ],
                    ),
                  )
                ],
              ),
              actions: [
                SizedBox(
                  width: mediaQuery.size.width * 0.42,
                  child: Button(
                    onPressed: () {
                      navigator.pop();
                      return;
                    },
                    text: ('Cancel'),
                    textColor: ColorManager.white,
                    backgroundColor: Colors.transparent,
                    buttonWidth: mediaQuery.size.width * 0.3,
                    buttonHeight: 40,
                    textFontSize: 15,
                  ),
                ),
              ],
            )));
  }

  /// Upload Post To Backend
  Future createPost(BuildContext context) async {
    Map<String, dynamic> body = {};
    List<MultipartFile> imagesData = [];

    // if (postType == 0) {
    //   for (var item in images) {
    //     print(item.path);
    //     MultipartFile file = await MultipartFile.fromFile(
    //       item.path,
    //       filename: item.path.split('/').last,
    //     );
    //     imagesData.add(file);
    //   }
    //   imagesData.forEach((element) {
    //     print(element.filename);
    //   });
    //   List<String> imageCaptions = [];
    //   for (int index = 0; index < captionController.length; index++) {
    //     imageCaptions.add(captionController[index].text);
    //   }
    //   List<String> imageLinks = [];
    //   for (int index = 0; index < captionController.length; index++) {
    //     imageLinks.add(imagesLinkController[index].text);
    //   }
    //   body = {
    //     'kind': postTypes[postType],
    //     'subreddit': subredditName,
    //     'inSubreddit': true,
    //     'title': title.text,
    //     'images': imagesData,
    //     'imageCaptions': imageCaptions,
    //     'imageLinks': imageLinks,
    //     'nsfw': nsfw,
    //     'spoiler': spoiler,
    //   };
    // } else if (postType == 1) {
    //   body = {
    //     'kind': postTypes[postType],
    //     'subreddit': subredditName,
    //     'inSubreddit': true,
    //     'title': title.text,
    //     'videos': await MultipartFile.fromFile(
    //       video!.path,
    //       filename: video!.path.split('/').last,
    //     ),
    //     'nsfw': nsfw,
    //     'spoiler': spoiler,
    //   };} else
    if (postType == 2) {
      body = {
        'kind': postTypes[postType],
        'subreddit': subredditName,
        'inSubreddit': true,
        'title': title.text,
        'texts': [
          <String, dynamic>{
            'text': optionalText.text,
            'index': 0,
          }
        ],
        'nsfw': nsfw,
        'spoiler': spoiler,
      };
    } else if (postType == 3) {
      body = {
        'kind': postTypes[postType],
        'subreddit': subredditName,
        'inSubreddit': true,
        'title': title.text,
        'link': link.text,
        'nsfw': nsfw,
        'spoiler': spoiler,
      };
    } else if (postType == 5) {
      body = {
        'kind': postTypes[postType],
        'subreddit': subredditName,
        'inSubreddit': true,
        'title': title.text,
        'texts': [
          <String, dynamic>{
            'text': optionalText.text,
            'index': 0,
          }
        ],
        'nsfw': nsfw,
        'spoiler': spoiler,
      };
    }
    print(body);
    var formData = FormData.fromMap(body);
    print('Toke : ${CacheHelper.getData(key: 'token')}');
    await DioHelper.postData(
            path: submitPost,
            data: (postType == 0 || postType == 1) ? formData : body,
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: ColorManager.eggshellWhite,
            content: Text('Post success')),
      );
      if (value.statusCode == 200) {
        print('Post success');
        Navigator.of(context)
            .pushReplacementNamed(HomeScreenForMobile.routeName);
      } else if (value.statusCode == 400) {
        print(value);
      } else if (value.statusCode == 401) {
        print('User not allowed to post in this subreddit');
      } else if (value.statusCode == 404) {
        print('Subreddit not found');
      } else if (value.statusCode == 500) {
        print('Server Error');
      }
    }).catchError((error) {
      print("The errorrr isss :::::: ${error.toString()}");
    });
    emit(PostCreated());
  }
}
