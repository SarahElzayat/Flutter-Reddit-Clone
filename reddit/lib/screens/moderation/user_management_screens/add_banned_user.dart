///@author: Yasmine Ghanem
///@date: 10/12/2022
///this screens bans a user from a subreddit

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/bottom_sheet.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddBannedUser extends StatelessWidget {
  static const String routeName = 'add_banned_user';
  AddBannedUser({super.key});
  late dynamic reason = 'Pick a reason';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController modNoteController = TextEditingController();
  final TextEditingController userNoteController = TextEditingController();
  String modNote = '';
  String userNote = '';

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: ((context, state) {}),
      builder: (context, state) => Scaffold(
        appBar: userManagementAppBar(context, 'Add a banned user', () {
          cubit.banUser(context, daysController.text, modNote, userNote);
        }, (!cubit.emptyReason && !cubit.emptyUsername)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Username'),
                const SizedBox(height: 15),
                SquareTextField(
                    formController: usernameController,
                    labelText: 'username',
                    prefix: const Text('u/'),
                    onChanged: (username) =>
                        cubit.buttonState(usernameController.text)),
                const SizedBox(height: 15),
                const Text('Reason for ban'),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    reason = await modalBottomSheet(
                      context: context,
                      title: 'Reason for ban',
                      text: banReasons,
                      selectedItem: cubit.banReason,
                    );
                    cubit.setBanReason(reason);
                  },
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(reason,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600)),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text('Mod note'),
                const SizedBox(height: 15),
                SquareTextField(
                    labelText: 'Only mods will see this',
                    formController: modNoteController),
                const SizedBox(height: 15),
                const Text('How long?'),
                const SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(
                        height: 50,
                        width: 100,
                        child: SquareTextField(
                            onChanged: (check) =>
                                cubit.checkDays(daysController.text),
                            labelText: '',
                            showSuffix: false,
                            keyboardType: TextInputType.number,
                            formController: daysController)),
                    const SizedBox(width: 10),
                    const Text('Days'),
                    const SizedBox(width: 15),
                    Checkbox(
                        activeColor: ColorManager.blue,
                        value: cubit.permenant,
                        onChanged: (check) => cubit.togglePermenant()),
                    const Text('Permenant')
                  ],
                ),
                const SizedBox(height: 15),
                const Text('Note to include in ban'),
                const SizedBox(height: 15),
                SquareTextField(
                    labelText: 'The user will receive this note in a message',
                    formController: userNoteController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
