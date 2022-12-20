///@author Yasmine Ghanem
///@date 06/12/2022
///choose a topic of a community

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';
import 'package:reddit/widgets/posts/actions_cubit/post_comment_actions_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Topics extends StatefulWidget {
  static const String routeName = 'topics';
  const Topics({super.key});

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  bool isChanged = false;
  bool? chosen = false;

  List<bool?> choices = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    ModerationCubit.get(context).getSuggestedTopics(context);
  }

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: moderationAppBar(context, 'Topics',
              () => cubit.addCommunityTopics(context), cubit.topicChanged),
          body: Column(
            children: [
              Theme(
                data: ThemeData(
                    unselectedWidgetColor: ColorManager.white,
                    checkboxTheme: CheckboxThemeData(
                        checkColor: MaterialStateColor.resolveWith(
                            (states) => ColorManager.blue),
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent))),
                child: Expanded(
                  child: SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                          itemCount: topicsTitles.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CheckboxListTile(
                                  secondary: const Icon(Icons.speaker),
                                  value: choices[index],
                                  onChanged: (choice) {
                                    setState(() {
                                      cubit.selectedTopic = topicsTitles[index];
                                      cubit.topicChanged = true;
                                      choices = choices
                                          .map((value) => false)
                                          .toList();
                                      choices[index] = choice;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(
                                          color: (choices[index] == true)
                                              ? ColorManager.blue
                                              : ColorManager.lightGrey,
                                          width: 0.8)),
                                  tileColor: ColorManager.darkGrey,
                                  title: Text(
                                    topicsTitles[index],
                                    style: const TextStyle(
                                        color: ColorManager.eggshellWhite),
                                  ),
                                ),
                              ))),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
