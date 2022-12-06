import 'package:flutter/material.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/data/routes.dart';
import 'package:reddit/screens/moderation/general_screens/welcome_message/add_edit_message.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:reddit/components/helpers/color_manager.dart';

class WelcomeMessage extends StatefulWidget {
  static const String routeName = 'welcome_message';
  const WelcomeMessage({super.key});

  @override
  State<WelcomeMessage> createState() => _WelcomeMessageState();
}

class _WelcomeMessageState extends State<WelcomeMessage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.sp,
        shadowColor: ColorManager.white,
        title: const Text('Welcome Message'),
        backgroundColor: ColorManager.darkGrey,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
          // padding: const EdgeInsets.all(8),
          height: 30.h,
          color: ColorManager.darkGrey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text('Send welcome message to new members'),
                    const Spacer(),
                    FlutterSwitch(
                      key: const Key('create_community_switch'),
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Create a custom message that new members will see as a prompt after joining and/or as a direct message to their inbox.',
                    style: TextStyle(
                        color: ColorManager.lightGrey, fontSize: 16.sp)),
              ),
              ListTile(
                title: const Text('Add/Edit Message'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddEditMessage())),
              ),
              Button(
                  onPressed: () {},
                  text: 'PREVIEW MESSAGE',
                  splashColor: ColorManager.white.withOpacity(0.5),
                  buttonHeight: 5.h,
                  buttonWidth: 30.w)
            ],
          )),
    );
  }
}
