///@author yassmine ghanem
///@date 20/11/2022
/// this is a common container for the list tiles because
/// it is used alot in the mod tools
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/list_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListTileContainer extends StatefulWidget {
  final String title;

  final TrailingObjects trailingObject;

  final List<String> listTileTitles;

  final List<IconData> listTileIcons;

  final List<Function> listTileFunctions;

  const ListTileContainer(
      {super.key,
      required this.title,
      required this.listTileTitles,
      required this.listTileIcons,
      required this.trailingObject,
      required this.listTileFunctions});

  @override
  State<ListTileContainer> createState() => _ListTileContainerState();
}

class _ListTileContainerState extends State<ListTileContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          widget.title,
          style: TextStyle(color: ColorManager.lightGrey, fontSize: 16.sp),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: widget.listTileTitles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTileWidget(
                  leadingIcon: Icon(widget.listTileIcons[index]),
                  title: widget.listTileTitles[index],
                  handler: widget.listTileFunctions[index],
                  tailingObj: widget.trailingObject,
                );
              }),
        ),
      ],
    );
  }
}
