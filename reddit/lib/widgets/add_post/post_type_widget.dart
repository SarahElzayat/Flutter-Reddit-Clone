/// Model Post Type widget
/// @author Haitham Mohamed
/// @date 4/11/2022
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/add_post.dart/cubit/add_post_cubit.dart';
import 'add_post_textfield.dart';
import 'image.dart';
import 'poll_widget.dart';
import 'video.dart';

/// This widget is used to show the widget in post screen
/// according to its type
/// Is just Inteface (No Implementation here)

// ignore: must_be_immutable
class PostTypeWidget extends StatelessWidget {
  /// [keyboardIsOpened]Boolen to Know if the keyboard is opened or not
  /// because if it is opened the Buttons will change to be smaller
  bool keyboardIsOpened;
  PostTypeWidget({
    Key? key,
    required this.keyboardIsOpened,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    return BlocBuilder<AddPostCubit, AddPostState>(
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
        if (state is PostTypeChanged) {
          switch (state.getPostType) {
            case 0:
              return const ImageWidget();
            case 1:
              return const VideoPost();

            case 2:
              return AddPostTextField(
                  controller: addPostCubit.optionalText,
                  mltiline: true,
                  isBold: false,
                  fontSize: 18,
                  hintText: 'Add optional body text');
            case 3:
              return AddPostTextField(
                  controller: addPostCubit.link,
                  mltiline: true,
                  isBold: false,
                  fontSize: 18,
                  hintText: 'URL');
            case 4:
              return Poll(
                isOpen: keyboardIsOpened,
              );
            default:
              return const SizedBox();
          }
        }
        return const SizedBox();
      },
    );
  }
}
