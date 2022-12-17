import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommunitySettings extends StatelessWidget {
  const CommunitySettings({super.key});

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
                        onPressed: () => cubit.updateSettings(context),
                        text: 'Save changes',
                        buttonWidth: 10.w,
                        buttonHeight: 5.h,
                        textColor: ColorManager.black,
                        splashColor: Colors.transparent,
                        disabled: cubit.isChanged,
                        isPressable: cubit.isChanged,
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
                                padding: EdgeInsets.all(20),
                                shrinkWrap: true,
                                children: [
                                  const Text('Community settings'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('COMMUNITY PROFILE',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.greyColor)),
                                  const Divider(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text('Community name'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SquareTextField(
                                    labelText: 'community name',
                                    maxLength: 90,
                                    formController: cubit.usernameController,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const Text('Community topics'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'This will help Reddit recommend your community to relevant users and other discovery experiences.',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorManager.textGrey),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  DropdownButton(
                                    underline:
                                        Container(color: Colors.transparent),
                                    value: cubit.communityTopic,
                                    items: topicsTitles.map((item) {
                                      return DropdownMenuItem(
                                          value: item, child: Text(item));
                                    }).toList(),
                                    onChanged: (chosenTopic) =>
                                        cubit.setCommunityTopic(chosenTopic),
                                  ),
                                  const Text('Community description'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'This is how new members come to understand your community.',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorManager.textGrey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SquareTextField(
                                    labelText: '',
                                    maxLength: 500,
                                    formController: cubit.descriptionController,
                                    onChanged: (description) =>
                                        cubit.onChanged(),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  rowSwitch(
                                      'Send welcome message to new members',
                                      cubit.settings.sendWelcomeMessage ??
                                          false,
                                      (value) =>
                                          cubit.toggleMessageSwitch(value)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Create a custom welcome message to greet people the instant they join your community. New community members will see this in a direct message 1 hour after joining.',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorManager.textGrey),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text('COMMUNITY LOCATION AND MAIN LANGUAGE',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.greyColor)),
                                  const Divider(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Adding a location helps your community show up in search results and recommendations and helps local redditors find it easier.',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorManager.textGrey),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // pick a language for the subreddit
                                  const Text('Language'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButton(
                                    underline:
                                        Container(color: Colors.transparent),
                                    value: cubit.settings.language,
                                    items: languages.map((item) {
                                      return DropdownMenuItem(
                                          value: item, child: Text(item));
                                    }).toList(),
                                    onChanged: (value) =>
                                        cubit.setCommunityLanguage(value),
                                  ),
                                  // pick a region for the subreddit
                                  const Text('Region'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButton(
                                    underline:
                                        Container(color: Colors.transparent),
                                    value: cubit.settings.region,
                                    items: regions.map((item) {
                                      return DropdownMenuItem(
                                          value: item, child: Text(item));
                                    }).toList(),
                                    onChanged: (value) =>
                                        cubit.setCommunityRegion(value),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  // chooses community type
                                  Text('COMMUNITY TYPE',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.greyColor)),
                                  const Divider(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  // chooses whether community is nsfw of not
                                  rowSwitch(
                                      '18+ year old community',
                                      cubit.settings.nSFW ?? false,
                                      (value) => cubit.toggleNSFWSwitch(value)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'When your community is marked as an 18+ community, users must be flagged as 18+ in their user settings',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: ColorManager.textGrey),
                                  ),
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
