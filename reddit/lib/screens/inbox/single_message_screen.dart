/// @Author: Abdelaziz Salah
/// @date 20/12/2022
/// This widget is used to display a single message in the inbox screen.

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:reddit/data/messages/messages_model.dart';
import 'package:reddit/data/messages/reply_to_message_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
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

  void sendTheReply(content, MessageChildren msg) async {
    // build the model of reply
    ReplyToMessageModel reply = ReplyToMessageModel(
      text: 'content', // the content of the reply either string or json.
      subject: msg.data?.subject,
      receiverUsername: msg.data?.senderUsername,
      repliedMsgId: msg.id,
      subredditName: msg.data?.subredditName,
    );

    // send the reply to the backend
    await DioHelper.postData(path: replyToMessage, data: reply.toJson())
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: ColorManager.green,
            content: Text('Reply is sent successfully 😊'),
          ),
        );

        // after sending the reply close the message.
        Navigator.of(context).pop();
      }
    }).onError((error, trace) {
      error = error as DioError;
      if (!error.message.contains('500')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ColorManager.red,
            content: Text(
              '${error.response?.data['error']} 😔',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: ColorManager.red,
            content: Text(
              'SomeThing went wrong!😔',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myMessage =
        ModalRoute.of(context)!.settings.arguments as MessageChildren;
    String? myMessageText = myMessage.data?.text;
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
                    content: Text('Reply cannot be empty 😅',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorManager.darkBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
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
            // child: QuillEditor(
            //   controller: getController(myMessage),
            //   readOnly: true,
            //   enableInteractiveSelection: true,
            //   autoFocus: false,
            //   expands: false,
            //   scrollable: true,
            //   scrollController: ScrollController(),
            //   focusNode: FocusNode(),
            //   padding: EdgeInsets.zero,
            //   embedBuilders: [
            //     ...FlutterQuillEmbeds.builders(),
            //   ],
            // ),
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

  QuillController getController(myMessage) {
    Document doc;
    try {
      logger.wtf(myMessage.content ?? {'ops': []});
      //// this if the message is in json formate
      // doc = Document.fromJson((myMessage.content ?? {'ops': []})['ops']);

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
