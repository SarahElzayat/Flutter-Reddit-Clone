/// Model Post Rules Screen
/// @author Haitham Mohamed
/// @date 2/12/2022
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/screens/add_post/schedule_date.dart';
import 'package:reddit/screens/add_post/subreddit_flair.dart';
import 'package:reddit/screens/main_screen.dart';

import '../../components/button.dart';
import '../../constants/constants.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';
import 'community_search.dart';

class PostRules extends StatefulWidget {
  const PostRules({Key? key}) : super(key: key);

  static const routeName = '/post_rules_route';

  @override
  State<PostRules> createState() => _PostRulesState();
}

/// Select if Post is NSFW or Spoiler and show some Rules
class _PostRulesState extends State<PostRules> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    final navigator = Navigator.of(context);
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is PostCreated) {
          navigator.pushReplacementNamed(HomeScreenForMobile.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigator.pop();
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Button(
                  text: 'Post',
                  splashColor: Colors.transparent,
                  textColor: ColorManager.white,
                  backgroundColor: ColorManager.blue,
                  buttonWidth: 80,
                  buttonHeight: 80,
                  textFontSize: 20,
                  onPressed: () async {
                    await addPostCubit.createPost(context);
                    addPostCubit.removeExistData();
                    addPostCubit.addSubredditName(null);
                    addPostCubit.title.text = '';
                    addPostCubit.nsfw = false;
                    addPostCubit.spoiler = false;
                    addPostCubit.isSubreddit = true;
                  }),
            )
          ],
        ),
        body: Column(children: [
          Row(
            children: [
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  navigator.pushNamed(CommunitySearch.routeName);
                },
                child: Row(
                  children: [
                    Text(
                        (addPostCubit.isSubreddit)
                            ? addPostCubit.subredditName!
                            : 'My Profile',
                        style: Theme.of(context).textTheme.titleSmall),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              )),
              MaterialButton(
                onPressed: (() {}),
                child: Text(
                  'Rules',
                  style: TextStyle(
                      fontSize: 18 * mediaQuery.textScaleFactor,
                      color: ColorManager.blue),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.lightGrey),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    addPostCubit.title.text,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Icon(icons[
                    addPostCubit.postType == 5 ? 2 : addPostCubit.postType])
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              nfswAndSpoiler(false, addPostCubit.nsfw, '(18) NSFW',
                  addPostCubit, mediaQuery),
              nfswAndSpoiler(true, addPostCubit.spoiler, ' Spoiler',
                  addPostCubit, mediaQuery)
            ],
          ),
          TextButton(
              onPressed: () {
                navigator.push(MaterialPageRoute(
                    builder: ((context) => const ScheduleDate())));
              },
              child: Row(
                children: const [
                  Text('Schedule Post '),
                  Icon(Icons.arrow_forward_outlined)
                ],
              )),
          if (addPostCubit.isSubreddit &&
              addPostCubit.flairs!.postFlairs!.isNotEmpty)
            TextButton(
                onPressed: () {
                  navigator.push(MaterialPageRoute(
                      builder: ((context) => const SubredditFlairs())));
                },
                child: Row(
                  children: const [
                    Icon(Icons.local_offer_outlined),
                    Text(' Add Flair'),
                  ],
                ))
        ]),
      ),
    );
  }

  Widget nfswAndSpoiler(bool nfswOrSpoiler, bool selected, String text,
      AddPostCubit addPostCubit, MediaQueryData mediaQuery) {
    return GestureDetector(
      onTap: (() {
        setState(() {
          if (nfswOrSpoiler) {
            addPostCubit.spoiler = !addPostCubit.spoiler;
          } else {
            addPostCubit.nsfw = !addPostCubit.nsfw;
          }
        });
      }),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? ColorManager.eggshellWhite : ColorManager.greyBlack,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            if (nfswOrSpoiler)
              Icon(
                Icons.error_outline,
                color:
                    selected ? ColorManager.black : ColorManager.eggshellWhite,
              ),
            Text(
              text,
              style: TextStyle(
                fontSize: 18 * mediaQuery.textScaleFactor,
                color:
                    selected ? ColorManager.black : ColorManager.eggshellWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
