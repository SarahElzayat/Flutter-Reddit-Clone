import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:path/path.dart';

import '../../data/comment/comment_model.dart';
import '../../data/post_model/post_model.dart';

import 'dart:async';

class AddCommentScreen extends StatefulWidget {
  static const routeName = 'add-comment';
  const AddCommentScreen({super.key, required this.post, this.parentComment});

  /// the post to which the comment will be added
  final PostModel post;

  /// the parent comment to which the comment will be added
  /// if null, the comment will be added to the post
  final CommentModel? parentComment;

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  QuillController? _controller;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _controller = QuillController.basic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var toolbar = QuillToolbar.basic(
      showUndo: false,
      showRedo: false,
      showBoldButton: false,
      showItalicButton: false,
      showBackgroundColorButton: false,
      showCenterAlignment: false,
      showLeftAlignment: false,
      showRightAlignment: false,
      showJustifyAlignment: false,
      showHeaderStyle: false,
      showListNumbers: false,
      showListBullets: false,
      showCodeBlock: false,
      showStrikeThrough: false,
      showFontSize: false,
      controller: _controller!,
      embedButtons: FlutterQuillEmbeds.buttons(
        // provide a callback to enable picking images from device.
        // if omit, "image" button only allows adding images from url.
        // same goes for videos.
        onImagePickCallback: _onImagePickCallback,
        onVideoPickCallback: _onVideoPickCallback,
        // uncomment to provide a custom "pick from" dialog.
        // mediaPickSettingSelector: _selectMediaPickSetting,
        // uncomment to provide a custom "pick from" dialog.
        // cameraPickSettingSelector: _selectCameraPickSetting,
      ),
      showAlignmentButtons: true,
      afterButtonPressed: _focusNode.requestFocus,
    );
    if (kIsWeb) {
      toolbar = QuillToolbar.basic(
        controller: _controller!,
        embedButtons: FlutterQuillEmbeds.buttons(
          onImagePickCallback: _onImagePickCallback,
          webImagePickImpl: _webImagePickImpl,
        ),
        showAlignmentButtons: true,
        afterButtonPressed: _focusNode.requestFocus,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add comment'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Post',
              style: TextStyle(color: ColorManager.blue),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          QuillEditor(
            controller: QuillController(
              document:
                  Document.fromJson(jsonDecode(widget.post.content ?? '[]')),
              selection: const TextSelection(baseOffset: 0, extentOffset: 0),
            ),
            readOnly: true,
            enableInteractiveSelection: false,
            autoFocus: false,
            expands: false,
            scrollable: false,
            scrollController: ScrollController(),
            focusNode: FocusNode(),
            padding: EdgeInsets.zero,
            embedBuilders: [
              ...FlutterQuillEmbeds.builders(),
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          Expanded(
            child: QuillEditor(
              controller: _controller!,
              readOnly: false,
              autoFocus: true,
              expands: true,
              scrollable: true,
              scrollController: ScrollController(),
              focusNode: FocusNode(),
              padding: EdgeInsets.zero,
              embedBuilders: [
                ...FlutterQuillEmbeds.builders(),
              ],
            ),
          ),
          toolbar
        ],
      ),
    );
  }

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

  Future<String?> _webImagePickImpl(
      OnImagePickCallback onImagePickCallback) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }

    // Take first, because we don't allow picking multiple files.
    final fileName = result.files.first.name;
    final file = File(fileName);

    return onImagePickCallback(file);
  }

  // Renders the video picked by imagePicker from local file storage
  // You can also upload the picked video to any server (eg : AWS s3
  // or Firebase) and then return the uploaded video URL.
  Future<String> _onVideoPickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }
}
