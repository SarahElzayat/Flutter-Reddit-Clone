///@author yassmine ghanem
///@date 20/11/2022
/// this is a common container for the list tiles because
/// it is used alot in the mod tools

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../components/helpers/color_manager.dart';
import '../../../components/helpers/enums.dart';
import '../../../components/list_tile.dart';

class ListTileContainer extends StatelessWidget {
  final String title;

  /// the type of the trailing object
  final List<TrailingObjects> trailingObject;

  /// list of titles that represent each item in the listTile
  final List<String> listTileTitles;

  /// list if icons that should be shown in order
  final List<IconData> listTileIcons;

  /// this is the items that should be shown in the dropBox
  /// if the Trailing object was a dropbox.
  final List<List<String>> items;

  /// TODO: this should be a list of handlers,
  /// where each item has its own handler
  /// this is the function that should be executed
  /// when the user presses on the listTile.
  List<Function> handler = [];
  ListTileContainer(
      {super.key,
      required this.handler,
      this.items = const [],
      required this.title,
      required this.listTileTitles,
      required this.listTileIcons,
      required this.trailingObject});

  /// this is a funtion used to return the strings used if there is a dropBox.
  /// @param [index] is the index of the loop because this function should be
  /// called inside a loop.
  List<String> ourItems(index) {
    /// TODO: this should work even if we didn't send items and same for the handlers list
    return items.isEmpty
        ? []
        : items[index].isEmpty
            ? []
            : items[index];
  }

  @override
  Widget build(BuildContext context) {
    double fontScale = MediaQuery.of(context).textScaleFactor;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(
                color: ColorManager.lightGrey, fontSize: 12 * fontScale),
          ),
        ),
        SizedBox(height: height * 0.02),
        Expanded(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: listTileTitles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTileWidget(
                    items: ourItems(index),
                    leadingIcon: Icon(listTileIcons[index]),
                    title: listTileTitles[index],
                    handler: handler[index],
                    tailingObj: trailingObject[index]);
              }),
        ),
      ],
    );
  }
}
