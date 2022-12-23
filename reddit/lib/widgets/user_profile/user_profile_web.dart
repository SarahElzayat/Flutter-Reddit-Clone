import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/button.dart';
import '../../components/helpers/color_manager.dart';
import 'package:reddit/screens/history/history_downvoted_web.dart';
import 'package:reddit/screens/history/history_hidden_web.dart';
import 'package:reddit/screens/history/history_recent_web.dart';
import 'package:reddit/screens/history/history_upvoted_web.dart';
import 'package:reddit/screens/saved/saved_comments.dart';
import 'package:reddit/screens/saved/saved_posts.dart';
import '../../components/home_app_bar.dart';
import '../../components/home_components/functions.dart';
import '../../components/home_components/left_drawer.dart';
import '../../components/home_components/right_drawer.dart';
import '../../cubit/app_cubit/app_cubit.dart';
import '../../cubit/user_profile/cubit/user_profile_cubit.dart';
import '../../networks/constant_end_points.dart';
import '../../screens/user_profile/user_profile_edit_screen.dart';
import '../../shared/local/shared_preferences.dart';
import 'user_profile_comments.dart';
import 'user_profile_posts.dart';


/// User Profile Screen For Web
class UserProfileWeb extends StatefulWidget {
  const UserProfileWeb({Key? key}) : super(key: key);

  @override
  State<UserProfileWeb> createState() => _UserProfileWebState();
  static const routeName = '/user_profile_web_screen_route';
}

class _UserProfileWebState extends State<UserProfileWeb>
    with SingleTickerProviderStateMixin {
  late TabController controller =
      TabController(length: isMyProfile ? 8 : 2, vsync: this);
  late bool isMyProfile;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///opens/closes the end drawer
  void endDrawer() {
    changeEndDrawer(_scaffoldKey);
  }

  ///opens/closes the drawer
  void drawer() {
    changeLeftDrawer(_scaffoldKey);
  }

  @override
  void initState() {
    if (CacheHelper.getData(key: 'username') ==
        UserProfileCubit.get(context).username) {
      isMyProfile = true;
    } else {
      isMyProfile = false;
    }
    final userProfileCubit = UserProfileCubit.get(context);

    userProfileCubit.postController = PagingController(firstPageKey: null);
    userProfileCubit.postController.addPageRequestListener((pageKey) {
      userProfileCubit.fetchPosts(
        after: pageKey,
      );
    });
    userProfileCubit.commentController = PagingController(firstPageKey: null);
    userProfileCubit.commentController.addPageRequestListener((pageKey) {
      userProfileCubit.fetchComments(
        after: pageKey,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    // final AppCubit cubit = AppCubit.get(context);
    return BlocListener<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ChangeRightDrawerState) {
          endDrawer();
        }
        if (state is ChangeLeftDrawerState) {
          drawer();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const LeftDrawer(),
        endDrawer: const RightDrawer(),
        appBar: homeAppBar(
          context,
          0,
        ),
        body: ListView(
          children: [
            TabBar(
                controller: controller,
                tabs: isMyProfile
                    ? const [
                        Tab(
                          text: 'Posts',
                        ),
                        Tab(
                          text: 'Comments',
                        ),
                        Tab(
                          text: 'History',
                        ),
                        Tab(
                          text: 'Upvoted',
                        ),
                        Tab(
                          text: 'Downvoted',
                        ),
                        Tab(
                          text: 'Hidden',
                        ),
                        Tab(
                          text: 'Saved posts',
                        ),
                        Tab(
                          text: 'Saved comments',
                        ),
                      ]
                    : const [
                        Tab(
                          text: 'Posts',
                        ),
                        Tab(
                          text: 'Comments',
                        ),
                      ]),
            SizedBox(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: (mediaQuery.size.width > 1000)
                          ? mediaQuery.size.width * 0.7
                          : mediaQuery.size.width * 0.95,
                      margin: (mediaQuery.size.width <= 1000)
                          ? EdgeInsets.symmetric(
                              horizontal: mediaQuery.size.width * 0.02)
                          : null,
                      child: TabBarView(
                          clipBehavior: Clip.none,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller,
                          children: isMyProfile
                              ? [
                                  SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: UserProfilePosts(),
                                      )),
                                  SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: UserProfileComments(),
                                      )),
                                  const SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: EdgeInsets.all(28.0),
                                        child: RecentHistoryWeb(),
                                      )),
                                  const SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: EdgeInsets.all(28.0),
                                        child: UpvotedHistoryWeb(),
                                      )),
                                  const SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: EdgeInsets.all(28.0),
                                        child: DownvoyedHistoryWeb(),
                                      )),
                                  const SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: EdgeInsets.all(28.0),
                                        child: HiddenHistoryWeb(),
                                      )),
                                  const SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: EdgeInsets.all(28.0),
                                        child: SavedPostsScreen(),
                                      )),
                                  const SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: EdgeInsets.all(28.0),
                                        child: SavedCommentsScreen(),
                                      )),
                                ]
                              : [
                                  SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: UserProfilePosts(),
                                      )),
                                  SizedBox(
                                      height: 500,
                                      child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: UserProfileComments(),
                                      )),
                                ])

                      // ListView.builder(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   scrollDirection: Axis.vertical,
                      //   itemCount: 8,
                      //   itemBuilder: (context, index) => Container(
                      //     height: 300,
                      //     color: Color.fromARGB(
                      //         255, index * 10, index * 15, index * 13),
                      //     margin: const EdgeInsets.symmetric(
                      //         horizontal: 0, vertical: 10),
                      //     child: Text(
                      //       'Post $index',
                      //     ),
                      //   ),
                      // ),
                      ),
                  // if (mediaQuery.size.width <= 1000)
                  //   SizedBox(
                  //     width: mediaQuery.size.width * 0.2,
                  //   ),
                  if (mediaQuery.size.width > 1000)
                    Container(
                      color: ColorManager.bottomSheetBackgound,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: mediaQuery.size.width * 0.2,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(
                          width: mediaQuery.size.width * 0.2,
                          height: 100,
                          child: (userProfileCubit.userData!.banner != null &&
                                  userProfileCubit.userData!.banner != '')
                              ? Image.network(
                                  '$baseUrl/${userProfileCubit.userData!.banner!}',
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  'assets/images/profile_banner.jpg',
                                  fit: BoxFit.fill,
                                ),
                        ),

                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              (userProfileCubit.userData!.picture == null ||
                                      userProfileCubit.userData!.picture == '')
                                  ? const AssetImage('assets/images/Logo.png')
                                      as ImageProvider
                                  : NetworkImage(
                                      '$baseUrl/${userProfileCubit.userData!.picture!}',
                                      // fit: BoxFit.cover,
                                    ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'u/${userProfileCubit.userData!.displayName ?? userProfileCubit.username}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        ListTile(
                          title: Text(
                            '${userProfileCubit.userData!.karma}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: const Text('Karma'),
                        ),

                        if (userProfileCubit.username !=
                            CacheHelper.getData(key: 'username'))
                          TextButton(
                              onPressed: () {
                                userProfileCubit.blockUser(context);
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.block_flipped),
                                  Text('  Block Account')
                                ],
                              )),

                        (userProfileCubit.userData!.about != null &&
                                userProfileCubit.userData!.about != '')
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(userProfileCubit.userData!.about!))
                            : const SizedBox(),

                        (isMyProfile)
                            ? Button(
                                text: 'Edit',
                                textFontSize: 20,
                                onPressed: () {
                                  navigator.pushNamed(
                                      UserProfileEditScreen.routeName);
                                  setState(() {});
                                },
                                buttonWidth: 100,
                                buttonHeight: 55,
                                splashColor: Colors.transparent,
                                borderColor: ColorManager.white,
                                backgroundColor: Colors.transparent,
                                textFontWeight: FontWeight.bold)
                            : BlocBuilder<UserProfileCubit, UserProfileState>(
                                buildWhen: (previous, current) {
                                  if (current is FollowOrUnfollowState ||
                                      previous is FollowOrUnfollowState) {
                                    print(true);
                                    return true;
                                  } else {
                                    return false;
                                  }
                                },
                                builder: (context, state) {
                                  return Button(
                                      text:
                                          (userProfileCubit.userData!.followed!)
                                              ? 'Following'
                                              : 'Follow',
                                      textFontSize: 20,
                                      onPressed: () {
                                        if (userProfileCubit
                                            .userData!.followed!) {
                                          userProfileCubit
                                              .followOrUnfollowUser(false);
                                        } else {
                                          userProfileCubit
                                              .followOrUnfollowUser(true);
                                        }
                                      },
                                      buttonWidth:
                                          (userProfileCubit.userData!.followed!)
                                              ? 150
                                              : 120,
                                      buttonHeight: 55,
                                      splashColor: Colors.transparent,
                                      borderColor: ColorManager.white,
                                      backgroundColor: Colors.transparent,
                                      textFontWeight: FontWeight.bold);
                                },
                              ),
                        // TextButton(
                        //     onPressed: () {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //           builder: ((context) => const Moderators())));
                        //     },
                        //     child: Row(
                        //       children: const [
                        //         Icon(Icons.mail_outline_outlined),
                        //         Text('  Invite to Community')
                        //       ],
                        //     )),
                      ]),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
