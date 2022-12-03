/// Model Button
/// @author Haitham Mohamed
/// @date 4/11/2022

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/Screens/add_post/community_search.dart';
import 'package:reddit/Screens/add_post/post.dart';
import 'package:reddit/cubit/add_post.dart/cubit/add_post_cubit.dart';

import '../../Components/button.dart';
import '../../Components/Helpers/color_manager.dart';
import 'package:flutter/material.dart';

/// Button that navigate to the post screen after check the validation
class CreatePostButton extends StatelessWidget {
  const CreatePostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Boolean To Check the Validation
    bool isDisabled = true;
    final navigator = Navigator.of(context);
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<AddPostCubit, AddPostState>(
      buildWhen: (previous, current) {
        if (current is CanCreatePost) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is CanCreatePost) isDisabled = !(state.canPost);
        return Button(
            text: 'Next',
            borderRadius: 30,
            splashColor: Colors.transparent,
            textColor:
                (isDisabled) ? ColorManager.unselectedItem : ColorManager.white,
            backgroundColor:
                isDisabled ? ColorManager.darkGrey : ColorManager.blue,
            buttonWidth: 80,
            buttonHeight: 30,
            textFontSize: 17.0 * mediaQuery.textScaleFactor,
            onPressed: isDisabled
                ? () {}
                : (() {
                    navigator.pushNamed(CommunitySearch.routeName);
                  }));
      },
    );
  }
}
