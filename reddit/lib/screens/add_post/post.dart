/// Model Simple Post Screen
/// @author Haitham Mohamed
/// @date 11/11/2022

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/add_post/cubit/add_post_cubit.dart';

/// Simple Post Screen That Show only Details of the post
class PostSimpleScreen extends StatelessWidget {
  const PostSimpleScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/post_simple_screen_route';

  @override
  Widget build(BuildContext context) {
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Title : ${addPostCubit.title.text}'),
          Text('Text Body : ${addPostCubit.optionalText.document.toDelta()}'),
          Text('Number of Image : ${addPostCubit.images.length}'),
          Text('Has Link : ${addPostCubit.link.text}'),
          Text('Number of Poll options : ${addPostCubit.poll.length}'),
        ]),
      ),
    );
  }
}
