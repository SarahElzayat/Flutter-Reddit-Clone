///@author: Yasmine Ghanem
///@date:
///this screen is for adding/editing the community welcome message

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/default_text_field.dart';
import '../../../../components/helpers/color_manager.dart';
import '../../../../components/moderation_components/modtools_components.dart';
import '../../cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddEditMessage extends StatefulWidget {
  static const String routeName = 'add_edit_message';
  const AddEditMessage({super.key});

  @override
  State<AddEditMessage> createState() => _AddEditMessageState();
}

class _AddEditMessageState extends State<AddEditMessage> {
  /// the actual welcome message of the community
  String welcomeMessage = 'Welcome Message';

  enabledButton() {}

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: moderationAppBar(
              context,
              'Add/Edit Message',
              () => cubit.updateCommunitySettings(context),
              cubit.messageChanged),
          body: Container(
            padding: const EdgeInsets.all(10),
            color: ColorManager.darkGrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    'Keep your message under 5000 charcters if you\'d like it to display as a propmpt right after joining'),
                SizedBox(height: 3.h),
                Text(
                  welcomeMessage,
                  style: TextStyle(fontSize: 20.sp),
                ),
                const Spacer(),
                DefaultTextField(
                    labelText: 'Welcome to out community',
                    formController: cubit.welcomeMessageController,
                    onChanged: (message) => cubit.onChangedWelcomeMessage())
              ],
            ),
          ),
        );
      },
    );
  }
}
