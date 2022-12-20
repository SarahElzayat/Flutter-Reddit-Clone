///@author Yasmine Ghanem
///@date 18/11/2022
///User management widget

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/search_field.dart';
import '../../router.dart';
import '../../screens/moderation/cubit/moderation_cubit.dart';

class UserManagementWidget extends StatelessWidget {
  final String screenTitle;
  late List<dynamic> users;

  UserManagementWidget(
      {super.key, required this.screenTitle, required this.users});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                size: 24.sp,
              )),
          backgroundColor: ColorManager.darkGrey,
          title: Text(screenTitle),
          actions: [
            IconButton(
                icon: Icon(Icons.add, size: 24.sp),
                onPressed: () => Navigator.push(
                      context,
                      AppRouter.onGenerateRoute(
                          const RouteSettings(name: '/add_banned_user_screen')),
                    ))
          ],
        ),
        body: Column(children: [
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
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (users.isEmpty)
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
                                title: users[index].username,
                                onTap: () {
                                  //go to user profile
                                },
                                trailing: IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {},
                                )),
                          );
                  }))
        ]));
  }
}
