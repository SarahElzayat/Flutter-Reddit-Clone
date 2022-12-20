import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostsCommentsSettings extends StatelessWidget {
  const PostsCommentsSettings({super.key});

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
                                  const Text('Post and comment settings'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('POSTS.',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.greyColor)),
                                  const Divider(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Post type options'),
                                      const Spacer(),
                                      DropdownButton(
                                        underline: Container(
                                            color: Colors.transparent),
                                        value: cubit.postOption,
                                        items: postOptions.map((item) {
                                          return DropdownMenuItem(
                                              value: item, child: Text(item));
                                        }).toList(),
                                        onChanged: (value) =>
                                            cubit.setPostType(value),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'Allow crossposting of posts',
                                      cubit.commentsSwitches['crossposting'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'crossposting', value)),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  rowSwitch(
                                      'Archive posts',
                                      cubit.commentsSwitches['archivePosts'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'archivePosts', value)),
                                  Text('Cake days and membership milestones',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.textGrey)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'Enable spoiler tag',
                                      cubit.commentsSwitches['spoilerTag'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'spoilerTag', value)),
                                  Text(
                                      'Media on posts with the spoiler tag are blurred',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.textGrey)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'Allow multiple images per post',
                                      cubit.commentsSwitches['multipleImages'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'multipleImages', value)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'Allow predictions',
                                      // true,
                                      cubit.commentsSwitches['predictions'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'predictions', value)),
                                  Text(
                                      'Allow predictions by mods in your community (only for public, SFW communities with 10k or more members',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.textGrey)),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text('COMMENTS.',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.greyColor)),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const Text('Suggested sort'),
                                      const Spacer(),
                                      DropdownButton(
                                        underline: Container(
                                            color: Colors.transparent),
                                        value: cubit.sort,
                                        items: suggestedSort.map((item) {
                                          return DropdownMenuItem(
                                              value: item, child: Text(item));
                                        }).toList(),
                                        onChanged: (value) =>
                                            cubit.setSuggestedSort(value),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'Collapse deleted and removed comments',
                                      cubit
                                          .commentsSwitches['collapseComments'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'collapseComments', value)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text('Media in comments'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'GIFs from GIPHY',
                                      cubit.commentsSwitches['giphy'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'giphy', value)),
                                  Text('Allow comments with GIFs from GIPHY.',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.textGrey)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'Images',
                                      cubit.commentsSwitches['images'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'images', value)),
                                  Text('Allow comments with uploaded images.',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: ColorManager.textGrey)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  rowSwitch(
                                      'GIFs',
                                      cubit.commentsSwitches['gifs'],
                                      (value) => cubit.toggleCommentSwitches(
                                          'gifs', value)),
                                  Text('Allow comments with uploaded GIFs.',
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
