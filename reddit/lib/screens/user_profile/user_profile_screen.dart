// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/cubit/user_profile/cubit/user_profile_cubit.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import 'package:reddit/widgets/comments/comment.dart';
import 'package:reddit/widgets/user_profile/user_profile_comments.dart';

import '../../components/helpers/enums.dart';
import '../../data/user_profile.dart/about_user_model.dart';
import '../../networks/dio_helper.dart';
import '../../widgets/user_profile/user_profile_posts.dart';
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
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          // primary: false,
          actions: <Widget>[Container()],
          title: Text('u/${userProfileCubit.userData!.displayName}'),
          // automaticallyImplyLeading: false,
          pinned: true,
          backgroundColor: ColorManager.blue,
          expandedHeight: sliverHeight,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
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
                                  userProfileCubit.userData!.banner!,
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
                                    child: (userProfileCubit
                                                    .userData!.picture ==
                                                null ||
                                            userProfileCubit
                                                    .userData!.picture ==
                                                '')
                                        ? Image.asset(
                                            'assets/images/Logo.png',
                                          )
                                        : Image.network(
                                            userProfileCubit.userData!.picture!,
                                            fit: BoxFit.cover,
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
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Button(
                                          text: 'Edit',
                                          textFontSize: 20,
                                          onPressed: () {
                                            navigator.pushNamed(
                                                UserProfileEditScreen
                                                    .routeName);
                                            setState(() {});
                                            SchedulerBinding.instance
                                                .addPostFrameCallback((_) {
                                              getHeight();
                                            });
                                          },
                                          buttonWidth: 100,
                                          buttonHeight: 55,
                                          splashColor: Colors.transparent,
                                          borderColor: ColorManager.white,
                                          backgroundColor: Colors.transparent,
                                          textFontWeight: FontWeight.bold),
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
                      padding: EdgeInsets.only(bottom: 5),
                      color: ColorManager.black,
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // key: _con1,
                          children: [
                            Text(
                              (userProfileCubit.userData!.displayName == null ||
                                      userProfileCubit.userData!.displayName ==
                                          '')
                                  ? userProfileCubit.username!
                                  : userProfileCubit.userData!.displayName!,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: (() {}),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text('0 followers'),
                                    Icon(Icons.arrow_forward_ios_sharp),
                                  ]),
                            ),
                            Text(
                                'u/${userProfileCubit.userData!.displayName} *${userProfileCubit.userData!.karma} Karma *${DateFormat('dd/MM/yyyy').format((userProfileCubit.userData!.cakeDate!))}'),
                            Text(userProfileCubit.userData!.about ?? ''),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: (() {}),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: ColorManager.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.add),
                                        Text('Add Social Link')
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
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
              Text('About')
            ]),
          ),
        ),
      ]),
    );
  }
}