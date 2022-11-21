///@author Yasmine Ghanem
///@date 3/11/2022
///Create Community Screen

import 'package:flutter/material.dart';
import 'package:reddit/Components/bottom_sheet.dart';
import '../Components/Helpers/color_manager.dart';
import '../Components/square_text_field.dart';
import '../Components/button.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
  bool isValidated = false;

  /// selected item from bottom sheet which indicate whether community
  /// is public, private, or restricted
  /// default is public
  late dynamic _communityType = 'Public';
  final List<String> _communityTypes = ['Public', 'Restricted', 'Private'];
  final List<String> _communityDescription = [
    'Anyone can view, post, and comment to this community',
    'Anyone can view this community, but only approved users can post',
    'Only approved users can view and submit to this community'
  ];

  ///icons for the bottom sheet for each community type
  final List<IconData> _communityTypesIcon = [
    Icons.person_off_outlined,
    Icons.check_circle,
    Icons.lock
  ];

  ///form key to validate the community name text field
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();
  String communityName = '';
  final regexp = RegExp(r'^[A-Za-z0-9_]*$');

  ///Disables button when text field is empty and enables it once user writes a community name
  _onChanged() {
    setState(() {
      communityName = _controller.text;
      isEmpty = _controller.text.isEmpty;
      if (_formKey.currentState!.validate()) {
        isValidated = true;
      }
    });
  }

  ///Enabled button function to send create community request
  _enabledButton() {
    //do something
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
          onPressed: () {},
        ),
        title: const Text('Create a community'),
        centerTitle: true,
        leadingWidth: 6.h,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Container(
            color: ColorManager.darkGrey,
            padding: const EdgeInsets.all(15),
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community name',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 1.h),
                SquareTextField(
                  prefix: const Text('r/', style: TextStyle(fontSize: 20)),
                  labelText: 'Community name',
                  maxLength: 21,
                  formController: _controller,
                  onChanged: (communityName) {
                    _onChanged();
                  },
                  validator: (communityName) {
                    if (communityName!.length < 3 ||
                        !regexp.hasMatch(communityName)) {
                      isValidated = false;
                      return 'Community names must be between 3-21 characters, and can \n only contain letters, numbers, or underscores';
                      // ignore: dead_code
                    } else if (false) {
                      //check if the there is another community with the same name
                      return 'Sorry this community name is taken';
                    }
                    isValidated = true;
                    return null;
                  },
                ),
                SizedBox(height: 3.h),
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
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
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
                      Text(
                          ((_communityType == 'Private')
                              ? _communityDescription[2]
                              : (_communityType == 'Restricted')
                                  ? _communityDescription[1]
                                  : _communityDescription[0]),
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
                      height: 4.h,
                      toggleSize: 3.h,
                      inactiveColor: ColorManager.darkGrey,
                      activeColor: ColorManager.darkBlueColor,
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Center(
                  child: Button(
                      text: 'Create community',
                      textColor: Colors.white,
                      splashColor: ColorManager.white.withOpacity(0.5),
                      backgroundColor: (isEmpty || !isValidated)
                          ? ColorManager.disabledButtonGrey
                          : ColorManager.darkBlueColor,
                      buttonWidth: 100.w,
                      disabled: (isEmpty && !isValidated) ? true : false,
                      buttonHeight: 7.h,
                      textFontSize: 18.sp,
                      textFontWeight: FontWeight.w600,
                      onPressed:
                          (isEmpty || !isValidated) ? () {} : _enabledButton),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
