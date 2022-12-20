import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/moderation_components/modtools_components.dart';
import '../cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommunityType extends StatefulWidget {
  static const String routeName = 'community_type';
  const CommunityType({super.key});

  @override
  State<CommunityType> createState() => _CommunityTypeState();
}

class _CommunityTypeState extends State<CommunityType> {
  // bool isChanged = false;
  // bool isSwitched = false;
  double change = 0;
  // Color thumbColor = ColorManager.green;
  // Color sliderColor = ColorManager.green;
  // CommunityTypes communityType = CommunityTypes.public;

  _enabledButton() {
    //do something
  }
  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: moderationAppBar(
                context,
                'Community type',
                () => cubit.updateCommunitySettings(context),
                cubit.typeChanged),
            body: Container(
              color: ColorManager.darkGrey,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 18.0.sp),
                        thumbColor: cubit.typeColor,
                        activeTrackColor: (change == 0)
                            ? ColorManager.green
                            : (change == 1)
                                ? ColorManager.yellow
                                : ColorManager.red,
                        trackHeight: 0.5.h),
                    child: Slider(
                      thumbColor: (change == 0)
                          ? ColorManager.green
                          : (change == 1)
                              ? ColorManager.yellow
                              : ColorManager.red,
                      value: change,
                      onChanged: (changed) {
                        cubit.communityTypeChanged();
                        setState(() {
                          change = changed;
                        });
                      },
                      divisions: 2,
                      max: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      (change == 0)
                          ? 'Public'
                          : (change == 1)
                              ? 'Restricted'
                              : 'Private',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: (change == 0)
                            ? ColorManager.green
                            : (change == 1)
                                ? ColorManager.yellow
                                : ColorManager.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 5),
                    child: Text(
                        (change == 0)
                            ? 'Anyone can see and participate in this community'
                            : (change == 1)
                                ? 'Any one can see, join, or vote in this community, but you control who posts and comments'
                                : 'Only people you approve can see and participate in this community',
                        style: const TextStyle(color: ColorManager.lightGrey)),
                  ),
                  Divider(
                    indent: 8,
                    endIndent: 8,
                    thickness: 3.sp,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          rowSwitch('18+ Community', cubit.nsfwSwitch, (value) {
                        cubit.nsfwSwitch = value;
                        cubit.communityTypeChanged();
                        setState(() {});
                      })
                      // Row(
                      //   children: [
                      //     Text('18+ community',
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.w600,
                      //             fontSize: 18.sp,
                      //             color: Colors.white)),
                      //     const Spacer(),
                      //     FlutterSwitch(
                      //       key: const Key('create_community_switch'),
                      //       value: true,
                      //       onToggle: (switcher) {
                      //         cubit.nsfwSwitch = switcher;
                      //       },
                      //       width: 15.w,
                      //       height: 4.h,
                      //       toggleSize: 3.h,
                      //       inactiveColor: ColorManager.darkGrey,
                      //       activeColor: ColorManager.darkBlueColor,
                      //     ),
                      //   ],
                      // ),
                      ),
                ],
              ),
            ));
      },
    );
  }
}
