import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/widgets/user_profile/user_profile_eidt_image.dart';

class UserProfileEditScreen extends StatelessWidget {
  const UserProfileEditScreen({Key? key}) : super(key: key);

  static const routeName = '/user_profile_edit_screen_route';

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'SAVE',
                style: TextStyle(color: ColorManager.blue),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileEditImage(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Display name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                      // height: 30,
                      color: ColorManager.darkGrey,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 30,
                          cursorColor: ColorManager.blue,
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration(
                            hintStyle:
                                TextStyle(color: ColorManager.bottomSheetTitle),
                            hintText: 'Shown on your profile page',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'This will be displayed to viewers of your profile page and does not change your username',
                      style: TextStyle(color: ColorManager.bottomSheetTitle),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'About you',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                      // height: 30,
                      color: ColorManager.darkGrey,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          maxLength: 200,
                          // expands: true,
                          maxLines: 4,
                          minLines: 4,
                          cursorColor: ColorManager.blue,
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration(
                            hintStyle:
                                TextStyle(color: ColorManager.bottomSheetTitle),
                            hintText: 'A little description of yourself',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Social Links (5 max)',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const Text(
                    'People who visit your Reddit profile will see your social links',
                    style: TextStyle(color: ColorManager.bottomSheetTitle),
                  ),
                  Wrap(
                    spacing: 2,
                    children: [
                      // for (int i = 0; i < 7; i++)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: (() {}),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                color: ColorManager.grey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [Icon(Icons.add), Text('Add')]),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
