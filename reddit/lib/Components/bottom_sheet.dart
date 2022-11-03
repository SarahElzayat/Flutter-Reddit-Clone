/// Model Bottom Sheet
/// @author Haitham Mohamed
/// @date 26/10/2022

import '../components/helpers/color_manager.dart';
import 'package:flutter/material.dart';

/// This function Shows the proper bottom sheet depends on the inputs
///
/// @param [title] Title of the Bottom Sheet
///
/// @parma [text] The text of each item the will appear
///
/// @param [items] should the same type of selectedItem
/// this parameter used if you don't want to use text and want to use other type in backend like enum
///
/// @param [selectedItem] The item that is selected before
///
/// @params [selectedIcons] and [unselectedIcons] icons that want to show beside text if you want

Future<dynamic> modalBottomSheet(
    {required BuildContext context,
    required String title,
    required List<String> text,
    required dynamic selectedItem,
    Color? backgroundColor,
    Color? titleColor,
    Color? selectedColor,
    Color? unselectedColor,
    List<dynamic>? items,
    List<IconData>? unselectedIcons,
    List<IconData>? selectedIcons}) async {
  /// if items equal null it will be used text instead
  items ??= text;
  backgroundColor ??= ColorManager.bottomSheetBackgound;
  titleColor ??= ColorManager.bottomSheetTitle;
  selectedColor ??= ColorManager.eggshellWhite;
  unselectedColor ??= ColorManager.unselectedItem;
  if (!validations(
      text: text,
      items: items,
      unselectedIcons: unselectedIcons,
      selectedIcons: selectedIcons)) return;
  await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: ((context) {
        final mediaQuery = MediaQuery.of(context);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: backgroundColor,
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  title,
                  style:
                      TextStyle(color: titleColor, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  height: 0.03 * mediaQuery.size.height,
                  color: titleColor,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: mediaQuery.size.height * 0.8,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: text.length,
                    itemBuilder: ((context, index) => Material(
                          color: backgroundColor,
                          child: InkWell(
                            splashColor: backgroundColor,
                            hoverColor: ColorManager.hoverGrey,
                            onTap: (() {
                              selectedItem = items![index];
                              Navigator.of(context).pop();
                            }),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Row(children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: iconOrCheckCircle(
                                        context: context,
                                        index: index,
                                        items: items!,
                                        selectedItem: selectedItem,
                                        text: text[index],
                                        unselectedIcons: unselectedIcons,
                                        selectedIcons: selectedIcons,
                                        selectedColor: selectedColor!,
                                        unselectedColor: unselectedColor!)),
                                Text(
                                  text[index],
                                  style: TextStyle(
                                      fontSize: mediaQuery.textScaleFactor * 17,
                                      color: (items[index] == selectedItem)
                                          ? selectedColor
                                          : unselectedColor),
                                ),
                                const Spacer(),
                                if (unselectedIcons != null &&
                                    items[index] == selectedItem)
                                  Icon(
                                    Icons.done,
                                    size: mediaQuery.textScaleFactor * 23,
                                    color: ColorManager.blue,
                                  ),
                              ]),
                            ),
                          ),
                        ))),
              )
            ],
          ),
        );
      }));
  return selectedItem;
}

/// This function check if all lists have same length or not
///
/// @param [text] List of texts, which are text of each item that will appear
///
/// @param [items] this parameter used in backend instead of text
///
/// @param [selectedIcons] and [unselectedIcons] List of icons that want to show beside text if you want

bool validations({
  required List<String> text,
  required List<dynamic> items,
  required List<IconData>? unselectedIcons,
  required List<IconData>? selectedIcons,
}) {
  if (items.length != text.length) {
    return false;
  }
  if (unselectedIcons != null && selectedIcons != null) {
    if ((unselectedIcons.length != selectedIcons.length) ||
        selectedIcons.length != items.length) {
      return false;
    }
  }
  return true;
}

/// This function show the proper icon depend on its state (selected or not)
///
/// @param [text] The text of the item (one item not list)
///
/// @param [index] The index of the certain item in the list
///
/// @param [items] this parameter used in backend instead of text
///
/// @param [selectedItem] The item that is selected before
///
/// @param [selectedItem] or [unselectedIcons] not exist it shows the check circle icon instead

Widget iconOrCheckCircle({
  required BuildContext context,
  required int index,
  required String text,
  required List<dynamic> items,
  required dynamic selectedItem,
  required Color selectedColor,
  required Color unselectedColor,
  List<IconData>? unselectedIcons,
  List<IconData>? selectedIcons,
}) {
  double size = MediaQuery.of(context).textScaleFactor * 24;
  Color color =
      (items[index] == selectedItem) ? selectedColor : unselectedColor;
  if (unselectedIcons != null && selectedIcons != null) {
    if (items[index] == selectedItem) {
      return Icon(
        selectedIcons[index],
        size: size,
        color: color,
      );
    } else {
      return Icon(
        unselectedIcons[index],
        size: size,
        color: color,
      );
    }
  } else if (items[index] == selectedItem) {
    return Icon(
      Icons.check_circle,
      size: size,
      color: color,
    );
  } else {
    return Icon(
      Icons.circle_outlined,
      size: size,
      color: color,
    );
  }
}
