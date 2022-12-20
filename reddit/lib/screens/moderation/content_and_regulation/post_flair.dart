import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/screens/moderation/create_flair.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
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

  @override
  void initState() {
    ModerationCubit.get(context).getPostFlairs();
    super.initState();
  }

  toggle(switcher) {
    setState(() {
      isSwitched = switcher;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => moderationDialog(context),
                icon: Icon(
                  Icons.arrow_back,
                  size: 24.sp,
                )),
            backgroundColor: ColorManager.darkGrey,
            title: const Text('Post Flair'),
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const CreateFlair()))),
                  icon: Icon(Icons.add, size: 24.sp))
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'SETTINGS',
                  style:
                      TextStyle(color: ColorManager.lightGrey, fontSize: 16.sp),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: ColorManager.darkGrey,
                child: rowSwitch('Enable post flair', isSwitched, toggle),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'PREVIEW',
                  style:
                      TextStyle(color: ColorManager.lightGrey, fontSize: 16.sp),
                ),
              ),
              Expanded(
                child: state is EmptyQueue
                    ? Container(
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
                                    const Text(
                                        'Create a flair to use on your post'),
                                    SizedBox(height: 3.h),
                                    Button(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  const CreateFlair()))),
                                      text: 'Create flair',
                                      buttonWidth: 40.w,
                                      buttonHeight: 50,
                                      splashColor:
                                          ColorManager.white.withOpacity(0.5),
                                    ),
                                    const Spacer()
                                  ],
                                ),
                              )
                            : const Text('flairs'),
                      )
                    : ListView.builder(
                        itemCount: 1,
                        itemBuilder: ((context, index) => InkWell(
                              child: Container(
                                height: 10.h,
                                width: 100.w,
                                color: ColorManager.darkGrey,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              cubit.postFlairs[index].flairName,
                                              style: const TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.arrow_forward))
                                    ],
                                  ),
                                ),
                              ),
                            ))),
              )
            ],
          ),
        );
      },
    );
  }
}
