import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/moderation_components/modtools_components.dart';
import 'package:reddit/components/square_text_field.dart';
import 'package:reddit/screens/comments/add_comment_screen.dart';
import 'package:reddit/screens/moderation/content_and_regulation/post_flair-settings.dart';
import 'package:reddit/screens/moderation/cubit/moderation_cubit.dart';

class CreateFlair extends StatefulWidget {
  const CreateFlair({super.key});

  @override
  State<CreateFlair> createState() => _CreateFlairState();
}

class _CreateFlairState extends State<CreateFlair> {
  bool edit = false;
  bool textColorPicker = false;
  Color textColor = ColorManager.black;
  final TextEditingController _controller = TextEditingController();
  bool colorButtonPressed = false;
  Color selectedColor = Colors.grey;
  int colorIndex = 0;
  final List<Color> colors = const [
    Color(0xFFC987EA),
    Color(0xFF75A3F3),
    Color(0xFFAC3131),
    Color(0xFFA8D792),
    Color(0xFFEDAAC0),
    Color(0xFFE4BF87),
    Color(0xFFE9E099)
  ];

  @override
  Widget build(BuildContext context) {
    final ModerationCubit cubit = ModerationCubit.get(context);
    return BlocConsumer<ModerationCubit, ModerationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: userManagementAppBar(
              context,
              'Add Flair',
              () => cubit.addFlair(_controller.text, 'FFFFFFFF',
                  (textColorPicker) ? 'FFFFFFFF' : '00000000'),
              true),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                            backgroundColor: ColorManager.black,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const FlairSettings()))),
                            child: const Icon(Icons.settings_outlined,
                                color: ColorManager.grey)),
                      )
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          _controller.text,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColorPicker
                                  ? ColorManager.white
                                  : ColorManager.black),
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 50,
                  ),
                ),
                (colorButtonPressed)
                    ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: colors.length,
                            itemBuilder: ((context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedColor = colors[index];
                                        colorIndex = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: colors[index],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ))))
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      FloatingActionButton(
                        heroTag: 'text_color',
                        backgroundColor: ColorManager.black,
                        onPressed: () {
                          setState(() {
                            textColorPicker = !textColorPicker;
                          });
                        },
                        child: const Icon(Icons.dark_mode),
                      ),
                      const Spacer(),
                      FloatingActionButton(
                          heroTag: 'background_color',
                          backgroundColor: selectedColor,
                          onPressed: () {
                            setState(() {
                              colorButtonPressed = !colorButtonPressed;
                            });
                          })
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        color: ColorManager.darkGrey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Can have text and up to 10 emojis'),
                              const SizedBox(height: 10),
                              SquareTextField(
                                  onChanged: (flairText) {
                                    setState(() {});
                                  },
                                  labelText: 'Type to create flair',
                                  formController: _controller),
                            ]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}