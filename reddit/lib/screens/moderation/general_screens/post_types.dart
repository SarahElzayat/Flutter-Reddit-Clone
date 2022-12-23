///@author: Yasmine Ghanem
///@date:
///this screen is responsible for choosing the post types allowed in a community

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/bottom_sheet.dart';
import '../../../components/helpers/enums.dart';
import '../../../components/list_tile.dart';
import '../../../components/moderation_components/modtools_components.dart';
import '../cubit/moderation_cubit.dart';

class PostTypes extends StatefulWidget {
  static const String routeName = 'post_types';
  const PostTypes({super.key});

  @override
  State<PostTypes> createState() => _PostTypesState();
}

class _PostTypesState extends State<PostTypes> {
  bool isChanged = false;
  String postType = 'Any';

  enabledButton() {}

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              moderationAppBar(context, 'Post type', enabledButton, isChanged),
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              ListTileWidget(
                  leadingIcon: const Icon(Icons.post_add),
                  title: 'Post type options',
                  handler: () async {
                    postType = await modalBottomSheet(
                        context: context,
                        title: '',
                        text: ['Any', 'Text only', 'Link only'],
                        selectedItem: postType);
                    setState(() {});
                  },
                  tailingObj: TrailingObjects.dropBox),
              (postType == 'Text only')
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          rowSwitch('Image Links', cubit.imageLinks, (value) {
                        cubit.imageLinks = value;
                        setState(() {});
                      }),
                    ),
              (postType == 'Text only')
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          rowSwitch('Video links', cubit.videoLinks, (value) {
                        cubit.videoLinks = value;
                        setState(() {});
                      }),
                    ),
            ],
          ),
        );
      },
    );
  }
}
