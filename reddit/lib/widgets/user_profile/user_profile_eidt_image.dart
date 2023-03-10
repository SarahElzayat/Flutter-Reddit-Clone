import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/user_profile/cubit/user_profile_cubit.dart';
import '../../screens/settings/change_profile_picture_screen.dart';

import '../../components/helpers/color_manager.dart';
import '../../networks/constant_end_points.dart';


/// Edit Profile picture and banner
class UserProfileEditImage extends StatefulWidget {
  UserProfileEditImage({Key? key}) : super(key: key);

  @override
  State<UserProfileEditImage> createState() => _UserProfileEditImageState();
}

class _UserProfileEditImageState extends State<UserProfileEditImage> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    final userProfile = UserProfileCubit.get(context);
    return SizedBox(
      width: mediaquery.size.width,
      height: 145,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            child: DottedBorder(
                dashPattern: const [10, 5],
                color: (true) ? ColorManager.white : ColorManager.black,
                child: SizedBox(
                  width: mediaquery.size.width,
                  height: 120,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      (userProfile.img != null)
                          ? (kIsWeb)
                              ? Image.network(userProfile.img!.path)
                              : Image.file(
                                  File(userProfile.img!.path),
                                  fit: BoxFit.fitWidth,
                                )
                          : (userProfile.userData!.banner != null &&
                                  userProfile.userData!.banner != '')
                              ? Image.network(
                                  '$baseUrl/${userProfile.userData!.banner!}',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/profile_banner.jpg',
                                  fit: BoxFit.fitWidth,
                                ),
                      Center(
                        child: IconButton(
                          onPressed: (() async {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                var pickedImg =
                                                    await _picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {
                                                  if (pickedImg != null) {
                                                    userProfile.img = pickedImg;
                                                  }
                                                });
                                                navigator.pop();
                                              },
                                              child: const Text('Add Banner')),
                                          TextButton(
                                              onPressed: () {
                                                userProfile.deleteBannerImage();
                                                navigator.pop();
                                              },
                                              child:
                                                  const Text('Remove Banner'))
                                        ]),
                                  );
                                }));
                          }),
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              height: 60,
              width: 60,
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangeProfilePicutre(),
                    )),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: (kIsWeb) ? Colors.transparent : null,
                      radius: 40,
                      backgroundImage: (!kIsWeb)
                          ? (userProfile.userData!.picture == null ||
                                  userProfile.userData!.picture == '')
                              ? Image.asset('assets/images/Logo.png')
                                  as ImageProvider
                              : NetworkImage(
                                  '$baseUrl/${userProfile.userData!.picture!}',
                                  // fit: BoxFit.cover,
                                )
                          : null,
                      child: (kIsWeb)
                          ? (userProfile.userData!.picture == null ||
                                  userProfile.userData!.picture == '')
                              ? Image.asset('assets/images/Logo.png')
                              : Image.network(
                                  '$baseUrl/${userProfile.userData!.picture!}',
                                  // fit: BoxFit.cover,
                                )
                          : null,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                            onTap: (() {}),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              shadows: <Shadow>[
                                Shadow(color: Colors.black, blurRadius: 20.0),
                                Shadow(color: Colors.black, blurRadius: 20.0)
                              ],
                            )))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
