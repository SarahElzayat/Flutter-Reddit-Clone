/// @author Abdelaziz Salah
/// @date 26/10/2022
/// This is a listTile bluePrint which is
/// built to be a reuseable widget for further uses
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/local/shared_preferences.dart';
import '../cubit/settings_cubit/settings_cubit.dart';
import '../cubit/settings_cubit/settings_cubit_state.dart';
import 'helpers/color_manager.dart';
import 'helpers/enums.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatefulWidget {
  /// which is the icon shown in the beginning of the row
  final Icon leadingIcon;

  /// which is the text shown next to the icon
  final String title;

  /// which may take one of three values
  ///   3.1- Switch
  ///   3.2- DropBox
  ///   3.3- IconButton
  final TrailingObjects tailingObj;

  /// The items that we are gonna show if we have a dropBox.
  List<String>? items;

  /// function handler which should be executed whenever something is changed
  final handler;

  /// type of the function that should be executed
  final String? type;

  /// type of the function that should be executed
  final String? nextToIcon;
  ListTileWidget(
      {super.key,
      required this.leadingIcon,
      this.nextToIcon,
      // this.initialValue,
      // required this.leadingIcon,
      required this.title,
      required this.handler,
      required this.tailingObj,
      this.type,
      this.items});

  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  bool setBool = false;

  /// this can be either Switch, DropBox or Icon
  String? dropDownValue = 'Empty';

  /// this is a utility function used to load the
  /// user initial values from the cache.
  bool _setBoolDecider() {
    if (widget.title == 'AutoPlay') {
      setBool = CacheHelper.getData(key: 'autoplayMedia');
    } else if (widget.title.contains('Show NSFW content')) {
      setBool = CacheHelper.getData(key: 'nsfw');
    } else if (widget.title.contains('follow you')) {
      setBool = CacheHelper.getData(key: 'allowToFollowYou');
    }
    return setBool;
  }

  /// utility handlertion to build if the tailing object was switch
  Widget buildSwitch(ctx) {
    final mediaQuery = MediaQuery.of(ctx);
    return Container(
      width: mediaQuery.size.width * 0.2,
      height: mediaQuery.size.width * 0.2,
      padding: const EdgeInsets.only(top: 8),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Switch(
          activeColor: ColorManager.blue,
          value: _setBoolDecider(),

          // when we are doing the settings
          onChanged: (value) {
            setState(() {
              if (widget.type != null) {
                SettingsCubit.get(ctx).changeSwitch(value, widget.type!);
              }
              _setBoolDecider();
            });
          },
        ),
      ),
    );
  }

  /// utility handlertion to build if the tailing object was IconButton
  Widget buildIconButton(ctx) {
    final mediaQuery = MediaQuery.of(ctx);
    return SizedBox(
      width: widget.nextToIcon != null
          ? 0.25 * mediaQuery.size.width
          : 0.15 * mediaQuery.size.width,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Row(children: [
          Text(widget.nextToIcon ?? ''),
          IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            ),
            onPressed: widget.handler,
          ),
        ]),
      ),
    );
  }

// { hot, best, top, trending, newPosts, raising, controversial }
  void _setDropDownValue() {
    int res = CacheHelper.getData(key: 'SortHome');
    if (widget.title.contains('Sort home posts by')) {
      switch (res) {
        case 0:
          dropDownValue = 'Hot';
          break;
        case 1:
          dropDownValue = 'Best';
          break;
        case 2:
          dropDownValue = 'Top';
          break;
        case 3:
          dropDownValue = 'Trending';
          break;
        case 4:
          dropDownValue = 'New';
          break;
        case 5:
          dropDownValue = 'Raising';
          break;
        case 6:
          dropDownValue = 'Controversial';
          break;
        default:
          dropDownValue = 'Best';
      }
    } else if (widget.title.contains('Gender')) {
      // dropDownValue = CacheHelper.getData(key: 'gender');
      if (CacheHelper.getData(key: 'gender') == 'man' ||
          CacheHelper.getData(key: 'gender') == 'Male') {
        dropDownValue = 'Male';
      } else {
        dropDownValue = 'Female';
      }
    } else if (widget.title.contains('Google')) {
      String mail = CacheHelper.getData(key: 'googleEmail');
      print('mail is $mail');
      dropDownValue = mail.isEmpty ? 'Disconnected' : 'Connected';
    } else if (widget.title.contains('Facebook')) {
      String mail = CacheHelper.getData(key: 'facebookEmail');
      dropDownValue = mail.isEmpty ? 'Disconnected' : 'Connected';
    }
  }

  /// utility handlertion to build if the tailing object was dropDown
  Widget buildDropDown(ctx) {
    final mediaQuery = MediaQuery.of(ctx);
    _setDropDownValue();
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        // Initial Value
        value: dropDownValue,
        dropdownColor: ColorManager.blueGrey,
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: widget.items?.map((String items) {
          return DropdownMenuItem(
            alignment: Alignment.centerRight,
            value: items,
            child: SizedBox(
                width: mediaQuery.size.width * 0.3,
                height: mediaQuery.size.height * 0.1,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 14.0 * mediaQuery.textScaleFactor),
                  child: Text(
                    items,
                    style: TextStyle(
                        overflow: TextOverflow.clip,
                        fontSize: 16 * mediaQuery.textScaleFactor,
                        color: Colors.white),
                  ),
                )),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          SettingsCubit.get(context)
              .changeDropValue(newValue, widget.type!, context);
          print(newValue);
          _setDropDownValue();
        },
      ),
    );
  }

  /// the build main handlertion
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          child: Material(
            color: ColorManager.darkGrey,
            child: InkWell(
              onTap: widget.handler,
              child: ListTile(
                  //background color of list tile
                  tileColor: ColorManager.darkGrey,

                  /// This is the first el
                  leading: widget.leadingIcon,
                  title: Text(
                    widget.title,
                    style: TextStyle(
                        color: ColorManager.eggshellWhite,
                        fontSize: 15 * MediaQuery.of(context).textScaleFactor),
                  ),

                  /// to set some space between items
                  contentPadding: const EdgeInsets.only(left: 10),

                  /// min width for the fitst item
                  minLeadingWidth: 10,
                  trailing: (widget.tailingObj == TrailingObjects.switchButton)
                      ? buildSwitch(context)
                      : (widget.tailingObj == TrailingObjects.tailingIcon)
                          ? buildIconButton(context)
                          : buildDropDown(context)),
            ),
          ),
        );
      },
    );
  }
}
