///@author Yasmine Ghanem
///@date 12/12/2022
///invite a user to join community as moderator

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InviteModerator extends StatelessWidget {
  static const String routeName = 'invite_moderator';
  InviteModerator({super.key});

  ///controller that controls the username being added
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          return Scaffold(
            appBar: userManagementAppBar(context, 'Add a moderator', () {
              cubit.inviteModerator(context);
            }, (!cubit.emptyModUsername)),
            body: Container(
              color: ColorManager.darkGrey,
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Username'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 8.h,
                    child: SquareTextField(
                        formController: cubit.usernameController,
                        onChanged: (username) =>
                            cubit.modButtonState(cubit.usernameController.text),
                        showSuffix: false,
                        labelText: 'username',
                        prefix: const Text('u/')),
                  ),
                  const SizedBox(height: 15),
                  const Text('Permissions'),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: ColorManager.black,
                          activeColor: ColorManager.blue,
                          value: cubit.isFullPermissions,
                          onChanged: (check) => cubit.togglePermissions(-1)),
                      const Text('Full Permissions')
                    ],
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Checkbox(
                                    checkColor: ColorManager.black,
                                    activeColor: ColorManager.blue,
                                    value: cubit.permissionValues[index],
                                    onChanged: (check) =>
                                        cubit.togglePermissions(index)),
                                Text(cubit.permissions[index]),
                                const Spacer(),
                                Checkbox(
                                    checkColor: ColorManager.black,
                                    activeColor: ColorManager.blue,
                                    value: cubit.permissionValues[index + 4],
                                    onChanged: (check) =>
                                        cubit.togglePermissions(index + 4)),
                                Text(cubit.permissions[index + 4]),
                                const Spacer()
                              ],
                            );
                          }))
                ],
              ),
            ),
          );
        }));
  }
}
