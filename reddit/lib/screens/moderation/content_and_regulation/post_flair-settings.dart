import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/bottom_sheet.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/helpers/enums.dart';
import '../../../components/list_tile.dart';
import '../../../components/moderation_components/modtools_components.dart';
import '../cubit/moderation_cubit.dart';

class FlairSettings extends StatefulWidget {
  const FlairSettings({super.key});

  @override
  State<FlairSettings> createState() => _FlairSettingsState();
}

class _FlairSettingsState extends State<FlairSettings> {
  bool modSwitch = false;
  bool userSwitch = false;
  dynamic flairAllows;
  dynamic noOfEmojis;
  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.darkGrey,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back)),
            title: const Text('Flair settings'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: rowSwitch('Mod only', cubit.modOnly, (value) {
                  setState(() {
                    cubit.modOnly = value;
                  });
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: rowSwitch(
                    'Allow user edits',
                    (cubit.modOnly) ? false : cubit.allowUser,
                    cubit.modOnly
                        ? (value) {
                            cubit.allowUser = false;
                            setState(() {});
                          }
                        : (value) {
                            setState(() {
                              cubit.allowUser = value;
                            });
                          }),
              ),
              (userSwitch)
                  ? ListTileWidget(
                      leadingIcon: const Icon(Icons.label_important_outline),
                      title: 'This flair allows',
                      handler: () async {
                        cubit.flairType = await modalBottomSheet(
                            context: context,
                            title: '',
                            text: ['Text & emoji', 'Emoji only', 'Text only'],
                            selectedItem: cubit.flairType);
                        setState(() {});
                      },
                      tailingObj: TrailingObjects.dropBox)
                  : const SizedBox(),
              (userSwitch)
                  ? ListTileWidget(
                      leadingIcon: const Icon(Icons.emoji_emotions_outlined),
                      title: 'Max number of emojis',
                      handler: () async {
                        cubit.emojisLimit = await modalBottomSheet(
                            context: context,
                            title: '',
                            text: [
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10'
                            ],
                            selectedItem: cubit.emojisLimit);
                        setState(() {});
                      },
                      tailingObj: TrailingObjects.dropBox)
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
