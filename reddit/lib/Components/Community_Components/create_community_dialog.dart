///@author Yasmine Ghanem
///@date 8/11/2022
///Create community window for web

import 'package:flutter/material.dart';
import 'package:reddit/Components/Helpers/color_manager.dart';
import 'package:reddit/Components/Helpers/enums.dart';
import 'package:reddit/Components/square_text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Button.dart';

class CreateCommunityWeb extends StatefulWidget {
  const CreateCommunityWeb({super.key});

  @override
  State<CreateCommunityWeb> createState() => _CreateCommunityWindow();
}

/// this widget creates a window to create a community in the web.
class _CreateCommunityWindow extends State<CreateCommunityWeb> {
  CommunityTypes? _chosenCommunityType = CommunityTypes.public;
  bool? isAdultContent = false;
  bool isEmpty = false;
  String communityName = '';
  final String errorMessage = 'A community name is required';

  ///variables for handling the text field (still working on it)
  ///maximum number of letters a community name can have
  // ignore: prefer_final_fields
  int charachtersRemaining = 21;

  ///to control the text field
  final TextEditingController _controller = TextEditingController();

  ///@param [communityName] current state of the text in the text field
  ///changes continuosly while user is editing

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.darkGrey,
        appBar: AppBar(title: const Text('TestScreen')),
        body: Center(
            child: OutlinedButton(
                child: const Text('Create Community'),
                onPressed: () => _dialogBuilder(context))));
  }

  ///This is the actual function that build the dialog (popup window) called in the build function
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.all(12.sp),
                  actionsPadding: const EdgeInsets.all(0),
                  backgroundColor: ColorManager.greyBlack,
                  content: SizedBox(
                      width: (40.w),
                      height: (70.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Create a community',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: ColorManager.eggshellWhite,
                                    fontSize: (13.sp),
                                    fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close),
                                color: ColorManager.textGrey,
                              )
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Divider(
                            color: Colors.white,
                            thickness: 1.sp,
                            height: 12.sp,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                                color: ColorManager.eggshellWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp),
                          ),
                          Row(
                            children: [
                              Text(
                                'Community names including capitalization cannot be changed.  ',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: ColorManager.textGrey),
                              )

                              ///insert icon/image here
                            ],
                          ),
                          SizedBox(height: 3.h),
                          SizedBox(
                              height: 8.h,
                              child: SquareTextField(
                                labelText: '',
                                prefix: const Text('r/'),
                                showSuffix: false,
                                formController: _controller,
                                maxLength: 21,
                                onChanged: (communityName) => setState(() {
                                  isEmpty = _controller.text.isEmpty;
                                  charachtersRemaining =
                                      21 - _controller.text.length;
                                }),
                                // validator: ,
                              )),
                          SizedBox(height: 2.h),
                          //Textfield
                          Text('$charachtersRemaining Characters remaining',
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: ColorManager.textGrey)),
                          //empty text field error message for now
                          //will add validator later
                          Text('A community name is required',
                              style: TextStyle(
                                  color: isEmpty
                                      ? Colors.red
                                      : ColorManager.greyBlack,
                                  fontSize: 11.sp)),
                          SizedBox(height: 2.h),
                          Text(
                            'Community type',
                            style: TextStyle(
                                color: ColorManager.eggshellWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp),
                          ),

                          ///ListTile for public radio button
                          ListTile(
                            horizontalTitleGap: 0.05.w,
                            visualDensity: const VisualDensity(vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Icon(Icons.person,
                                    color: ColorManager.textGrey, size: 13.sp),
                                Text('  Public ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: ColorManager.eggshellWhite)),
                                Text(
                                  ' Anyone can view, post, and comment to this community',
                                  style: TextStyle(
                                      color: ColorManager.textGrey,
                                      fontSize: 11.sp),
                                )
                              ],
                            ),
                            leading: Radio(
                                hoverColor: Colors.transparent,
                                activeColor: ColorManager.darkBlueColor,
                                value: CommunityTypes.public,
                                groupValue: _chosenCommunityType,
                                onChanged: (newCommunityType) => setState(() {
                                      _chosenCommunityType = newCommunityType;
                                    })),
                          ),

                          ///ListTile for restricted radio button
                          ListTile(
                            horizontalTitleGap: 0.05.w,
                            visualDensity: const VisualDensity(vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Icon(Icons.remove_red_eye_outlined,
                                    color: ColorManager.textGrey, size: 13.sp),
                                Text('  Restricted  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: ColorManager.eggshellWhite)),
                                Text(
                                  'Anyone can view this community, but only approved users can post',
                                  style: TextStyle(
                                      color: ColorManager.textGrey,
                                      fontSize: 11.sp),
                                )
                              ],
                            ),
                            leading: Radio(
                                hoverColor: Colors.transparent,
                                activeColor: ColorManager.darkBlueColor,
                                value: CommunityTypes.restricted,
                                groupValue: _chosenCommunityType,
                                onChanged: (newCommunityType) => setState(() {
                                      _chosenCommunityType = newCommunityType;
                                    })),
                          ),

                          ///ListTile for private radio button
                          ListTile(
                            horizontalTitleGap: 0.05.w,
                            visualDensity: const VisualDensity(vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              children: [
                                Icon(Icons.lock_rounded,
                                    color: ColorManager.textGrey, size: 13.sp),
                                Text('  Private  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: ColorManager.eggshellWhite)),
                                Text(
                                  'Only approved users can view and submit to this community',
                                  style: TextStyle(
                                      color: ColorManager.textGrey,
                                      fontSize: 11.sp),
                                )
                              ],
                            ),
                            leading: Radio(
                                hoverColor: Colors.transparent,
                                activeColor: ColorManager.darkBlueColor,
                                value: CommunityTypes.private,
                                groupValue: _chosenCommunityType,
                                onChanged: (newCommunityType) => setState(() {
                                      _chosenCommunityType = newCommunityType;
                                    })),
                          ),
                          const Spacer(),
                          Text(
                            'Adult content',
                            style: TextStyle(
                                color: ColorManager.eggshellWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp),
                          ),
                          Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              unselectedWidgetColor: ColorManager.eggshellWhite,
                            ),
                            child: CheckboxListTile(
                              contentPadding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              selectedTileColor: ColorManager.eggshellWhite,
                              checkColor: Colors.black,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text('18+ year old community',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      color: ColorManager.eggshellWhite)),
                              value: isAdultContent,
                              onChanged: (isAdult) {
                                setState(() {
                                  isAdultContent = isAdult;
                                });
                              },
                            ),
                          )
                        ],
                      )),
                  actions: <Widget>[
                    Container(
                      height: 10.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: ColorManager.bottomWindowGrey,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.zero, bottom: Radius.circular(5))),
                      child: Row(
                        children: [
                          const Spacer(),
                          Button(
                              text: 'Cancel',
                              textColor: ColorManager.eggshellWhite,
                              backgroundColor: ColorManager.grey,
                              buttonWidth: 7.w,
                              buttonHeight: 5.h,
                              textFontSize: 13.sp,
                              borderColor: ColorManager.eggshellWhite,
                              textFontWeight: FontWeight.bold,
                              onPressed: () =>

                                  ///to return to home page
                                  Navigator.pop(context, 'Cancel')),
                          SizedBox(width: 1.w),
                          Button(
                              text: 'Create Community',
                              textColor: ColorManager.deepDarkGrey,
                              backgroundColor: ColorManager.eggshellWhite,
                              buttonWidth: 14.w,
                              buttonHeight: 5.h,
                              textFontSize: 13.sp,
                              textFontWeight: FontWeight.bold,
                              onPressed: () {}),
                          SizedBox(width: 1.w)
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
