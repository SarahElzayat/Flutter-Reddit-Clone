///@author: Yasmine Ghanem
///@date: 10/12/2022
///this screens approves a user in a subreddit

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';

// ignore: must_be_immutable
class AddApprovedUser extends StatelessWidget {
  static const String routeName = 'add_muted_user';
  const AddApprovedUser({super.key});

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: ((context, state) {}),
      builder: (context, state) => Scaffold(
        backgroundColor: (kIsWeb) ? ColorManager.darkGrey : ColorManager.black,
        appBar: userManagementAppBar(
            context, 'Add an approved user', () {}, (!cubit.emptyUsername)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Username'),
                const SizedBox(height: 15),
                SquareTextField(
                    formController: cubit.usernameController,
                    labelText: 'username',
                    prefix: const Text('u/'),
                    onChanged: (username) =>
                        cubit.buttonState(cubit.usernameController.text)),
                const SizedBox(height: 15),
                const Text(
                    'This user will be able to submit content to your community'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
