import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/router.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/button.dart';
import '../../../components/default_text_field.dart';
import '../../../components/helpers/color_manager.dart';

class Description extends StatefulWidget {
  static const String routeName = 'description';
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final TextEditingController controller = TextEditingController();
  bool isEmpty = true;
  String communityName = '';

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context)
      ..getCommunitySettings(communityName, context);
    return BlocConsumer<ModerationCubit, ModerationState>(
        listener: (context, state) {},
        builder: ((context, state) {
          return Scaffold(
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                                  backgroundColor: ColorManager.darkGrey,
                                  content: SizedBox(
                                    height: 10.h,
                                    width: 90.w,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Leave without saving',
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: ColorManager
                                                      .eggshellWhite)),
                                          const Spacer(),
                                          const Text(
                                              'you cannot undo this action')
                                        ]),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Button(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          buttonHeight: 5.h,
                                          buttonWidth: 35.w,
                                          text: 'CANCEL',
                                          textFontSize: 16.sp,
                                          textColor: ColorManager.lightGrey,
                                          backgroundColor: ColorManager.grey,
                                          splashColor: ColorManager.lightGrey,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Button(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                AppRouter.onGenerateRoute(
                                                    const RouteSettings(
                                                        name:
                                                            '/mod_tools_screen')));
                                          },
                                          buttonHeight: 5.h,
                                          buttonWidth: 35.w,
                                          text: 'LEAVE',
                                          textFontSize: 16.sp,
                                        ),
                                      ],
                                    )
                                  ],
                                ))),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 24.sp,
                    )),
                backgroundColor: ColorManager.darkGrey,
                title: const Text('Description'),
                actions: [
                  Button(
                      onPressed: (cubit.isChanged && !cubit.emptyDescription)
                          ? () {
                              cubit.saveDescription(controller.text);
                            }
                          : () {},
                      text: 'Save',
                      textFontSize: 16.sp,
                      buttonHeight: 5.h,
                      buttonWidth: 20.w,
                      textColor: (cubit.isChanged && !cubit.emptyDescription)
                          ? ColorManager.blue
                          : ColorManager.darkBlue,
                      backgroundColor: ColorManager.darkGrey,
                      splashColor: ColorManager.grey,
                      disabled: cubit.isChanged,
                      borderRadius: 4.0)
                ]),
            body: Container(
                color: ColorManager.darkGrey,
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: DefaultTextField(
                  formController: controller,
                  labelText: 'Describe you community',
                  maxLength: 500,
                  onChanged: (description) {
                    // print(cubit.isChanged);
                    cubit.onChanged(controller.text);
                    // print(cubit.isChanged);
                  },
                ))),
          );
        }));
  }
}
