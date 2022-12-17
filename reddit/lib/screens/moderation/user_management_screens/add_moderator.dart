///@author Yasmine Ghanem
///@date 07/12/2022
///invite a user to join community as moderator

import 'package:flutter/material.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/search_field.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddModerator extends StatefulWidget {
  static const String routeName = 'add_moderator';
  const AddModerator({super.key});

  @override
  State<AddModerator> createState() => _AddModeratorState();
}

class _AddModeratorState extends State<AddModerator> {
  bool isEmpty = true;
  TextEditingController controller = TextEditingController();
  String username = '';

  onChanged() {
    setState(() {
      username = controller.text;
      isEmpty = controller.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: ColorManager.white,
        elevation: 0.5,
        backgroundColor: ColorManager.darkGrey,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        title: const Text('Add a moderator'),
        actions: [
          Button(
            onPressed: () {},
            text: 'INVITE',
            textColor:
                (isEmpty == true) ? ColorManager.textGrey : ColorManager.blue,
            backgroundColor: ColorManager.darkGrey,
            disabled: isEmpty,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: 50.h,
        color: ColorManager.darkGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Username'),
            SizedBox(
              height: 2.h,
            ),
            SquareTextField(
              labelText: 'username',
              prefix: const Text('u/'),
              formController: controller,
              onChanged: (username) => onChanged,
              showSuffix: false,
            ),
            SizedBox(
              height: 3.h,
            ),
            const Text('Permissions')
          ],
        ),
      ),
    );
  }
}
