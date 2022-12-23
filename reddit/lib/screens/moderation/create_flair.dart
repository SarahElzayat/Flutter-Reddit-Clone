import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/helpers/color_manager.dart';
import '../../components/moderation_components/modtools_components.dart';
import '../../components/square_text_field.dart';
import 'content_and_regulation/post_flair-settings.dart';
import 'cubit/moderation_cubit.dart';

class CreateFlair extends StatefulWidget {
  const CreateFlair({super.key});

  @override
  State<CreateFlair> createState() => _CreateFlairState();
}

class _CreateFlairState extends State<CreateFlair> {
  bool edit = false;

  /// determines whether the floating action button is pressed to reflect text color
  bool textColorPicker = false;

  ///the hex value of the text color sent to the add flair function
  String textColor = '#${Colors.black.value.toRadixString(16)}';

  ///contols the text in the flair name textfield
  final TextEditingController _controller = TextEditingController();

  ///determines which color is pressed from the list of colors
  bool colorButtonPressed = false;

  /// the selected color from the colors list
  Color selectedColor = Colors.grey;

  /// the index of the selected color
  int colorIndex = 0;

  /// the hex code of the selected color from the list
  var colorHex = '';

  ///list of available colors for the post flair
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
              () => cubit.addFlair(
                  context,
                  _controller.text,
                  colorHex,
                  (textColorPicker)
                      ? '#${Colors.white.value.toRadixString(16)}'
                      : '#${Colors.black.value.toRadixString(16)}'),
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
                                        colorHex =
                                            '#${selectedColor.value.toRadixString(16)}';
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
