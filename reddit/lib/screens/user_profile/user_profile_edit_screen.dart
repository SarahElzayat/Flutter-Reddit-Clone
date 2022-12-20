import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/bottom_sheet.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/user_profile/cubit/user_profile_cubit.dart';
import '../../networks/constant_end_points.dart';
import '../../widgets/user_profile/user_profile_eidt_image.dart';

class UserProfileEditScreen extends StatefulWidget {
  UserProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileEditScreen> createState() => _UserProfileEditScreenState();

  static const routeName = '/user_profile_edit_screen_route';
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  late TextEditingController displatNameController;

  late TextEditingController aboutUserController;

  late TextEditingController linkTextController = TextEditingController();

  late TextEditingController linkUrlController = TextEditingController();

  List<String> text = [];
  List<String> url = [];

  bool canAddLink = false;
  @override
  void initState() {
    displatNameController = TextEditingController(
        text: UserProfileCubit.get(context).userData!.displayName);

    aboutUserController = TextEditingController(
        text: UserProfileCubit.get(context).userData!.about);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = UserProfileCubit.get(context);
    return WillPopScope(
      onWillPop: () async {
        UserProfileCubit.get(context).img = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
          actions: [
            TextButton(
                onPressed: () {
                  userProfile.changeUserProfileInfo(
                      context,
                      displatNameController.text,
                      aboutUserController.text,
                      userProfile.img);
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: ColorManager.blue),
                ))
          ],
        ),
        body: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserProfileEditImage(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'Display name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                            // height: 30,
                            color: ColorManager.darkGrey,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: displatNameController,
                                maxLength: 30,
                                cursorColor: ColorManager.blue,
                                style: const TextStyle(fontSize: 18),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      color: ColorManager.bottomSheetTitle),
                                  hintText: 'Shown on your profile page',
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'This will be displayed to viewers of your profile page and does not change your username',
                            style:
                                TextStyle(color: ColorManager.bottomSheetTitle),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'About you',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                            // height: 30,
                            color: ColorManager.darkGrey,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: aboutUserController,
                                maxLength: 200,
                                // expands: true,
                                maxLines: 4,
                                minLines: 4,
                                cursorColor: ColorManager.blue,
                                style: const TextStyle(fontSize: 18),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                      color: ColorManager.bottomSheetTitle),
                                  hintText: 'A little description of yourself',
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            'Social Links (5 max)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const Text(
                          'People who visit your Reddit profile will see your social links',
                          style:
                              TextStyle(color: ColorManager.bottomSheetTitle),
                        ),
                        BlocBuilder<UserProfileCubit, UserProfileState>(
                          buildWhen: ((previous, current) {
                            if (previous is ChangeUserProfileSocialLinks ||
                                current is ChangeUserProfileSocialLinks) {
                              return true;
                            } else {
                              return false;
                            }
                          }),
                          builder: (context, state) {
                            return Wrap(
                              spacing: 5,
                              children: [
                                for (int i = 0;
                                    i <
                                        userProfile
                                            .userData!.socialLinks!.length;
                                    i++)
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: InkWell(
                                      onTap: () {
                                        userProfile.deleteSocialLink(
                                            context,
                                            userProfile.userData!
                                                .socialLinks![i].displayText!,
                                            userProfile.userData!
                                                .socialLinks![i].link!,
                                            i);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: ColorManager.grey,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(userProfile
                                                  .userData!
                                                  .socialLinks![i]
                                                  .displayText!),
                                              Icon(Icons.close),
                                            ]),
                                      ),
                                    ),
                                  ),
                                if (userProfile.userData!.socialLinks!.length <
                                    5)
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: InkWell(
                                      onTap: (() {
                                        modelBottomSheet(userProfile);
                                      }),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: ColorManager.grey,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.add),
                                              Text('Add')
                                            ]),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void modelBottomSheet(UserProfileCubit userProfile) {
    showModalBottomSheet(
        isScrollControlled: true,
        // enableDrag: false,

        context: context,
        builder: ((context2) {
          return Container(
            color: ColorManager.darkGrey,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add Social Link',
                        style: TextStyle(
                            fontSize: 20, color: ColorManager.eggshellWhite),
                      ),
                      IconButton(
                          onPressed: (canAddLink)
                              ? () {
                                  userProfile.addSocialLink(
                                      context,
                                      linkTextController.text.toString(),
                                      linkUrlController.text.toString());

                                  Navigator.of(context).pop();
                                }
                              : null,
                          icon: Icon(
                            Icons.done,
                            color: (canAddLink)
                                ? ColorManager.blue
                                : ColorManager.unselectedItem,
                          ))
                    ],
                  ),
                ),
                // Divider(),
                Container(
                  color: ColorManager.deepDarkGrey,
                  margin: const EdgeInsets.all(7),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        canAddLink = (linkTextController.text.isNotEmpty &&
                            linkUrlController.text.isNotEmpty &&
                            Uri.parse(linkUrlController.text).isAbsolute);
                      });
                    },
                    controller: linkTextController,
                    style: const TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        label: Text('Display text'),
                        labelStyle: TextStyle(fontSize: 22)),
                  ),
                ),
                Container(
                  color: ColorManager.deepDarkGrey,
                  margin: const EdgeInsets.all(7),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        canAddLink = (linkTextController.text.isNotEmpty &&
                            linkUrlController.text.isNotEmpty &&
                            Uri.parse(linkUrlController.text).isAbsolute);
                      });
                    },
                    controller: linkUrlController,
                    style: const TextStyle(fontSize: 22),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        label: Text('https://website.com'),
                        labelStyle: TextStyle(fontSize: 22)),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
