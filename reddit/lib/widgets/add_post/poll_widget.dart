// ignore_for_file: public_member_api_docs, sort_constructors_first

/// Model Poll Widget
/// @author Haitham Mohamed
/// @date 4/11/2022

import '../../components/helpers/color_manager.dart';
import 'package:flutter/material.dart';

import 'add_post_textfield.dart';

/// Poll widget that show the options and can add or delete
/// Note Minimum number of Options is 2

// ignore: must_be_immutable
class Poll extends StatefulWidget {
  /// [pollController] Controller for each option
  /// in poll <List> (min 2 options)
  List<TextEditingController> pollController;

  /// [textController] Options poll Text controller
  TextEditingController textController;
  bool isOpen;
  Poll({
    Key? key,
    required this.pollController,
    required this.textController,
    required this.isOpen,
  }) : super(key: key);

  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: (widget.isOpen)
              ? mediaQuery.size.height * 0.44
              : mediaQuery.size.height * 0.55),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                AddPostTextField(
                    isTitle: false,
                    mltiline: true,
                    isBold: false,
                    fontSize: (18 * mediaQuery.textScaleFactor).toInt(),
                    hintText: 'Add optional body text',
                    controller: widget.textController),
                for (int index = 0;
                    index < widget.pollController.length;
                    index++)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: mediaQuery.size.width * 0.945),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  color: ColorManager.textFieldBackground,
                                  child: AddPostTextField(
                                      isTitle: false,
                                      mltiline: false,
                                      isBold: false,
                                      fontSize:
                                          (18 * mediaQuery.textScaleFactor)
                                              .toInt(),
                                      hintText: 'Opition ${index + 1}',
                                      controller: widget.pollController[index]),
                                ),
                              ),
                              if (index > 1)
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.pollController.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.close))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: ColorManager.textFieldBackground,
                  child: InkWell(
                    onTap: widget.pollController.length == 6
                        ? null
                        : () {
                            setState(() {
                              if (widget.pollController.length < 6) {
                                widget.pollController
                                    .add(TextEditingController());
                              }
                            });
                          },
                    child: Row(
                      children: [
                        const Icon(Icons.add),
                        Text(
                          'Add option',
                          style: TextStyle(
                              fontSize: 17 * mediaQuery.textScaleFactor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
