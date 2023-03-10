///@author: Yasmine Ghanem
///@date:
///this screen enables/disables archived posts in a community

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../components/helpers/color_manager.dart';

class ArchivePosts extends StatefulWidget {
  static const String routeName = 'archive_posts';
  const ArchivePosts({super.key});

  @override
  State<ArchivePosts> createState() => _ArchivePostsState();
}

class _ArchivePostsState extends State<ArchivePosts> {
  /// indicates whether the enabled archived is turned on or off
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
            )),
        backgroundColor: ColorManager.darkGrey,
        title: const Text('Archive Posts'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: 100.h,
        width: 100.w,
        color: ColorManager.darkGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dont allow commenting or voting on posts older than 6 months.',
              style: TextStyle(fontSize: 16.sp, color: ColorManager.lightGrey),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                const Text('Enabled'),
                const Spacer(),
                FlutterSwitch(
                    width: 15.w,
                    height: 4.h,
                    value: isSwitched,
                    onToggle: (switcher) {
                      setState(() {
                        isSwitched = switcher;
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
