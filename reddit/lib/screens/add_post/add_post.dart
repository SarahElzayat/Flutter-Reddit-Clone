/// Model Add Post Screen
/// @author Haitham Mohamed
/// @date 4/11/2022

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:reddit/cubit/add_post/cubit/add_post_cubit.dart';
import 'package:reddit/cubit/subreddit/cubit/subreddit_cubit.dart';
import 'package:reddit/widgets/add_post/post_type_widget.dart';
import '../../../widgets/add_post/add_post_textfield.dart';

import '../../widgets/add_post/create_post_button.dart';
import '../../widgets/add_post/post_type_buttons.dart';
import 'community_search.dart';
import 'post_rules.dart';

/// This is the main screen in Add Post

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);
  static const routeName = '/add_post_screen_route';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    final navigator = Navigator.of(context);
    return WillPopScope(
      onWillPop: (() async {
        addPostCubit.onTapFunc(5, context, navigator, mediaQuery, isPop: true);
        return false;
      }),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  addPostCubit.onTapFunc(5, context, navigator, mediaQuery,
                      isPop: true);
                  // because this is the first screen this button exit the app
                  // when mearge this it will not be the first screen so
                  // remove the previous line code and uncomment the next line
                  // Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close)),
            actions: const [
              Padding(padding: EdgeInsets.all(8), child: CreatePostButton())
            ],
          ),
          body: SizedBox(
            height: mediaQuery.size.height,
            child: Column(children: [
              if (addPostCubit.subredditName != null &&
                  addPostCubit.subredditName != '')
                BlocBuilder<AddPostCubit, AddPostState>(
                  buildWhen: (previous, current) =>
                      (current is ChangeSubredditName ||
                          (previous is ChangeSubredditName)),
                  builder: (context, state) {
                    return Expanded(
                        child: MaterialButton(
                      onPressed: () {
                        navigator.pushNamed(CommunitySearch.routeName);
                      },
                      child: Row(
                        children: [
                          Text(addPostCubit.subredditName ?? '',
                              style: Theme.of(context).textTheme.titleSmall),
                          const Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ));
                  },
                ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AddPostTextField(
                      onChanged: ((string) {
                        addPostCubit.checkPostValidation();
                      }),
                      controller: addPostCubit.title,
                      mltiline: false,
                      isBold: true,
                      fontSize: (23 * mediaQuery.textScaleFactor).toInt(),
                      hintText: 'An intereting title')),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: PostTypeWidget(
                  keyboardIsOpened: (mediaQuery.viewInsets.bottom > 0),
                ),
              ),
              const Spacer(),
              PostTypeButtons(
                keyboardIsOpened: (mediaQuery.viewInsets.bottom > 0),
              ),
            ]),
          )),
    );
  }
}

// class AddPost extends StatefulWidget {
//   const AddPost({Key? key}) : super(key: key);

//   @override
//   State<AddPost> createState() => _AddPostState();
// }

// class _AddPostState extends State<AddPost> {

//   @override
//   Widget build(BuildContext context) {

//     return
//   }
// }
