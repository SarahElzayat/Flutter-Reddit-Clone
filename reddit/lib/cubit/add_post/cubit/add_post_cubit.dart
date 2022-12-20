import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:delta_markdown/delta_markdown.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:reddit/data/add_post/subredditsSearchListModel.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../components/button.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/snack_bar.dart';
import '../../../constants/constants.dart';
import '../../../data/add_post/subreddit_flairs.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../../screens/main_screen.dart';
import '../../../shared/local/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  SubredditFlairModel? flairs;

  static AddPostCubit get(context) => BlocProvider.of(context);

  /// [title] Title textField controller
  TextEditingController title = TextEditingController();

  /// [postType] Number indicate The post Type
  /// This number is the index of post Type in add post screen
  int postType = 2;

  bool isSubreddit = true;

  /// [images] Images that User Added
  List<XFile> images = <XFile>[];

  List<TextEditingController> captionController = [];
  List<TextEditingController> captionControllerTemp = [];

  List<TextEditingController> imagesLinkController = [];
  List<TextEditingController> imagesLinkControllerTemp = [];

  int imageCurrentIndex = 0;

  DateTime? scheduleDate;

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

  String? selectedFlair;

  bool nsfw = false;
  bool spoiler = false;

  SubredditsSearchListModel? subredditsList;

  void changePostType({required int postTypeIndex}) {
    postType = postTypeIndex;
    checkPostValidation();
    emit(PostTypeChanged(postType: postTypeIndex));
  }

  void addSubredditName(String? subredditName) {
    this.subredditName = subredditName;
    emit(ChangeSubredditName());
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
    for (var element in images) {
      this.images.add(element);
      captionController.add(TextEditingController());
      imagesLinkController.add(TextEditingController());
      captionControllerTemp.add(TextEditingController());
      imagesLinkControllerTemp.add(TextEditingController());
    }
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
    emit(CanCreatePost(canPost: false));
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
        // if (optionalText.text.isNotEmpty) {
        //   emit(CanCreatePost(canPost: true));
        // } else {
        //   emit(CanCreatePost(canPost: false));
        // }
        emit(CanCreatePost(canPost: true));
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

    if (postType == 0) {
      for (var item in images) {
        final mimeType = lookupMimeType(item.path);
        MultipartFile file = await MultipartFile.fromFile(item.path,
            filename: item.path.split('/').last,
            contentType: MediaType('image', 'png'));
        imagesData.add(file);
      }
      List<String> imageCaptions = [];
      for (int index = 0; index < captionController.length; index++) {
        imageCaptions.add(captionController[index].text);
      }
      List<String> imageLinks = [];
      for (int index = 0; index < imagesLinkController.length; index++) {
        imageLinks.add(imagesLinkController[index].text);
      }
      body = {
        'kind': postTypes[postType],
        'subreddit': subredditName,
        'inSubreddit': isSubreddit,
        'title': title.text,
        'images': imagesData,
        'imageCaptions': imageCaptions,
        'imageLinks': imageLinks,
        'nsfw': nsfw,
        'spoiler': spoiler,
        if (selectedFlair != null) 'flairId': selectedFlair,
        if (scheduleDate != null)
          'scheduleDate': DateFormat('yyyy-MM-dd').format(scheduleDate!),
        // if (scheduleDate != null)
        //   'scheduleTime': DateFormat('hh:mm:ss').format(scheduleDate!),
      };
    }
    if (postType == 1) {
      final mimeType = lookupMimeType(video!.path);

      body = {
        'video': await MultipartFile.fromBytes(
            File(video!.path).readAsBytesSync(),
            filename: 'video.mp4',
            contentType: MediaType('video', 'mp4')),
        'title': title.text,
        'kind': 'video',
        'subreddit': subredditName,
        'inSubreddit': isSubreddit,
        'nsfw': nsfw,
        'spoiler': spoiler,
        if (selectedFlair != null) 'flairId': selectedFlair,
        if (scheduleDate != null)
          'scheduleDate': DateFormat('yyyy-MM-dd').format(scheduleDate!),
      };
    } else if (postType == 2) {
      body = {
        'kind': postTypes[postType],
        'subreddit': subredditName,
        'inSubreddit': isSubreddit,
        'title': title.text,
        'content': {
          'ops': jsonDecode(markdownToDelta(optionalText.text)),
        },
        'nsfw': nsfw,
        'spoiler': spoiler,
        if (selectedFlair != null) 'flairId': selectedFlair,
        if (scheduleDate != null)
          'scheduleDate': DateFormat('yyyy-MM-dd').format(scheduleDate!),
      };
    } else if (postType == 3) {
      body = {
        'kind': postTypes[postType],
        'subreddit': subredditName,
        'inSubreddit': isSubreddit,
        'title': title.text,
        'link': link.text,
        'nsfw': nsfw,
        'spoiler': spoiler,
        if (selectedFlair != null) 'flairId': selectedFlair,
        if (scheduleDate != null)
          'scheduleDate': DateFormat('yyyy-MM-dd').format(scheduleDate!),
      };
    } else if (postType == 5) {
      body = {
        'kind': postTypes[postType],
        'subreddit': subredditName,
        'inSubreddit': isSubreddit,
        'title': title.text,
        'nsfw': nsfw,
        'spoiler': spoiler,
        if (selectedFlair != null) 'flairId': selectedFlair,
        if (scheduleDate != null)
          'scheduleDate': DateFormat('yyyy-MM-dd').format(scheduleDate!),
      };
    }

    FormData formData = FormData.fromMap(body);

    await DioHelper.postData(
            path: submitPost,
            onSendProgress: ((postType == 0 || postType == 1))
                ? ((count, total) {
                    showProgress(context, count, total);
                  })
                : null,
            isFormdata: (postType == 0 || postType == 1),
            data: formData,
            sentToken: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value);

      if (value.statusCode == 201) {
        print('Post success');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: ColorManager.eggshellWhite,
              content: Text('Post success')),
        );
        Navigator.pushAndRemoveUntil(
          navigatorKey.currentContext!,
          MaterialPageRoute(
              builder: (BuildContext context) => HomeScreenForMobile()),
          ModalRoute.withName('/'),
        );
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
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'An Error Please Try Again', error: true));
    });
    // emit(PostCreated());
  }

  void subredditSearch(String subredditName) {
    if (subredditName == '') {
      subredditsList = null;
      emit(SubredditSearch(isLoaded: true));
    } else {
      emit(SubredditSearch(isLoaded: false));
      DioHelper.getData(path: searchForSubreddit, query: {
        'type': 'subreddit',
        'q': subredditName,
      }).then((value) {
        if (value.statusCode == 200) {
          subredditsList = SubredditsSearchListModel.fromJson(value.data);
          emit(SubredditSearch(isLoaded: true));
        }
      }).catchError((error) {});
    }
  }

  /// Show TO User If Change The Post Type And the Exist Data in the current
  /// Post type it Show Pop-up to Choose if continue and remove the data or Not
  onTapFunc(int index, BuildContext context, NavigatorState navigator,
      MediaQueryData mediaQuery,
      {bool isPop = false}) {
    if (postType != index && discardCheck()) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: ColorManager.grey,
                insetPadding: EdgeInsets.zero,
                title: const Text('Change Post Type'),
                content: Text(
                  'Some of your post will be deleted if you continue',
                  style: TextStyle(fontSize: 15 * mediaQuery.textScaleFactor),
                ),
                actions: [
                  SizedBox(
                    width: mediaQuery.size.width * 0.42,
                    child: Button(
                      textFontWeight: FontWeight.normal,
                      onPressed: () {
                        navigator.pop();
                        return;
                      },
                      text: ('Cancel'),
                      textColor: ColorManager.lightGrey,
                      backgroundColor: Colors.transparent,
                      buttonWidth: mediaQuery.size.width * 0.42,
                      buttonHeight: 40,
                      textFontSize: 15,
                      borderRadius: 20,
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.42,
                    child: Button(
                      textFontWeight: FontWeight.normal,
                      onPressed: () {
                        removeExistData();

                        navigator.pop();
                        if (isPop) {
                          title.text = '';
                          subredditName = null;
                          isSubreddit = true;
                          changePostType(postTypeIndex: 2);

                          navigator.pop();
                        } else {
                          if (index == 0 && postType != index) {
                            chooseSourceWidget(context, mediaQuery, navigator);
                          } else if (index == 1 && postType != index) {
                            pickVideo(true);
                          }
                          changePostType(postTypeIndex: index);
                        }
                      },
                      text: ('Containue'),
                      textColor: ColorManager.white,
                      backgroundColor: ColorManager.red,
                      buttonWidth: mediaQuery.size.width * 0.42,
                      buttonHeight: 40,
                      textFontSize: 15,
                      borderRadius: 20,
                    ),
                  ),
                ],
              )));
    } else if (isPop) {
      title.text = '';
      subredditName = null;
      isSubreddit = true;
      changePostType(postTypeIndex: 2);

      navigator.pop();
    } else {
      if (index == 0 && postType != index) {
        chooseSourceWidget(
          context,
          mediaQuery,
          navigator,
        );
      } else if (index == 1 && postType != index) {
        pickVideo(true);
      }
      changePostType(postTypeIndex: index);
    }
  }

  showProgress(BuildContext context, int count, int total) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(
                  backgroundColor: ColorManager.white,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(ColorManager.blue),
                  color: ColorManager.white,
                  value: count.toDouble() / total.toDouble(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                    'Uploading : ${((count.toDouble() / total.toDouble()) * 100).toStringAsFixed(2)}')
              ],
            ),
          );
        }));
  }

  Future<void> getSubredditFlair() async {
    await DioHelper.getData(
        path: '/r/$subredditName/about/post-flairs',
        query: {'subreddit': subredditName}).then((value) {
      if (value.statusCode == 200) {
        flairs = SubredditFlairModel.fromJson(value.data);
      }
    }).catchError((error) {});
  }
}
