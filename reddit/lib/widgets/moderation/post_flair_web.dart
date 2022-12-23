///@author: Yasmine Ghanem
///@date: 22/12/2022
///this screen post flair related widgets in web

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/button.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class WebPostFlair extends StatefulWidget {
  const WebPostFlair({super.key});

  @override
  State<WebPostFlair> createState() => _WebPostFlairState();
}

class _WebPostFlairState extends State<WebPostFlair> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    ModerationCubit.get(context).getPostFlairs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //to access cubit members and functions from this widget
    final ModerationCubit cubit = ModerationCubit.get(context);

    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      //build widget ewhenever a state is changed
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 10.h,
              color: ColorManager.darkGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Button(
                      //shows the dialog to edit post flair settings
                      onPressed: () => postFalirSettingsDialog(context),
                      text: 'Post flair settings',
                      buttonWidth: 14.w,
                      buttonHeight: 5.h,
                      textColor: ColorManager.black,
                      splashColor: Colors.transparent,
                      backgroundColor: ColorManager.eggshellWhite,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Button(
                      //shows the dialog to add a new post flair
                      onPressed: () => addFlairDialog(context),
                      text: 'Add flair',
                      buttonWidth: 10.w,
                      buttonHeight: 5.h,
                      textColor: ColorManager.black,
                      splashColor: Colors.transparent,
                      backgroundColor: ColorManager.eggshellWhite,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Post flair management',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.eggshellWhite,
                      fontWeight: FontWeight.w300)),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: ColorManager.betterDarkGrey,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              width: 70.w,
              height: 60.h,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text('POST FLAIR PREVIEW',
                            style: TextStyle(
                                color: ColorManager.textGrey, fontSize: 10.sp)),
                        const Spacer(),
                        Text('SETTINGS',
                            style: TextStyle(
                                color: ColorManager.textGrey, fontSize: 10.sp)),
                        const Spacer(),
                        Text('FLAIR ID',
                            style: TextStyle(
                                color: ColorManager.textGrey, fontSize: 10.sp)),
                      ],
                    ),
                  ),
                  //checks if the post flairs list is empty to show user that list is empty
                  (cubit.postFlairs.isEmpty)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(height: 100),
                            Icon(Icons.label_outline),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('You do not have any post flair'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                  'Create post flair in your community today'),
                            ),
                          ],
                        )
                      //otherwise it shows a list view of all available post flairs in the community
                      : Expanded(
                          child: ListView.builder(
                          itemCount: cubit.postFlairs.length,
                          itemBuilder: ((context, index) => ListTile(
                                  leading: Container(
                                color: Color(int.parse(
                                    cubit.postFlairs[index].backgroundColor)),
                                child: Text(
                                  cubit.postFlairs[index].flairName,
                                  style: TextStyle(
                                      color: Color(int.parse(
                                          cubit.postFlairs[index].textColor))),
                                ),
                              ))),
                        ))
                ],
              ),
            )
          ],
        );
      },
    );
  }

  ///@param [context] current screen context
  ///shows a dialog to add a post flair
  ///edits the flair appearance and settings
  addFlairDialog(
    context,
  ) {
    // checks whether the text color floating action button is pressed or not
    // toggles color of text color between black and white
    bool isPressed = false;

    // the backgroud color of the flair
    Color backgroundColor = Colors.white;

    String hexColor = '';

    //controls the text field of the post flair name
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.all(12.sp),
                  actionsPadding: const EdgeInsets.all(0),
                  backgroundColor: ColorManager.greyBlack,
                  content: SizedBox(
                      width: 50.w,
                      height: 60.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add flair',
                              style: TextStyle(
                                  color: ColorManager.eggshellWhite,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300)),
                          const Divider(),
                          Row(
                            children: [
                              SizedBox(
                                width: 25.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('FLAIR APPEARANCE'),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Flair text'),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      child: SquareTextField(
                                          formController: controller,
                                          labelText: 'flair text'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          const Text('Flair background color'),
                                          const Spacer(),
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: FloatingActionButton(
                                                backgroundColor:
                                                    backgroundColor,
                                                mini: true,
                                                onPressed: () => showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          StatefulBuilder(
                                                              builder: (context,
                                                                      setState) =>
                                                                  AlertDialog(
                                                                    content:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          MaterialColorPicker(
                                                                        selectedColor:
                                                                            backgroundColor, //default color
                                                                        onColorChange:
                                                                            (Color
                                                                                color) {
                                                                          hexColor =
                                                                              '0x${color.value.toRadixString(16)}';
                                                                          backgroundColor =
                                                                              color;
                                                                          Navigator.pop(
                                                                              context);
                                                                          ;
                                                                        },
                                                                        //showa all available colors available for a post flair
                                                                        colors: const [
                                                                          Colors
                                                                              .red,
                                                                          Colors
                                                                              .deepOrange,
                                                                          Colors
                                                                              .yellow,
                                                                          Colors
                                                                              .lightGreen,
                                                                          Colors
                                                                              .pink,
                                                                          Colors
                                                                              .purple,
                                                                          Colors
                                                                              .blue,
                                                                          Colors
                                                                              .brown,
                                                                          Colors
                                                                              .amber,
                                                                          Colors
                                                                              .blueGrey,
                                                                          Colors
                                                                              .cyanAccent
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )),
                                                    )),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: [
                                          const Text('Flair text color'),
                                          const Spacer(),
                                          SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: FloatingActionButton(
                                                  backgroundColor: isPressed
                                                      ? Colors.white
                                                      : Colors.black,
                                                  mini: true,
                                                  onPressed: () => setState(() {
                                                        isPressed = !isPressed;
                                                      }))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 25.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('FLAIR SETTINGS'),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: rowSwitch(
                                          'Mod only',
                                          ModerationCubit.get(context).modOnly,
                                          (value) =>
                                              ModerationCubit.get(context)
                                                  .setModOnlySwitch(value)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: rowSwitch(
                                          'Allow user edits',
                                          ModerationCubit.get(context)
                                              .allowUser,
                                          (value) =>
                                              ModerationCubit.get(context)
                                                  .setAllowUserEdits(value)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                  actions: [
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              onPressed: () => Navigator.pop(context),
                              text: 'Cancel',
                              buttonWidth: 7.w,
                              buttonHeight: 5.h,
                              textColor: ColorManager.eggshellWhite,
                              backgroundColor: ColorManager.grey,
                              textFontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              onPressed: () => ModerationCubit.get(context).addFlair(
                                  context,
                                  controller.text,
                                  hexColor,
                                  isPressed
                                      ? '0x${Colors.white.value.toRadixString(16)}'
                                      : '0x${Colors.black.value.toRadixString(16)}'),
                              text: 'Add flair',
                              buttonWidth: 7.w,
                              buttonHeight: 5.h,
                              textColor: ColorManager.deepDarkGrey,
                              backgroundColor: ColorManager.eggshellWhite,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ))));
  }

  ///@param [context] screen context
  ///shows a pop up dialog to edit post flair settings
  ///flairs can be disabled or enabled for a community
  ///can allow or unallow users to edit a flair
  postFalirSettingsDialog(context) {
    bool? enabledPostFlair =
        ModerationCubit.get(context).postFlairSetting.enablePostFlairs ?? false;
    bool? allowUserEdits =
        ModerationCubit.get(context).postFlairSetting.allowUsers ?? false;

    return showDialog(
        context: context,
        builder: ((context) => StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  contentPadding: EdgeInsets.all(12.sp),
                  actionsPadding: const EdgeInsets.all(0),
                  backgroundColor: ColorManager.greyBlack,
                  content: SizedBox(
                    width: 30.w,
                    height: 35.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Post flair settings',
                                style: TextStyle(
                                    color: ColorManager.eggshellWhite,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300)),
                            const Spacer(),
                            IconButton(
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: rowSwitch(
                              'Enable post flair in this community',
                              enabledPostFlair,
                              (value) => setState(() {
                                    enabledPostFlair = value;
                                    ModerationCubit.get(context)
                                        .postFlairSetting
                                        .enablePostFlairs = value;
                                  })),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: rowSwitch(
                              'Allow users to assign their own',
                              allowUserEdits,
                              (value) => setState(() {
                                    enabledPostFlair = value;
                                    ModerationCubit.get(context)
                                        .postFlairSetting
                                        .allowUsers = value;
                                  })),
                        ),
                        Text(
                          'This will let users select, edit, and clear post flair for their posts in this community. This does not allow users to select or edit mod-only post flair.',
                          style: TextStyle(
                              color: ColorManager.textGrey,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w200),
                        )
                      ],
                    ),
                  ),
                  actions: [
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              onPressed: () => Navigator.pop(context),
                              text: 'Cancel',
                              buttonWidth: 7.w,
                              buttonHeight: 5.h,
                              textColor: ColorManager.eggshellWhite,
                              backgroundColor: ColorManager.grey,
                              textFontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Button(
                              onPressed: () {},
                              text: 'Save',
                              buttonWidth: 7.w,
                              buttonHeight: 5.h,
                              textColor: ColorManager.deepDarkGrey,
                              backgroundColor: ColorManager.eggshellWhite,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )))));
  }
}
