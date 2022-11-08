/// ModelTrimmer Screen
/// @author Haitham Mohamed
/// @date 4/11/2022

import 'dart:io';
import '../../Components/Helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:image_picker/image_picker.dart';

import '../../variable/global_varible.dart';

/// Trimmer Screen

class TrimmerScreen extends StatelessWidget {
  /// [_picker] The key That used when editing
  final ImagePicker _picker = ImagePicker();

  TrimmerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Trimmer'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('LOAD VIDEO'),
          onPressed: () async {
            XFile? result = await _picker.pickVideo(
              source: ImageSource.gallery,
            );
            if (result != null) {
              File file = File(result.path);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return TrimmerView(file);
                }),
              );
            }
          },
        ),
      ),
    );
  }
}

/// TrimmerView that can edit the video

class TrimmerView extends StatefulWidget {
  /// [file] Video file
  final File file;

  const TrimmerView(this.file, {super.key});

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  late VideoPlayerController _controller;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    /// This function save video to file
    await _trimmer.saveTrimmedVideo(
        startValue: _startValue,
        endValue: _endValue,
        onSave: ((outputPath) {
          _progressVisibility = false;
          _value = outputPath;
          if (_value != null) {
            GlobalVarible.video.value = XFile(_value!);
            GlobalVarible.video.notifyListeners();
          }
        }));
    ;

    return _value;
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(widget.file);

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    maxVideoLength:
                        Duration(seconds: _controller.value.duration.inSeconds),
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
                              String? path = await _saveVideo();
                              if (path != null) {}

                              Navigator.of(context).pop();
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
    );
  }
}
