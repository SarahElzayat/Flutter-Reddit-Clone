///@author Yasmine Ghanem
///@date 18/11/2022
///User management widget

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/components/search_field.dart';
import 'package:reddit/router.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class UserManagementWidget extends StatefulWidget {
  final String screenTitle;
  final UserManagement type;
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  UserManagementWidget(
      {super.key, required this.screenTitle, required this.type});

  @override
  State<UserManagementWidget> createState() => _UserManagementWidgetState();
}

class _UserManagementWidgetState extends State<UserManagementWidget> {
  @override
  void initState() {
    ModerationCubit.get(context).getUsers(context, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!kIsWeb)
        ? BlocConsumer<ModerationCubit, ModerationState>(
            listener: (context, state) {},
            builder: (context, state) {
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
                    title: Text(widget.screenTitle),
                    actions: [
                      IconButton(
                          icon: Icon(Icons.add, size: 24.sp),
                          onPressed: () => Navigator.push(
                                context,
                                AppRouter.onGenerateRoute(const RouteSettings(
                                    name: '/add_banned_user_screen')),
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
                            textEditingController: widget.textController,
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
                                      style:
                                          TextStyle(color: ColorManager.white),
                                    ))
                                  : Container(
                                      width: 100.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          color: ColorManager.darkGrey,
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.08.h,
                                                color: ColorManager.grey),
                                          )),
                                      child: ListTile(
                                          leading: const Icon(Icons.person),
                                          title:
                                              Text(cubit.users[index].username),
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
            },
          )
        : BlocConsumer<ModerationCubit, ModerationState>(
            listener: (context, state) {},
            builder: (context, state) {
              final ModerationCubit cubit = ModerationCubit.get(context);
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.w,
                      height: 10.h,
                      color: ColorManager.darkGrey,
                      child: Row(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Button(
                              onPressed: () => userManagementAction(
                                  context,
                                  widget.type,
                                  (widget.type == UserManagement.banned)
                                      ? () {
                                          cubit.banUser(context);
                                          Navigator.pop(context);
                                        }
                                      : (widget.type == UserManagement.muted)
                                          ? () {
                                              cubit.muteUser(context);
                                              Navigator.pop(context);
                                            }
                                          : (widget.type ==
                                                  UserManagement.approved)
                                              ? () {
                                                  cubit.approveUser(context);
                                                  Navigator.pop(context);
                                                }
                                              : () {
                                                  cubit
                                                      .inviteModerator(context);
                                                  Navigator.pop(context);
                                                }),
                              //chooses button text based on the type of user management screen
                              text: (widget.type == UserManagement.banned)
                                  ? 'Ban user'
                                  : (widget.type == UserManagement.muted)
                                      ? 'Mute user'
                                      : (widget.type == UserManagement.approved)
                                          ? 'Approve user'
                                          : 'Ivnite user',
                              buttonWidth: 10.w,
                              buttonHeight: 5.h,
                              textColor: ColorManager.black,
                              splashColor: Colors.transparent,
                              backgroundColor: ColorManager.eggshellWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(widget.screenTitle),
                    ),
                    Center(
                        child: Container(
                      decoration: const BoxDecoration(
                          color: ColorManager.darkGrey,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      width: 70.w,
                      height: 60.h,
                      child: (cubit.users.isEmpty)
                          ? Center(
                              child: Text('No ${widget.screenTitle} Yet',
                                  style: const TextStyle(
                                      color: ColorManager.lightGrey)))
                          : Scrollbar(
                              controller: widget.scrollController,
                              thumbVisibility: true,
                              trackVisibility: true,
                              child: Expanded(
                                  child: ListView.builder(
                                      controller: widget.scrollController,
                                      itemCount: cubit.users.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          width: 100.w,
                                          height: 10.h,
                                          decoration: BoxDecoration(
                                              color: ColorManager.darkGrey,
                                              border: Border(
                                                top: BorderSide(
                                                    width: 0.08.h,
                                                    color: ColorManager.grey),
                                              )),
                                          child: ListTile(
                                              leading: const Icon(Icons.person),
                                              title: Text(cubit
                                                  .users[index].username
                                                  .toString()),
                                              onTap: () {
                                                //go to user profile
                                              },
                                              trailing: IconButton(
                                                icon:
                                                    const Icon(Icons.more_vert),
                                                onPressed: () {},
                                              )),
                                        );
                                      }))),
                    ))
                  ],
                ),
              );
            },
          );
  }
}
