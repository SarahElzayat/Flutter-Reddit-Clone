import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/helpers/color_manager.dart';
import '../../../components/list_tile.dart';
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
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                size: 24.sp,
              )),
          backgroundColor: ColorManager.darkGrey,
          title: const Text('Moderators'),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 24.sp))
          ],
          bottom: const TabBar(
              indicatorColor: ColorManager.blue,
              tabs: [Tab(text: 'All'), Tab(text: 'Editable')]),
        ),
        body: const TabBarView(
            children: [ModeratorsWidget(), ModeratorsWidget()]),
      ),
    );
  }
}

class ModeratorsWidget extends StatefulWidget {
  final List<ListTileWidget>? moderators;
  const ModeratorsWidget({super.key, this.moderators});

  @override
  State<ModeratorsWidget> createState() => _ModeratorsWidgetState();
}

class _ModeratorsWidgetState extends State<ModeratorsWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
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
