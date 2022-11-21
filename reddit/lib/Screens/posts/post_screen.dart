/// The Main Post Screen with the Comments
/// date: 8/11/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/widgets/posts/cubit/post_cubit.dart';
import 'package:reddit/widgets/posts/post_widget.dart';
import '../../cubit/post_notifier/post_notifier_cubit.dart';
import '../../cubit/post_notifier/post_notifier_state.dart';
import '../../data/post_model/post_model.dart';
import '../../widgets/posts/dropdown_list.dart';

/// The Screen that displays the indvidual Posts
///
/// it will contain the [PostWidget] and the [Comments]
class PostScreen extends StatefulWidget {
  static const String routeName = 'post_screen';
  const PostScreen({super.key, required this.post});

  /// The post to be displayed
  final PostModel post;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title!),
        actions: [
          BlocProvider(
            create: (context) => PostCubit(widget.post),
            child: BlocBuilder<PostNotifierCubit, PostNotifierState>(
              builder: (context, state) {
                return DropDownList(
                  postId: widget.post.id!,
                  itemClass: (widget.post.saved ?? true)
                      ? ItemsClass.publicSaved
                      : ItemsClass.public,
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PostWidget(
              post: widget.post,
              outsideScreen: false,
            ),
          ],
        ),
      ),
    );
  }
}
