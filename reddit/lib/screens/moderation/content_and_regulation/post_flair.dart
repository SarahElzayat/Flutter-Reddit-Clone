import 'package:flutter/material.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostFlair extends StatefulWidget {
  static const String routeName = 'post_flair';
  const PostFlair({super.key});

  @override
  State<PostFlair> createState() => _PostFlairState();
}

class _PostFlairState extends State<PostFlair> {
  bool isSwitched = false;
  bool isEmpty = true;

  toggle(switcher) {
    setState(() {
      isSwitched = switcher;
    });
  }

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
        title: const Text('Post Flair'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add, size: 24.sp))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'SETTINGS',
              style: TextStyle(color: ColorManager.lightGrey, fontSize: 16.sp),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: ColorManager.darkGrey,
            child: RowSwitch('Enable post flair', isSwitched, toggle),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'PREVIEW',
              style: TextStyle(color: ColorManager.lightGrey, fontSize: 16.sp),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: ColorManager.darkGrey,
              child: (isEmpty == true)
                  ? Center(
                      child: Column(
                        children: [
                          const Spacer(),
                          Text(
                            'No post flairs yet',
                            style: TextStyle(fontSize: 20.sp),
                          ),
                          SizedBox(height: 2.h),
                          const Text('Create a flair to use on your post'),
                          SizedBox(height: 3.h),
                          Button(
                            onPressed: () {},
                            text: 'Create flair',
                            buttonWidth: 10.w,
                            buttonHeight: 6.h,
                            splashColor: ColorManager.white.withOpacity(0.5),
                          ),
                          const Spacer()
                        ],
                      ),
                    )
                  : const Text('flairs'),
            ),
          )
        ],
      ),
    );
  }
}
