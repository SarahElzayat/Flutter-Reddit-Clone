///@author yassmine ghanem
///@date 20/11/2022

import 'package:flutter/widgets.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/enums.dart';

class ListTileContainer extends StatelessWidget {
  final String title;

  final TrailingObjects trailingObject;

  final List<String> listTileTitles;

  final List<IconData> listTileIcons;

  // final List<ListTileWidget> listTiles;

  const ListTileContainer(
      {super.key,
      required this.title,
      required this.listTileTitles,
      required this.listTileIcons,
      required this.trailingObject});

  @override
  Widget build(BuildContext context) {
    double fontScale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        Text(
          title,
          style: TextStyle(
              color: ColorManager.lightGrey, fontSize: 12 * fontScale),
        ),
        SizedBox(height: height * 0.02),
        Expanded(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: listTileTitles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTileWidget(
                    leadingIcon: Icon(listTileIcons[index]),
                    title: listTileTitles[index],
                    handler: null,
                    tailingObj: trailingObject);
              }),
        ),
      ],
    );
  }
}
