/// ModelTrimmer Screen
/// @author Haitham Mohamed
/// @date 4/11/2022
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../components/helpers/color_manager.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';

/// TrimmerView that can edit the video

class TrimmerView extends StatefulWidget {
  // /// [file] Video file
  // final File file;
  static const routeName = '/trimmerView_screen_route';

  const TrimmerView({super.key});

  @override
  TrimmerViewState createState() => TrimmerViewState();
}

class TrimmerViewState extends State<TrimmerView> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  bool _isLoaded = false;

  // late VideoPlayerController _controller;

  Future<String?> _saveVideo(AddPostCubit addPostCubit) async {
    setState(() {
      _progressVisibility = true;
    });

    String? value;

    /// This function save video to file
    await _trimmer.saveTrimmedVideo(
        startValue: _startValue,
        endValue: _endValue,
        onSave: ((outputPath) {
          _progressVisibility = false;
          value = outputPath;
          if (value != null) {
            addPostCubit.addVideo(XFile(value!));
            // GlobalVarible.video.notifyListeners();
          } else {}
        }));

    return value;
  }

  void _loadVideo(File file) {
    _trimmer.loadVideo(videoFile: file);
  }

  // @override
  // void initState() {
  //   super.initState();

  //   _controller = VideoPlayerController.file(widget.file);

  //   _loadVideo();
  // }

  @override
  Widget build(BuildContext context) {
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    // print('Video PAth = ${addPostCubit.vidoePath}');
    // _controller = VideoPlayerController.file(file);
    if (!_isLoaded) {
      File file = File(addPostCubit.vidoePath!);
      _loadVideo(file);
      _isLoaded = true;
    }
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is VideoAddedOrRemoved) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: Container(
              color: ColorManager.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  Visibility(
                    visible: _progressVisibility,
                    child: const LinearProgressIndicator(
                      backgroundColor: ColorManager.red,
                    ),
                  ),
                  Expanded(
                    child: VideoViewer(trimmer: _trimmer),
                  ),
                  Center(
                    child: TrimViewer(
                      editorProperties: const TrimEditorProperties(
                          borderPaintColor: ColorManager.yellow),
                      trimmer: _trimmer,
                      viewerHeight: 50.0,
                      viewerWidth: MediaQuery.of(context).size.width,
                      maxVideoLength: Duration(
                          seconds: addPostCubit
                              .vidoeController!.value.duration.inSeconds),
                      onChangeStart: (value) => _startValue = value,
                      onChangeEnd: (value) => _endValue = value,
                      onChangePlaybackState: (value) =>
                          setState(() => _isPlaying = value),
                    ),
                  ),
                  Container(
                    color: ColorManager.blueGrey,
                    margin: const EdgeInsets.only(top: 20, bottom: 5),
                    child: const Divider(
                      height: 5,
                      color: ColorManager.eggshellWhite,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Back'),
                      ),
                      TextButton(
                        child: _isPlaying
                            ? const Icon(
                                Icons.pause,
                                size: 40.0,
                                color: ColorManager.eggshellWhite,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                size: 40.0,
                                color: ColorManager.eggshellWhite,
                              ),
                        onPressed: () async {
                          bool playbackState =
                              await _trimmer.videoPlaybackControl(
                            startValue: _startValue,
                            endValue: _endValue,
                          );
                          setState(() {
                            _isPlaying = playbackState;
                          });
                        },
                      ),
                      MaterialButton(
                        onPressed: _progressVisibility
                            ? null
                            : () async {
                                await _saveVideo(addPostCubit);

                                // Navigator.of(context).pop();
                              },
                        child: const Text(
                          'SAVE',
                          style: TextStyle(color: ColorManager.yellow),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
