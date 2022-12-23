import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/helpers/color_manager.dart';
import '../../components/home_app_bar.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';
import '../../widgets/add_post/add_post_textfield.dart';
import '../../widgets/add_post/create_post_button.dart';
import '../../widgets/add_post/post_type_buttons.dart';
import '../../widgets/add_post/post_type_widget.dart';
import 'community_search.dart';


/// Add Post Screen For Web
class AddPostWebScreen extends StatefulWidget {
  const AddPostWebScreen({Key? key}) : super(key: key);

  @override
  State<AddPostWebScreen> createState() => _AddPostWebScreenState();

  static const routeName = '/add_post_web_screen_route';
}

class _AddPostWebScreenState extends State<AddPostWebScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    return Scaffold(
      appBar: homeAppBar(context, 0),
      body: ListView(children: [
        SizedBox(
          width: mediaQuery.size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (mediaQuery.size.width > 1000)
                SizedBox(
                  width: mediaQuery.size.width * 0.15,
                ),
              Container(
                width: (mediaQuery.size.width > 1000)
                    ? mediaQuery.size.width * 0.45
                    : mediaQuery.size.width * 0.95,
                margin: (mediaQuery.size.width <= 1000)
                    ? EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.02)
                    : null,
                child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(children: [
                        PostTypeButtons(
                          keyboardIsOpened: false,
                        ),
                        const SizedBox(
                          height: 10,
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
                                fontSize:
                                    (23 * mediaQuery.textScaleFactor).toInt(),
                                hintText: 'Title')),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          // height: mediaQuery.size,
                          child: PostTypeWidget(
                            keyboardIsOpened: false,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            nfswAndSpoiler(false, addPostCubit.nsfw,
                                '(18) NSFW', addPostCubit, mediaQuery),
                            nfswAndSpoiler(true, addPostCubit.spoiler,
                                ' Spoiler', addPostCubit, mediaQuery)
                          ],
                        ),
                        const CreatePostButton(),
                      ]),
                    ]),
              ),
              if (mediaQuery.size.width > 1000)
                SizedBox(
                  width: mediaQuery.size.width * 0.1,
                ),
              // if (mediaQuery.size.width <= 1000)
              //   SizedBox(
              //     width: mediaQuery.size.width * 0.2,
              //   ),
              if (mediaQuery.size.width > 1000)
                Container(
                  color: ColorManager.bottomSheetBackgound,
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: mediaQuery.size.width * 0.2,
                  child: Column(
                    children: [
                      BlocBuilder<AddPostCubit, AddPostState>(
                        buildWhen: (previous, current) {
                          if (previous is ChangeSubredditName ||
                              current is ChangeSubredditName) {
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text((!addPostCubit.isSubreddit)
                                  ? 'My Profile'
                                  : addPostCubit.subredditName ??
                                      'No Subreddit Selected'),
                              IconButton(
                                  onPressed: () {
                                    addPostCubit
                                        .clearSelectedSubredditOrProfile();
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          );
                        },
                      ),
                      const CommunitySearch()

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Text(
                      //       'About Community',
                      //       style: TextStyle(color: ColorManager.eggshellWhite),
                      //     ),
                      //     PopupMenuButton(
                      //       itemBuilder: (context) => [
                      //         const PopupMenuItem(
                      //             child: Text('Add To Favorites')),
                      //       ],
                      //     )
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // const Text(
                      //   'Welcome! This is a friendly place for those cringe-worthy and (maybe) funny attempts at humour that we call dad jokes. Often (but not always) a verbal or visual pun, if it elicited a snort or face palm then our community is ready to groan along with you. To be clear, dad status is not a requirement. We\'re all different and excellent. Some people are born with lame jokes in their heart and so here, everyone is a dad. Some dads are wholesome, some are not. It\'s about how the joke is delivered.',
                      //   style: TextStyle(
                      //       color: ColorManager.eggshellWhite, height: 1.5),
                      // )
                    ],
                  ),
                )
            ],
          ),
        )
        // Expanded(
        //   // width: mediaQuery.size.width,
        //   // height: mediaQuery.size.height,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.max,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       SizedBox(
        //         width: mediaQuery.size.width * 0.5,
        //         child:
        //       ),
        //     ],
        //   ),
        // ),
      ]),
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
