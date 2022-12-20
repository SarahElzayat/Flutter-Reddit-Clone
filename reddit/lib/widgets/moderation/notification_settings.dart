import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/button.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/moderation_components/modtools_components.dart';
import '../../screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModNotificationSettings extends StatelessWidget {
  const ModNotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        final ModerationCubit cubit = ModerationCubit.get(context);
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // contains the button to save changes
              Container(
                width: 80.w,
                height: 10.h,
                color: ColorManager.darkGrey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Button(
                        onPressed: () {},
                        text: 'Save changes',
                        buttonWidth: 10.w,
                        buttonHeight: 5.h,
                        textColor: ColorManager.black,
                        splashColor: Colors.transparent,
                        backgroundColor: ColorManager.eggshellWhite,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      color: ColorManager.black,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: 70.w,
                            color: ColorManager.darkGrey,
                            child: Flexible(
                              child: ListView(
                                padding: const EdgeInsets.all(20),
                                shrinkWrap: true,
                                children: [
                                  const Text('Mod notifications'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'MANAGE WHAT MOD NOTIFICATIONS ABOUT ${cubit.settings.communityName} YOU RECEIVE.',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.greyColor)),
                                  const Divider(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'Enabled',
                                      cubit.notificationsSwitch,
                                      (value) =>
                                          cubit.toggleModNotifications()),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text('COMMUNITY GROWTH',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.greyColor)),
                                  const Divider(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch('Milestones', cubit.milestoneSwitch,
                                      (value) => cubit.toggleMilestone()),
                                  Text('Cake days and membership milestones',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.textGrey)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch('Tips & Tricks', cubit.tipsSwitch,
                                      (value) => cubit.toggleTips()),
                                  Text(
                                      'Get tips and reminders to help you grow',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.textGrey)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
