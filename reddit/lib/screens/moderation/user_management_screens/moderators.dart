///@author: Yasmine Ghanem
///@date: 12/12/2020
///this screen displays the moderators for a certain subreddit

import 'package:flutter/material.dart';
import 'package:reddit/components/bottom_sheet.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/router.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:reddit/screens/moderation/user_management_screens/invite_moderator.dart';
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
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => InviteModerator()))),
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

class ModeratorsWidget extends StatefulWidget {
  ModeratorsWidget({super.key});

  @override
  State<ModeratorsWidget> createState() => _ModeratorsWidgetState();
}

class _ModeratorsWidgetState extends State<ModeratorsWidget> {
  List<dynamic> moderators = [];

  TextEditingController controller = TextEditingController();
  String? choice;

  @override
  void initState() {
    ModerationCubit.get(context).getUsers(context, UserManagement.moderator);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return Column(children: [
      Center(
        child: SizedBox(
          height: 10.h,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: SearchField(
              textEditingController: controller,
            ),
          ),
        ),
      ),
      Expanded(
          child: ListView.builder(
              itemCount: cubit.users.length,
              itemBuilder: (BuildContext context, int index) {
                return (cubit.users.isEmpty)
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
                            title: Text(cubit.users[index].username),
                            onTap: () {
                              //go to user profile
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () async {
                                choice = await modalBottomSheet(
                                    context: context,
                                    title: '',
                                    text: ['View profile', 'Remove mod'],
                                    selectedItem: choice);
                                (choice == 'Remove mod')
                                    ? () => cubit.removeModerator()
                                    : () {
                                        //go to profile
                                      };
                                setState(() {});
                              },
                            )),
                      );
              }))
    ]);
  }
}
