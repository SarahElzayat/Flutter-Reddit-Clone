/// Model Poll Widget
/// @author Haitham Mohamed
/// @date 4/11/2022
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/helpers/color_manager.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';
import 'add_post_textfield.dart';

/// Poll widget that show the options and can add or delete
/// Note Minimum number of Options is 2
class Poll extends StatefulWidget {
  /// Check if the Keyboard Is Opened
  bool isOpen;
  Poll({
    Key? key,
    required this.isOpen,
  }) : super(key: key);

  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
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
                  onChanged: ((string) {
                    addPostCubit.checkPostValidation();
                  }),
                  controller: addPostCubit.optionalText,
                  mltiline: true,
                  isBold: false,
                  fontSize: (18 * mediaQuery.textScaleFactor).toInt(),
                  hintText: 'Add optional body text',
                ),
                for (int index = 0; index < addPostCubit.poll.length; index++)
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
                                    onChanged: ((string) {
                                      addPostCubit.checkPostValidation();
                                    }),
                                    controller: addPostCubit.poll[index],
                                    // textfieldType: TextfieldType.poll,
                                    mltiline: false,
                                    isBold: false,
                                    fontSize: (18 * mediaQuery.textScaleFactor)
                                        .toInt(),
                                    hintText: 'Opition ${index + 1}',
                                    index: index,
                                  ),
                                ),
                              ),
                              if (index > 1)
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        addPostCubit.poll.removeAt(index);
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
                    onTap: addPostCubit.poll.length == 6
                        ? null
                        : () {
                            setState(() {
                              if (addPostCubit.poll.length < 6) {
                                addPostCubit.poll.add(TextEditingController());
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
