///@author Yasmine Ghanem
///@date 18/11/2022
///User management widget

import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/search_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../components/list_tile.dart';

class UserManagementWidget extends StatefulWidget {
  final String screenTitle;
  final List<ListTileWidget>? users;

  UserManagementWidget({super.key, required this.screenTitle, this.users});

  @override
  State<UserManagementWidget> createState() => _UserManagementWidgetState();
}

class _UserManagementWidgetState extends State<UserManagementWidget> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 24.sp))
        ],
      ),
      body: Column(children: [
        Center(
          child: SizedBox(
            height: 8.h,
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: SearchFiled(
                textEditingController: _controller,
              ),
            ),
          ),
        ),
        Container(
          width: 100.w,
          height: 7.5.h,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 0.08.h, color: ColorManager.grey),
          )),
          child: ListTile(
            onTap: () {}, // goes to user profile
            leading: const Icon(Icons.person),
            tileColor: ColorManager.darkGrey,
            dense: true,
            title: Text(
              'u/username',
              style: TextStyle(fontSize: 16.sp),
            ),
            subtitle: const Text('time'),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ),
        ),
        Container(
          width: 100.w,
          height: 7.5.h,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 0.08.h, color: ColorManager.grey),
          )),
          child: ListTile(
            onTap: () {}, // goes to user profile
            leading: const Icon(Icons.person),
            tileColor: ColorManager.darkGrey,
            dense: true,
            title: Text(
              'u/username',
              style: TextStyle(fontSize: 16.sp),
            ),
            subtitle: const Text('time'),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ),
        ),
        Container(
          width: 100.w,
          height: 7.h,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 0.08.h, color: ColorManager.grey),
          )),
          child: ListTile(
            onTap: () {}, // goes to user profile
            leading: const Icon(Icons.person),
            tileColor: ColorManager.darkGrey,
            dense: true,
            title: Text(
              'u/username',
              style: TextStyle(fontSize: 16.sp),
            ),
            subtitle: const Text('time'),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ),
        )
      ]),
    );
  }
}
