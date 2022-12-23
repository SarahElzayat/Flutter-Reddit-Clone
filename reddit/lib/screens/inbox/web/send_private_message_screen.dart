/// @author Abdelaziz Salah
/// @date 23-12-2022
/// This file contains the Send private message screen for web.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/default_text_field.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/home_app_bar.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/data/messages/send_message_model.dart';
import 'package:reddit/data/sign_in_And_sign_up_models/validators.dart';
import 'package:reddit/screens/inbox/web/inbox_screen_for_web.dart';
import 'package:reddit/widgets/inbox/web/header_for_inbox.dart';

import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';

class SendPrivateMessageScreen extends StatefulWidget {
  static const routeName = '/message/compose';
  const SendPrivateMessageScreen({super.key});

  @override
  State<SendPrivateMessageScreen> createState() =>
      _SendPrivateMessageScreenState();
}

class _SendPrivateMessageScreenState extends State<SendPrivateMessageScreen> {
  final _senderController = TextEditingController();
  final _recieverController = TextEditingController();
  final _subjectController = TextEditingController();
  final _msgController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  /// this function should validate that the input to the textfields
  /// are valid, else it will show a snackbar to the user
  /// telling him that he has inserted something wrong.
  bool validTextFields() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        responseSnackBar(message: ' Invalid message 😐😐'),
      );
      return false;
    }
    return true;
  }

  /// this is a utility function used to send the message to the required user.
  void sendTheMessage() async {
    if (!validTextFields()) return;

    if (!Validator.validUserName(_senderController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Username must be greate than 2 in length'));
      return;
    } else {
      // create the model to be sent
      SendMessageModel msg = SendMessageModel(
        isReply: false,
        receiverUsername: _recieverController.text,
        subject: _subjectController.text,
        text: _msgController.text,
        subredditName: '',
        repliedMsgId: '',
      );

      // send it to the backend
      await DioHelper.postData(path: replyToMessage, data: msg.toJson())
          .then((response) {
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
              message: 'Message has been sent Successfully 😊', error: false));
        }
      }).onError((error, stackTrace) {
        error = error as DioError;

        ScaffoldMessenger.of(context).showSnackBar(
            responseSnackBar(message: error.message, error: true));
      });
    }
  }

  /// this is the type of the message that will be sent.
  String msgType = 'all';

  /// this function is used to change the type of the message.
  /// to be able to show the appropriate data.
  void changeTheMsgType(String type) {
    setState(() {
      msgType = type;
    });
    Navigator.of(context).pushReplacementNamed(InboxScreenforWeb.routeName);
  }

  /// the header type which decide which content will be shown.
  String headerType = 'Inbox';

  /// change the header type to be able to show the appropriate header.
  void changeTheHeaderType(String type) {
    setState(() {
      headerType = type;
    });
    if (type == 'Inbox') {
      setState(() {
        headerType = 'Inbox';
      });
      Navigator.of(context).pushReplacementNamed(InboxScreenforWeb.routeName);
    } else if (type == 'Sent') {
      setState(() {
        headerType = 'Sent';
      });
      Navigator.of(context).pushReplacementNamed(InboxScreenforWeb.routeName);
    } else if (type == 'Private') {
      setState(() {
        headerType = 'Private';
      });
      Navigator.of(context)
          .pushReplacementNamed(SendPrivateMessageScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: homeAppBar(context, 1),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: mediaQuery.size.height,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                // this is always constant for any screen
                HeaderAppBarForInboxWeb(
                    decideTheTypeHandler: changeTheMsgType,
                    type: msgType,
                    decideTheHeaderTypeHandler: changeTheHeaderType,
                    headerType: headerType),

                Center(
                    child: SizedBox(
                  width: mediaQuery.size.width * 0.7,
                  child: Card(
                    color: ColorManager.darkGrey,
                    child: Container(
                      padding: const EdgeInsets.all(50),
                      width: mediaQuery.size.width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Send a private message',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: mediaQuery.size.width * 0.7,
                            child: DefaultTextField(
                              validator: (username) {
                                if (!Validator.validUserName(username!)) {
                                  return 'username must be greater than 2 in length';
                                } else {
                                  return null;
                                }
                              },
                              labelText: 'From: /u/username',
                              formController: _senderController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: mediaQuery.size.width * 0.7,
                            child: DefaultTextField(
                              validator: (reciverUserName) {
                                if (!Validator.validUserName(
                                    reciverUserName!)) {
                                  return 'username must be greater than 2 in length';
                                } else {
                                  return null;
                                }
                              },
                              labelText:
                                  'To: (username, or /r/name for that subreddit\'s moderators)',
                              formController: _recieverController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: mediaQuery.size.width * 0.7,
                            child: DefaultTextField(
                              validator: (subj) {
                                if (!Validator.validUserName(subj!)) {
                                  return 'subject must be greater than 2 in length';
                                } else {
                                  return null;
                                }
                              },
                              formController: _subjectController,
                              labelText: 'subject',
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: mediaQuery.size.width * 0.7,
                            child: DefaultTextField(
                              validator: (msg) {
                                if (!Validator.validUserName(msg!)) {
                                  return 'message must be greater than 2 in length';
                                } else {
                                  return null;
                                }
                              },
                              labelText: 'Message',
                              multiLine: true,
                              formController: _msgController,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: ColorManager.upvoteRed),
                              onPressed: sendTheMessage,
                              child: const Text('Send'),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                )),
              ]),
            ),
          ),
        ));
  }
}
