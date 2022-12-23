import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../components/button.dart';
import '../../components/helpers/color_manager.dart';
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
  late TabController controller = TabController(length: 2, vsync: this);
  late bool isMyProfile;

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
    return Scaffold(
      body: ListView(
        children: [
          TabBar(controller: controller, tabs: const [
            Tab(
              text: 'POSTS',
            ),
            Tab(
              text: 'Comments',
            )
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
                        children: [
                          SizedBox(height: 500, child: UserProfilePosts()),
                          SizedBox(height: 500, child: UserProfileComments()),
                        ])
                    ),
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
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(userProfileCubit.userData!.about!))
                          : const SizedBox(),

                      (isMyProfile)
                          ? Button(
                              text: 'Edit',
                              textFontSize: 20,
                              onPressed: () {
                                navigator
                                    .pushNamed(UserProfileEditScreen.routeName);
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
                                  return true;
                                } else {
                                  return false;
                                }
                              },
                              builder: (context, state) {
                                return Button(
                                    text: (userProfileCubit.userData!.followed!)
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
    );
  }
}
