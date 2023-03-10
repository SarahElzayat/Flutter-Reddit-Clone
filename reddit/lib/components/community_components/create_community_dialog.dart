///@author Yasmine Ghanem
///@date 8/11/2022
///Create community dialog for web
import 'package:flutter/material.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:reddit/screens/create_community_screen/cubit/create_community_cubit.dart';
import 'package:reddit/screens/moderation/mod_tools.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

///@param [context] home screen context
///returns a pop up window for a user to create a new community
createCommunityDialog(context) {
  // controller for the community name textfield
  TextEditingController controller = TextEditingController();

  final ScrollController scrollController = ScrollController();

  // determines whether the subreddit is nsfw or not
  bool? nsfw = false;

  // determines the community type when creating a new community
  //the default is public
  CommunityTypes? communityType = CommunityTypes.public;

  return showDialog(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
          builder: ((context, setState) => SingleChildScrollView(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.all(12.sp),
                  actionsPadding: const EdgeInsets.all(0),
                  backgroundColor: ColorManager.greyBlack,
                  content: Column(
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
                                fontSize: 11.sp, color: ColorManager.textGrey),
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
                            formController: controller,
                            maxLength: 21,
                            onChanged: (communityName) => setState(() {}),
                            // validator: ,
                          )),
                      SizedBox(height: 2.h),
                      //Textfield
                      Text(
                          '${21 - controller.text.length} Characters remaining',
                          style: TextStyle(
                              fontSize: 11.sp, color: ColorManager.textGrey)),
                      //empty text field error message for now
                      //will add validator later
                      Text('A community name is required',
                          style: TextStyle(
                              color: controller.text.isEmpty
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
                            groupValue: communityType,
                            onChanged: (newCommunityType) => setState(() {
                                  communityType = newCommunityType;
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
                            groupValue: communityType,
                            onChanged: (newCommunityType) => setState(() {
                                  communityType = newCommunityType;
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
                            groupValue: communityType,
                            onChanged: (newCommunityType) => setState(() {
                                  communityType = newCommunityType;
                                })),
                      ),
                      // const Spacer(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Adult content',
                        style: TextStyle(
                            color: ColorManager.eggshellWhite,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),
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
                          value: nsfw,
                          onChanged: (isAdult) {
                            setState(() {
                              nsfw = isAdult;
                            });
                          },
                        ),
                      )
                    ],
                  ),
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
                              textFontWeight: FontWeight.bold,
                              buttonWidth: 7.w,
                              buttonHeight: 5.h,
                              textFontSize: 13.sp,
                              onPressed: () =>
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
                              onPressed: () {
                                String type =
                                    (communityType == CommunityTypes.public)
                                        ? 'Public'
                                        : (communityType ==
                                                CommunityTypes.restricted)
                                            ? 'Restricted'
                                            : 'Private';
                                CreateCommunityCubit.get(context)
                                    .creatCommunity(
                                  context: context,
                                  name: controller.text,
                                  type: type,
                                  nsfw: nsfw as bool,
                                  category: 'Sports',
                                );
                                MaterialPageRoute(
                                    builder: ((context) => ModTools(
                                        communityName: controller.text)));
                              }),
                          SizedBox(width: 1.w)
                        ],
                      ),
                    )
                  ],
                ),
              ))));
}
