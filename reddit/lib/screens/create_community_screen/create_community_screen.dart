///@author Yasmine Ghanem
///@date 3/11/2022
///Create Community Screen

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/bottom_sheet.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:reddit/screens/create_community_screen/cubit/create_community_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../components/button.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/square_text_field.dart';
import '../../constants/constants.dart';

class CreateCommunityScreen extends StatefulWidget {
  static const String routeName = 'create_community_screen';
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

///This screen is used when user is creating a new subreddit

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  /// boolean for the switch widget that indicates nsfw communities
  /// default is false
  bool isSwitched = false;

  ///boolean for the text field validation
  bool isEmpty = true;

  ///boolean for text field validation and disables or enables button
  bool isValidated = false;

  /// available categories list assigned to a community
  List<dynamic> categories = [];

  ///default value for the category list
  String? category = 'Sports';

  ///form key to validate the community name text field
  final _formKey = GlobalKey<FormState>();

  ///text field controller
  final TextEditingController _controller = TextEditingController();

  ///new created subreddit nama
  String communityName = '';

  ///regecp used for community name validation
  final regexp = RegExp(r'^[A-Za-z0-9_]*$');

  /// selected item from bottom sheet which indicate whether community
  /// is public, private, or restricted and their descriptions
  /// default is public
  late dynamic communityType = 'Public';

  @override
  void initState() {
    super.initState();
    CreateCommunityCubit.get(context).getSavedCategories();
  }

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

  @override
  Widget build(BuildContext context) {
    //create community screen
    final CreateCommunityCubit cubit = CreateCommunityCubit.get(context);
    return BlocConsumer<CreateCommunityCubit, CreateCommunityState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 3.sp,
            shadowColor: Colors.white,
            backgroundColor: ColorManager.darkGrey,
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
                    StatefulBuilder(
                      builder: (context, setState) => SquareTextField(
                        key: const Key('create_community_textfield'),
                        prefix:
                            const Text('r/', style: TextStyle(fontSize: 20)),
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
                    ),
                    SizedBox(height: 3.h),
                    InkWell(
                      onTap: () async {
                        communityType = await modalBottomSheet(
                            context: context,
                            title: 'Community Type',
                            text: communityTypes,
                            selectedItem: communityType,
                            selectedIcons: communityTypesIcon);
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
                              Text(communityType,
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
                              ((communityType == 'Private')
                                  ? communityDescription[2]
                                  : (communityType == 'Restricted')
                                      ? communityDescription[1]
                                      : communityDescription[0]),
                              style: TextStyle(
                                  color: ColorManager.eggshellWhite,
                                  fontSize: 15.sp))
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text('Category',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                    DropdownButton(
                        value: category,
                        items: cubit.categories.map((items) {
                          return DropdownMenuItem(
                              value: items.name, child: Text(items.name!));
                        }).toList(),
                        onChanged: (chosenCategory) {
                          category = chosenCategory.toString();
                        }),
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
                          key: const Key('create_community_switch'),
                          value: isSwitched,
                          onToggle: (switcher) {
                            isSwitched = switcher;
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
                      key: const Key('create_community_button'),
                      text: 'Create community',
                      textColor: Colors.white,
                      splashColor: ColorManager.white.withOpacity(0.5),
                      backgroundColor: (isEmpty || !isValidated)
                          ? ColorManager.disabledButtonGrey
                          : ColorManager.blue,
                      buttonWidth: 100.w,
                      buttonHeight: 50,
                      disabled: (isEmpty && !isValidated) ? true : false,
                      textFontSize: 18.sp,
                      textFontWeight: FontWeight.w600,
                      onPressed: (isEmpty || !isValidated)
                          ? () {}
                          : () {
                              cubit.creatCommunity(communityName, communityType,
                                  isSwitched, category);
                            },
                    ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
