/// @author Sarah El-Zayat
/// @date 9/11/2022
/// Home dropdown menu to choose between popular and home
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

import '../cubit/app_cubit/app_cubit.dart';

class HomeDropdownMenu extends StatefulWidget {
  const HomeDropdownMenu({super.key});

  @override
  State<HomeDropdownMenu> createState() => _HomeDropdownMenuState();
}

class _HomeDropdownMenuState extends State<HomeDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    final AppCubit cubit = AppCubit.get(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          items: cubit.homeMenuItems
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        Text(item,
                            style: kIsWeb
                                ? Theme.of(context).textTheme.titleLarge
                                : Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ))
              .toList(),
          value: cubit.homeMenuItems[cubit.homeMenuIndex],
          onChanged: (value) {
            setState(() {
              cubit.homeMenuIndex = cubit.homeMenuItems.indexOf(value);
              cubit.changeHomeMenuIndex(cubit.homeMenuItems.indexOf(value));
            });
          },
          selectedItemHighlightColor: ColorManager.grey, //.withOpacity(.3),
          dropdownDecoration: const BoxDecoration(
            // borderRadius: BorderRadius.circular(14),
            color: ColorManager.black,
          ),
          dropdownWidth: !kIsWeb
              ? MediaQuery.of(context).size.width
              : 300,
          buttonWidth: kIsWeb
              ? MediaQuery.of(context).size.width * 0.2
              : null,
          // barrierColor: ColorManager.black, //DA 7ELW MOMKEN A7TAGO
        ),
      ),
    );
  }
}
