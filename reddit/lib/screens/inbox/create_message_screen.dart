import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../components/default_text_field.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/snack_bar.dart';
import '../../data/messages/send_message_model.dart';
import '../../data/sign_in_And_sign_up_models/validators.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';

class CreateMessageScreen extends StatefulWidget {
  static const routeName = '/creates_message_screen';
  const CreateMessageScreen({super.key});

  @override
  State<CreateMessageScreen> createState() => _CreateMessageScreenState();
}

class _CreateMessageScreenState extends State<CreateMessageScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  /// this is a utility function used to send the message to the required user.
  void sendTheMessage() async {
    if (!Validator.validUserName(userNameController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Username must be greate than 2 in length'));
      return;
    } else {
      // create the model to be sent
      SendMessageModel msg = SendMessageModel(
        isReply: false,
        receiverUsername: userNameController.text,
        // senderUsername: CacheHelper.getData(key: 'username'),
        subject: subjectController.text,
        text: messageController.text,
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

  final theAppBar = AppBar(
    title: const Text(
      'New message',
      style: TextStyle(color: ColorManager.upvoteRed),
    ),
    actions: [
      TextButton(
          onPressed: () {},
          child: const Text(
            'Send',
            style: TextStyle(color: ColorManager.upvoteRed),
          ))
    ],
  );
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorManager.upvoteRed,
        title: const Text(
          'New message',
          style: TextStyle(color: ColorManager.upvoteRed),
        ),
        actions: [
          TextButton(
              onPressed: () => sendTheMessage(),
              child: const Text(
                'Send',
                style: TextStyle(color: ColorManager.upvoteRed, fontSize: 18),
              ))
        ],
      ),
      body: SizedBox(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height -
            mediaQuery.padding.top -
            theAppBar.preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: [
            DefaultTextField(
              labelText: 'Username',
              formController: userNameController,
            ),
            DefaultTextField(
              labelText: 'Subject',
              formController: subjectController,
            ),
            Expanded(
              child: DefaultTextField(
                multiLine: true,
                labelText: 'Message',
                formController: messageController,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
