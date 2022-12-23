import 'package:flutter/material.dart';
import 'package:reddit/cubit/add_post/cubit/add_post_cubit.dart';
import 'package:reddit/screens/add_post/add_post_web.dart';

import '../../components/app_bar_components.dart';
import '../../components/helpers/color_manager.dart';

class CreatePostWidgetWeb extends StatelessWidget {
  const CreatePostWidgetWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Container(
        // margin: EdgeInsets.symmetric(vertical: 20),
        width: 200,
        height: 50,
        // color: ColorManager.red,
        color: ColorManager.darkGrey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(child: avatar(context: context)),
            Expanded(
              child: TextFormField(
                onTap: (() {
                  AddPostCubit.get(context).changePostType(postTypeIndex: 2);
                  navigator.pushNamed(AddPostWebScreen.routeName);
                }),
                decoration: InputDecoration(hintText: 'Create Post'),
                readOnly: true,
              ),
            ),
            IconButton(
              onPressed: () {
                AddPostCubit.get(context).changePostType(postTypeIndex: 0);
                navigator.pushNamed(AddPostWebScreen.routeName);
              },
              icon: Icon(Icons.image_outlined),
            ),
            IconButton(
              onPressed: () {
                AddPostCubit.get(context).changePostType(postTypeIndex: 3);
                navigator.pushNamed(AddPostWebScreen.routeName);
              },
              icon: Icon(Icons.attach_file),
            ),
          ],
        ));
  }
}
