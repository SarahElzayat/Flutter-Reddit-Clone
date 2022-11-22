import 'package:flutter/material.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ArchivePosts extends StatefulWidget {
  const ArchivePosts({super.key});

  @override
  State<ArchivePosts> createState() => _ArchivePostsState();
}

class _ArchivePostsState extends State<ArchivePosts> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
            )),
        backgroundColor: ColorManager.darkGrey,
        title: const Text('Archive Posts'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        height: 100.h,
        width: 100.w,
        color: ColorManager.darkGrey,
        child: Column(
          children: [
            Text(
              'Dont allow commenting or voting on posts older than 6 months.',
              style: TextStyle(fontSize: 15.sp, color: ColorManager.lightGrey),
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
