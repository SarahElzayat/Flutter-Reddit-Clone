/// Model Bottom Sheet
/// @author Haitham Mohamed
/// @date 26/10/2022

import 'package:bottomsheet/color.dart';
import 'package:flutter/material.dart';

/// This function Shows the proper bottom sheet depends on the inputs
///
/// [items]  should the same type of selectedItem
/// this parameter used if you don't want to use text and want to use other type in backend like enum

Future<dynamic> modalBottomSheet(
    {required BuildContext context,
    required String title,
    required List<String> text,
    required dynamic selectedItem,
    List<dynamic>? items,
    List<IconData>? unselectedIcons,
    List<IconData>? selectedIcons}) async {
  /// if items equal null it will be used text instead
  items ??= text;
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
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFF212121),
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
                  style: const TextStyle(
                      color: Color.fromRGBO(129, 131, 132, 1),
                      fontWeight: FontWeight.w900),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  height: 20,
                  color: Color.fromRGBO(129, 131, 132, 1),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 0,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: text.length,
                    itemBuilder: ((context, i) => Material(
                          color: const Color(0xFF212121),
                          child: InkWell(
                            splashColor: const Color(0xFF212121),
                            hoverColor: ColorManager.hoverGrey,
                            onTap: (() {
                              selectedItem = items![i];
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
                                        i: i,
                                        items: items!,
                                        selectedItem: selectedItem,
                                        text: text[i],
                                        unselectedIcons: unselectedIcons,
                                        selectedIcons: selectedIcons)),
                                Text(
                                  text[i],
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context)
                                              .textScaleFactor *
                                          17,
                                      color: (items[i] == selectedItem)
                                          ? ColorManager.eggshellWhite
                                          : const Color.fromRGBO(
                                              86, 87, 88, 1)),
                                ),
                                const Spacer(),
                                (unselectedIcons != null &&
                                        items[i] == selectedItem)
                                    ? Icon(
                                        Icons.done,
                                        size: MediaQuery.of(context)
                                                .textScaleFactor *
                                            23,
                                        color: ColorManager.blue,
                                      )
                                    : const SizedBox()
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
/// if [selectedItem] or [unselectedIcons] not exist it shows the check circle icon instead
Widget iconOrCheckCircle({
  required BuildContext context,
  required int i,
  required String text,
  required List<dynamic> items,
  required dynamic selectedItem,
  List<IconData>? unselectedIcons,
  List<IconData>? selectedIcons,
}) {
  double size = MediaQuery.of(context).textScaleFactor * 24;
  Color color = (items[i] == selectedItem)
      ? ColorManager.eggshellWhite
      : const Color.fromRGBO(86, 87, 88, 1);
  if (unselectedIcons != null && selectedIcons != null) {
    if (items[i] == selectedItem) {
      return Icon(
        selectedIcons[i],
        size: size,
        color: color,
      );
    } else {
      return Icon(
        unselectedIcons[i],
        size: size,
        color: color,
      );
    }
  } else if (items[i] == selectedItem) {
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
