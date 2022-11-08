/// Model Button
/// @author Haitham Mohamed
/// @date 4/11/2022

import '../../Components/Helpers/color_manager.dart';
import 'package:flutter/material.dart';

import '../../screens/add_post/post.dart';

import '../../variable/global_varible.dart';

/// Button that navigate to the post screen after check the validation
/// Note I pass this parameter to used in post screen
/// I use this now for simplify the code that i want to check that
/// all packages are work will and can get the output from them or not
/// And It will be change and use Bloc instead
class Button extends StatefulWidget {
  /// [textController] Optional Text controller
  TextEditingController textController;

  /// [urlController] URL textField controller
  TextEditingController urlController;

  /// [pollTextController] Optional poll Text controller
  TextEditingController pollTextController;

  /// [titleController] Title textField controller
  TextEditingController titleController;

  /// [pollController] Controller for each option in poll <List> (min 2 options)
  List<TextEditingController> pollController = <TextEditingController>[
    TextEditingController(),
    TextEditingController()
  ];
  Button({
    Key? key,
    required this.textController,
    required this.urlController,
    required this.pollTextController,
    required this.titleController,
    required this.pollController,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalVarible.isEmpty,
      builder: (context, value, child) => MaterialButton(
        onPressed: value
            ? null
            : () => Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => PostSimpleScreen(
                      link: widget.urlController.text,
                      title: widget.titleController.text,
                      textBody: widget.textController.text,
                      numImages: GlobalVarible.images.value.length,
                      numPoll: widget.pollController.length,
                      hasVideos: GlobalVarible.video.value != null,
                    )))),
        minWidth: 25,
        color: ColorManager.blue,
        disabledColor: ColorManager.textFieldBackground,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: Text(
          'Next',
          style:
              TextStyle(fontSize: 17 * MediaQuery.of(context).textScaleFactor),
        ),
      ),
    );
  }
}
