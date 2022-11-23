///@author Yasmine Ghanem
///@date 3/11/2022
///Create Community Screen

import 'package:flutter/material.dart';
import 'package:reddit/Screens/main_screen.dart';
import 'package:reddit/components/bottom_sheet.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/square_text_field.dart';
import '../../components/button.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Data/create_community_model/create_community_model.dart';

///To test create community for android call [CreateCommunityScreen] in main
class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

///This screen is used when user is creating a new subreddit

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  /// boolean for the switch widget that indicates 18+ communities
  /// default is false
  bool isSwitched = false;
  bool isEmpty = true;

  /// selected item from bottom sheet which indicate whether community
  /// is public, private, or restricted
  /// default is public
  late dynamic _communityType = 'Public';
  final List<String> _communityTypes = ['Public', 'Restricted', 'Private'];
  final List<IconData> _communityTypesIcon = [
    Icons.person_off_outlined,
    Icons.check_circle,
    Icons.lock
  ];

  final TextEditingController _controller = TextEditingController();
  String communityName = '';

  ///Disables button when text field is empty and enables it once user writes a community name
  _onChanged() {
    setState(() {
      isEmpty = _controller.text.isEmpty;
    });
  }

  ///Enabled button function to send create community request
  _enabledButton() {
    //do something
    final community = CreateCommunityModel(
      subredditName: communityName,
      type: _communityType,
      nsfw: isSwitched,
    );
    DioHelper.postData(path: createCommunity, data: community.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 3.sp,
        shadowColor: Colors.white,
        backgroundColor: ColorManager.darkGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushNamed(MainScreen.routeName);
          },
        ),
        title: const Text('Create a community'),
        centerTitle: true,
        leadingWidth: 6.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Container(
          padding: EdgeInsets.zero,
          height: 55.h,
          width: 100.w,
          child: Container(
            color: ColorManager.darkGrey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.sp, 20.sp, 15.sp, 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Community name',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  SizedBox(height: 1.h),
                  SquareTextField(
                    prefix: const Text('r/'),
                    labelText: 'Community_name',
                    maxLength: 21,
                    formController: _controller,
                    onChanged: (communityName) {
                      _onChanged();
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      _communityType = await modalBottomSheet(
                          context: context,
                          title: 'Community Type',
                          text: _communityTypes,
                          selectedItem: _communityType,
                          selectedIcons: _communityTypesIcon);
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Community type',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16.sp)),
                        SizedBox(height: 2.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_communityType,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600)),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            )
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text('communityTypeDescription',
                            style: TextStyle(
                                color: ColorManager.eggshellWhite,
                                fontSize: 15.sp))
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text('18+ community',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: Colors.white)),
                      const Spacer(),
                      FlutterSwitch(
                        value: isSwitched,
                        onToggle: (switcher) {
                          setState(() {
                            isSwitched = switcher;
                          });
                        },
                        width: 15.w,
                        height: 5.h,
                        toggleSize: 4.h,
                        inactiveColor: ColorManager.darkGrey,
                        activeColor: ColorManager.darkBlueColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Button(
                      text: 'Create community',
                      textColor: Colors.white,
                      backgroundColor: isEmpty
                          ? ColorManager.disabledButtonGrey
                          : ColorManager.darkBlueColor,
                      buttonWidth: 100.w,
                      disabled: isEmpty ? true : false,
                      buttonHeight: 7.h,
                      textFontSize: 18.sp,
                      textFontWeight: FontWeight.w600,
                      onPressed: isEmpty ? () {} : _enabledButton)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
