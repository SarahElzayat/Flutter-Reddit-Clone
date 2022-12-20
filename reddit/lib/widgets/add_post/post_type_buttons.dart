/// Model Post Buttons Type
/// @author Haitham Mohamed
/// @date 4/11/2022

import '../../screens/add_post/image_screen.dart';
import '../../components/helpers/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/add_post/cubit/add_post_cubit.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../screens/add_post/video_trimmer.dart';

/// Post Type Buttons is the Widget that can select the post type
/// That on the Bottom of the add post Screeen
// ignore: must_be_immutable
class PostTypeButtons extends StatefulWidget {
  /// [keyboardIsOpened]Boolen to Know if the keyboard is opened or not
  /// because if it is opened the Buttons will change to be smaller
  bool keyboardIsOpened;

  PostTypeButtons({
    Key? key,
    required this.keyboardIsOpened,
  }) : super(key: key);

  @override
  State<PostTypeButtons> createState() => _PostTypeButtonsState();
}

class _PostTypeButtonsState extends State<PostTypeButtons> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    return Container(
        color: ColorManager.darkGrey,
        child: BlocConsumer<AddPostCubit, AddPostState>(
          listener: (context, state) {
            if (state is EditVideo) {
              Navigator.of(context).pushNamed(TrimmerView.routeName);
            } else if (state is PreviewImage) {
              navigator.pushNamed(ImageScreen.routeName);
            }
          },
          buildWhen: ((previous, current) {
            if (current is PostTypeChanged) {
              if (previous is PostTypeChanged &&
                  previous.postType == current.getPostType) {
                return false;
              } else {
                return true;
              }
            } else {
              return false;
            }
          }),
          builder: (context, state) {
            return Container(
              child: widget.keyboardIsOpened
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          for (int index = 0; index < 4; index++)
                            InkWell(
                              onTap: (() {
                                addPostCubit.onTapFunc(
                                    index, context, navigator, mediaQuery);
                              }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  (index == addPostCubit.postType)
                                      ? selectedIcons[index]
                                      : icons[index],
                                  size: 32 * mediaQuery.textScaleFactor,
                                  color: (index == addPostCubit.postType)
                                      ? Colors.blue
                                      : Colors.white,
                                ),
                              ),
                            )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        for (int index = 0; index < 4; index++)
                          InkWell(
                            onTap: (() {
                              addPostCubit.onTapFunc(
                                  index, context, navigator, mediaQuery);
                            }),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Icon(
                                      (index == addPostCubit.postType)
                                          ? selectedIcons[index]
                                          : icons[index],
                                      size: 25 * mediaQuery.textScaleFactor,
                                    ),
                                  ),
                                  Text(
                                    labels[index],
                                    style: TextStyle(
                                        fontWeight:
                                            (index == addPostCubit.postType)
                                                ? FontWeight.w700
                                                : FontWeight.w200,
                                        fontSize:
                                            20 * mediaQuery.textScaleFactor),
                                  ),
                                  const Spacer(),
                                  if (index == addPostCubit.postType)
                                    const Icon(
                                      Icons.done,
                                      color: Colors.blue,
                                    )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
            );
          },
        ));
  }
}
