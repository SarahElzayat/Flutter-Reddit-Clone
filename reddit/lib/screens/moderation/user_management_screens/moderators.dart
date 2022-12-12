///@author: Yasmine Ghanem
///@date: 12/12/2020
///this screen displays the moderators for a certain subreddit

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/router.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/search_field.dart';

class Moderators extends StatelessWidget {
  const Moderators({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: 24.sp,
              )),
          backgroundColor: ColorManager.darkGrey,
          title: const Text('Moderators'),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                    AppRouter.onGenerateRoute(
                        const RouteSettings(name: '/invite_moderator_screen'))),
                icon: Icon(Icons.add, size: 24.sp))
          ],
          bottom: const TabBar(
              indicatorColor: ColorManager.blue,
              tabs: [Tab(text: 'All'), Tab(text: 'Editable')]),
        ),
        body: TabBarView(children: [ModeratorsWidget(), ModeratorsWidget()]),
      ),
    );
  }
}

class ModeratorsWidget extends StatelessWidget {
  ModeratorsWidget({super.key});

  List<dynamic> moderators = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    moderators = cubit.getUsers(context, UserManagement.moderator);
    return Column(children: [
      Center(
        child: SizedBox(
          height: 10.h,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: SearchFiled(
              textEditingController: controller,
            ),
          ),
        ),
      ),
      Expanded(
          child: ListView.builder(
              itemCount: moderators.length,
              itemBuilder: (BuildContext context, int index) {
                return (moderators.isEmpty)
                    ? const Center(
                        child: Text(
                        'No users',
                        style: TextStyle(color: ColorManager.white),
                      ))
                    : Container(
                        width: 100.w,
                        height: 10.h,
                        decoration: BoxDecoration(
                            color: ColorManager.darkGrey,
                            border: Border(
                              top: BorderSide(
                                  width: 0.08.h, color: ColorManager.grey),
                            )),
                        child: ListTile(
                            leading: const Icon(Icons.person),
                            title: moderators[index].username,
                            onTap: () {
                              //go to user profile
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () {},
                            )),
                      );
              }))
    ]);
  }
}
