import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/button.dart';
import '../../../../components/moderation_components/modtools_components.dart';
import '../../cubit/moderation_cubit.dart';
import 'add_edit_message.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../components/helpers/color_manager.dart';

class WelcomeMessage extends StatefulWidget {
  static const String routeName = 'welcome_message';
  const WelcomeMessage({super.key});

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}

class _WelcomeMessageState extends State<WelcomeMessage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2.sp,
            shadowColor: ColorManager.white,
            title: const Text('Welcome Message'),
            backgroundColor: ColorManager.darkGrey,
            leading: IconButton(
                onPressed: () {
                  cubit.updateCommunitySettings(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: Container(
              // padding: const EdgeInsets.all(8),
              height: 30.h,
              color: ColorManager.darkGrey,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: rowSwitch('Send welcome message to new members',
                          cubit.sendMessageSwitch, (value) {
                        cubit.sendMessageSwitch = value;
                        setState(() {});
                      })),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'Create a custom message that new members will see as a prompt after joining and/or as a direct message to their inbox.',
                        style: TextStyle(
                            color: ColorManager.lightGrey, fontSize: 16.sp)),
                  ),
                  ListTile(
                    title: const Text('Add/Edit Message'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddEditMessage())),
                  ),
                  Button(
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: ((context) => Container(
                                width: 100.w,
                                height: 33.h,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: Center(
                                    child: Text(
                                        cubit.welcomeMessageController.text)),
                              ))),
                      text: 'PREVIEW MESSAGE',
                      splashColor: ColorManager.white.withOpacity(0.5),
                      buttonHeight: 5.h,
                      buttonWidth: 60.w)
                ],
              )),
        );
      },
    );
  }
}
