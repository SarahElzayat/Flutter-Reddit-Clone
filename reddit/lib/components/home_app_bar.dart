import 'package:flutter/material.dart';
import 'package:reddit/components/app_bar_components.dart';
import 'package:reddit/components/home_dropdown_menu.dart';
import 'package:reddit/components/search_field.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

import '../cubit/app_cubit.dart';

AppBar homeAppBar(context, index) {
  final AppCubit cubit = AppCubit.get(context);
  bool isAndroid = CacheHelper.getData(key: 'isAndroid')!;

  if (isAndroid) {
    return AppBar(
      titleSpacing: 0,
      title: cubit.screensNames[index] == 'Home'
          ? const HomeDropdownMenu()
          : cubit.screensNames[index] == 'Discover'
              ? SearchFiled(textEditingController: TextEditingController())
              : cubit.screensNames[index] == 'Inbox'
                  ? const Text('Inbox')
                  : null,
      actions: [
        cubit.screensNames[index] == 'Home'
            ? IconButton(
                onPressed: () => navigateToSearch(context),
                icon: const Icon(Icons.search))
            : cubit.screensNames[index] == 'Inbox'
                ? IconButton(
                    onPressed: () {}, icon: const Icon(Icons.more_vert))
                : cubit.screensNames[index] == 'Chat'
                    ? IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_comment_outlined))
                    : const Text(''),
        InkWell(
            // padding: EdgeInsets.zero,
            onTap: () => cubit.changeEndDrawer(),
            //Scaffold.of(context).isEndDrawerOpen? Scaffold.of(context).closeEndDrawer():Scaffold.of(context).openDrawer(),
            child: avatar())
      ],
    );
  } else {
    return AppBar(
      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Image.asset(
              'assets/images/Reddit_Lockup_OnDark.png',
              scale: 6,
            ),
            const HomeDropdownMenu(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: SearchFiled(
                textEditingController: TextEditingController(),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat_outlined),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            avatar(),
          ],
        ),
      ),
    );
  }
}
