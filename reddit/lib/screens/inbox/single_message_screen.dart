/// @Author: Abdelaziz Salah
/// @date 20/12/2022
/// This widget is used to display a single message in the inbox screen.

import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../components/helpers/color_manager.dart';

var logger = Logger();

class SingleMessageScreen extends StatefulWidget {
  static const routeName = '/single_message_screen';
  const SingleMessageScreen({super.key});

  @override
  State<SingleMessageScreen> createState() => _SingleMessageScreenState();
}

class _SingleMessageScreenState extends State<SingleMessageScreen> {
  QuillController? _controller;
  @override
  void initState() {
    _controller = QuillController.basic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messageBody = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reply to Messages'),
        actions: [
          TextButton(
            onPressed: () {
              // check if the comment is empty
              if (_controller!.document.length == 1) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: ColorManager.yellow,
                    content: Text('Comment cannot be empty'),
                  ),
                );
                return;
              }

              sendTheReply(myMessageText!, myMessage);
            },
            child: const Text(
              'Post',
              style: TextStyle(color: ColorManager.blue),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(myMessageText ?? 'empty',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 21.sp,
                    color: ColorManager.eggshellWhite,
                  )),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 1,
          ),
          QuillEditor(
            controller: _controller!,
            readOnly: false,
            autoFocus: true,
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
            thickness: 2,
          ),
          Row(
            children: [
              LinkStyleButton(
                controller: _controller!,
                dialogTheme: QuillDialogTheme(
                  dialogBackgroundColor: ColorManager.darkBlack,
                  labelTextStyle: const TextStyle(color: ColorManager.blue),
                ),
                iconTheme: const QuillIconTheme(
                    iconUnselectedFillColor: Colors.transparent,
                    iconUnselectedColor: ColorManager.greyColor),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  QuillController getController(messageBody) {
    Document doc;
    try {
      logger.wtf(messageBody.content ?? {'ops': []});
      //// this if the message is in json formate
      // doc = Document.fromJson((messageBody.content ?? {'ops': []})['ops']);

      /// this is the message is in string formate
      // doc = Doc;
    } catch (e) {
      logger.wtf(e);
      doc = Document();
    }
    // doc = Document();

    return QuillController(
      document: Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void _linkSubmitted(String? value) {
    if (value != null && value.isNotEmpty && _controller != null) {
      final index = _controller!.selection.baseOffset;
      final length = _controller!.selection.extentOffset - index;
      _controller!.replaceText(index, length, BlockEmbed.image(value), null);

      // _controller!.document
      //     .insert(_controller!.selection.start, BlockEmbed.image(value));
      _controller!.document.format(
          _controller!.selection.start,
          1,
          StyleAttribute(
              'mobileWidth: ${30.w}; mobileHeight: ${30.h}; mobileMargin: 10; mobileAlignment: topLeft'));
      _controller!.document.insert(_controller!.selection.start, '\n');
      // insert new line

    }
  }

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    // insert new line
    _controller!.document.format(
        _controller!.selection.start,
        1,
        StyleAttribute(
            'mobileWidth: ${30.w}; mobileHeight: ${30.h}; mobileMargin: 10; mobileAlignment: topLeft'));
    _controller!.document.insert(_controller!.selection.start, '\n');
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${p.basename(file.path)}');
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
}
