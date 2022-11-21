/// Model Post Buttons Type
/// @author Haitham Mohamed
/// @date 4/11/2022

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Components/Button.dart';
import 'package:reddit/cubit/add_post.dart/cubit/add_post_cubit.dart';

import '../../Components/Helpers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_painter/image_painter.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/constants.dart';
import '../../functions/add_post.dart';

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
        color: ColorManager.textFieldBackground,
        child: BlocBuilder<AddPostCubit, AddPostState>(
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
                          for (int index = 0; index < 5; index++)
                            InkWell(
                              onTap: (() {
                                onTapFunc(
                                    index, addPostCubit, navigator, mediaQuery);
                              }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(
                                  icons[index],
                                  size: 32 * mediaQuery.textScaleFactor,
                                  color: (state is PostTypeChanged &&
                                          index == state.getPostType)
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
                        for (int index = 0; index < 5; index++)
                          InkWell(
                            onTap: (() {
                              onTapFunc(
                                  index, addPostCubit, navigator, mediaQuery);
                            }),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 7),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Icon(
                                      icons[index],
                                      size: 25 * mediaQuery.textScaleFactor,
                                    ),
                                  ),
                                  Text(
                                    labels[index],
                                    style: TextStyle(
                                        fontSize:
                                            20 * mediaQuery.textScaleFactor),
                                  ),
                                  const Spacer(),
                                  if (state is PostTypeChanged &&
                                      index == state.getPostType)
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

  /// Show TO User If Change The Post Type And the Exist Data in the current
  /// Post type it Show Pop-up to Choose if continue and remove the data or Not
  onTapFunc(int index, AddPostCubit addPostCubit, NavigatorState navigator,
      MediaQueryData mediaQuery) {
    if (addPostCubit.discardCheck()) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                backgroundColor: ColorManager.grey,
                insetPadding: EdgeInsets.zero,
                title: const Text('Change Post Type'),
                content: Text(
                  'Some of your post will be deleted if you continue',
                  style: TextStyle(fontSize: 15 * mediaQuery.textScaleFactor),
                ),
                actions: [
                  SizedBox(
                    width: mediaQuery.size.width * 0.42,
                    child: Button(
                      onPressed: () {
                        navigator.pop();
                        return;
                      },
                      text: ('Cancel'),
                      textColor: ColorManager.lightGrey,
                      backgroundColor: Colors.transparent,
                      buttonWidth: mediaQuery.size.width * 0.42,
                      buttonHeight: 40,
                      textFontSize: 15,
                      boarderRadius: 20,
                    ),
                  ),
                  SizedBox(
                    width: mediaQuery.size.width * 0.42,
                    child: Button(
                      onPressed: () {
                        addPostCubit.removeExistData();

                        navigator.pop();
                        if (index == 0 && addPostCubit.postType != index) {
                          chooseSourceWidget(context, mediaQuery, navigator);
                        } else if (index == 1 &&
                            addPostCubit.postType != index) {
                          videoFunc(context);
                        }
                        addPostCubit.changePostType(postTypeIndex: index);
                      },
                      text: ('Containue'),
                      textColor: ColorManager.white,
                      backgroundColor: ColorManager.red,
                      buttonWidth: mediaQuery.size.width * 0.42,
                      buttonHeight: 40,
                      textFontSize: 15,
                      boarderRadius: 20,
                    ),
                  ),
                ],
              )));
    } else {
      if (index == 0 && addPostCubit.postType != index) {
        chooseSourceWidget(
          context,
          mediaQuery,
          navigator,
        );
      } else if (index == 1 && addPostCubit.postType != index) {
        videoFunc(context);
      }
      addPostCubit.changePostType(postTypeIndex: index);
    }
  }
}
