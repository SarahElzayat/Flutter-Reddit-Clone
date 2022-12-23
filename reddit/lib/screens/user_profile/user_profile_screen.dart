// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/user_profile/cubit/user_profile_cubit.dart';
import 'package:reddit/data/settings/settings_models/user_settings.dart';
import 'package:reddit/screens/settings/change_profile_picture_screen.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import 'package:reddit/widgets/comments/comment.dart';
import 'package:reddit/widgets/user_profile/user_profile_comments.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/helpers/enums.dart';
import '../../cubit/add_post/cubit/add_post_cubit.dart';
import '../../cubit/app_cubit/app_cubit.dart';
import '../../data/user_profile/about_user_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../widgets/user_profile/user_profile_posts.dart';
import '../add_post/add_post.dart';
import 'user_profile_edit_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final bool yourProfile;

  const UserProfileScreen({
    Key? key,
    this.yourProfile = false,
  }) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
  static const routeName = '/user_profile_screen_route';
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  double sliverHeight = 0;
  final GlobalKey _con1 = GlobalKey();

  late TabController controller = TabController(length: 3, vsync: this);
  // final GlobalKey _con2 = GlobalKey();
  // final GlobalKey _con3 = GlobalKey();

  late bool isMyProfile;

  @override
  void initState() {
    // final username = CacheHelper.getData(key: 'username');
    // await DioHelper.getData(
    //     path: '/user/$username/about',
    //     query: {'username': username}).then((value) {
    //   if (value.statusCode == 200) {
    //     UserProfileCubit.get(context).userData =
    //         AboutUserModel.fromJson(value.data);
    //     UserProfileCubit.get(context).username = username;
    //     print('All Done');
    //     print(UserProfileCubit.get(context).userData.displayName);
    //   }
    // }).catchError((error) {
    //   print('Error in fetch user data ==> $error');
    // });

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
    WidgetsBinding.instance.addPostFrameCallback((_) => getHeight());
  }

  getHeight() {
    RenderBox? renderCon1 =
        _con1.currentContext!.findRenderObject() as RenderBox;

    sliverHeight =
        MediaQuery.of(context).size.height * 0.4 + 15 + renderCon1.size.height;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final userProfileCubit = BlocProvider.of<UserProfileCubit>(context);
    final AppCubit cubit = AppCubit.get(context);

    return Scaffold(
      bottomNavigationBar: (isMyProfile)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              items: cubit.bottomNavBarIcons,
              onTap: (value) {
                setState(() {
                  if (value == 2) {
                    AddPostCubit.get(context).isSubreddit = false;
                    print(AddPostCubit.get(context).isSubreddit);
                    AddPostCubit.get(context).addSubredditName(null);
                    Navigator.of(context).push(MaterialPageRoute(
                      // TODO:pass the name of subreddit to add post
                      builder: (context) => const AddPost(),
                    ));
                  } else {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    cubit.changeIndex(value);
                  }
                });
              },
            )
          : null,
      body: CustomScrollView(slivers: [
        BlocBuilder<UserProfileCubit, UserProfileState>(
          buildWhen: (previous, current) {
            return true;
          },
          builder: (context, state) {
            return SliverAppBar(
              // primary: false,
              actions: <Widget>[Container()],
              title: Text('u/${userProfileCubit.userData!.displayName}'),
              // automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: ColorManager.blue,
              expandedHeight: sliverHeight,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  color: ColorManager.darkGrey,
                  child: TabBar(
                      indicatorColor: ColorManager.blue,
                      controller: controller,
                      tabs: const [
                        Tab(
                          text: 'Posts',
                        ),
                        Tab(text: 'Comments'),
                        Tab(
                          text: 'About',
                        )
                      ]),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: ColorManager.black,
                  // height: mediaquery.size.height * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mediaquery.size.height * 0.4,
                          width: mediaquery.size.width,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              (userProfileCubit.userData!.banner == null ||
                                      userProfileCubit.userData!.banner == '')
                                  ? Image.asset(
                                      'assets/images/profile_banner.jpg',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      '$baseUrl/${userProfileCubit.userData!.banner!}',
                                      fit: BoxFit.cover,
                                    ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 22, vertical: 5),
                                      // padding: EdgeInsets.only(left: 15),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: (userProfileCubit
                                                        .userData!.picture ==
                                                    null ||
                                                userProfileCubit
                                                        .userData!.picture ==
                                                    '')
                                            ? const AssetImage(
                                                    'assets/images/Logo.png')
                                                as ImageProvider
                                            : NetworkImage(
                                                '$baseUrl/${userProfileCubit.userData!.picture!}',
                                                // fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          width: mediaquery.size.width,
                                          height: 80,
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(20, 0, 0, 0),
                                              Color.fromARGB(255, 0, 0, 0),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, top: 10),
                                          child: (isMyProfile)
                                              ? Button(
                                                  text: 'Edit',
                                                  textFontSize: 20,
                                                  onPressed: () {
                                                    navigator.pushNamed(
                                                        UserProfileEditScreen
                                                            .routeName);
                                                    setState(() {});
                                                    SchedulerBinding.instance
                                                        .addPostFrameCallback(
                                                            (_) {
                                                      getHeight();
                                                    });
                                                  },
                                                  buttonWidth: 100,
                                                  buttonHeight: 55,
                                                  splashColor:
                                                      Colors.transparent,
                                                  borderColor:
                                                      ColorManager.white,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  textFontWeight:
                                                      FontWeight.bold)
                                              : BlocBuilder<UserProfileCubit,
                                                  UserProfileState>(
                                                  buildWhen:
                                                      (previous, current) {
                                                    if (current
                                                            is FollowOrUnfollowState ||
                                                        previous
                                                            is FollowOrUnfollowState) {
                                                      print(true);
                                                      return true;
                                                    } else {
                                                      return false;
                                                    }
                                                  },
                                                  builder: (context, state) {
                                                    return Button(
                                                        text: (userProfileCubit
                                                                .userData!
                                                                .followed!)
                                                            ? 'Following'
                                                            : 'Follow',
                                                        textFontSize: 20,
                                                        onPressed: () {
                                                          if (userProfileCubit
                                                              .userData!
                                                              .followed!) {
                                                            userProfileCubit
                                                                .followOrUnfollowUser(
                                                                    false);
                                                          } else {
                                                            userProfileCubit
                                                                .followOrUnfollowUser(
                                                                    true);
                                                          }
                                                        },
                                                        buttonWidth:
                                                            (userProfileCubit
                                                                    .userData!
                                                                    .followed!)
                                                                ? 150
                                                                : 120,
                                                        buttonHeight: 55,
                                                        splashColor:
                                                            Colors.transparent,
                                                        borderColor:
                                                            ColorManager.white,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        textFontWeight:
                                                            FontWeight.bold);
                                                  },
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          key: _con1,
                          padding: const EdgeInsets.only(bottom: 5),
                          color: ColorManager.black,
                          child: Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // key: _con1,
                              children: [
                                Text(
                                  (userProfileCubit.userData!.displayName ==
                                              null ||
                                          userProfileCubit
                                                  .userData!.displayName ==
                                              '')
                                      ? userProfileCubit.username!
                                      : userProfileCubit.userData!.displayName!,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // MaterialButton(
                                //   padding: EdgeInsets.zero,
                                //   onPressed: (() {}),
                                //   child: Row(
                                //       mainAxisSize: MainAxisSize.min,
                                //       children: const [
                                //         Text('0 followers'),
                                //         Icon(Icons.arrow_forward_ios_sharp),
                                //       ]),
                                // ),
                                Text(
                                    'u/${userProfileCubit.userData!.displayName} *${userProfileCubit.userData!.karma} Karma *${DateFormat('dd/MM/yyyy').format((userProfileCubit.userData!.cakeDate!))}'),
                                Text(userProfileCubit.userData!.about ?? ''),
                                (isMyProfile)
                                    ? Wrap(
                                        spacing: 5,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  userProfileCubit.userData!
                                                      .socialLinks!.length;
                                              i++)
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: InkWell(
                                                onTap: () async {
                                                  Uri url = Uri.parse(
                                                      userProfileCubit
                                                          .userData!
                                                          .socialLinks![i]
                                                          .link!);
                                                  await launchUrl(url);
                                                  // if (await canLaunchUrl(url)) {
                                                  //   await launchUrl(url);
                                                  // }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: ColorManager.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Icon(Icons.link),
                                                        Text(userProfileCubit
                                                            .userData!
                                                            .socialLinks![i]
                                                            .displayText!),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          if (userProfileCubit.userData!
                                                  .socialLinks!.length <
                                              5)
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: InkWell(
                                                // padding: EdgeInsets.zero,
                                                onTap: (() {
                                                  navigator.pushNamed(
                                                      UserProfileEditScreen
                                                          .routeName);
                                                }),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: ColorManager.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: const [
                                                        Icon(Icons.add),
                                                        Text('Add Social Link')
                                                      ]),
                                                ),
                                              ),
                                            ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SliverFillRemaining(
          child: SizedBox(
            // height: 50,
            child: TabBarView(controller: controller, children: [
              UserProfilePosts(),
              // Text('Comments'),
              // Comment(post: post, comment: comment,viewType: CommentView.inSubreddits,)
              // Text('Comments'),
              UserProfileComments(),
              const Text('About')
            ]),
          ),
        ),
      ]),
    );
  }
}
