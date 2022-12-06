/// @author Sarah El-Zayat
/// @date 9/11/2022
/// App bar of the application
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/components/app_bar_components.dart';
import 'package:reddit/components/home_dropdown_menu.dart';
import 'package:reddit/components/search_field.dart';

import '../cubit/app_cubit.dart';

AppBar homeAppBar(context, index) {
  final AppCubit cubit = AppCubit.get(context);

  if (!kIsWeb) {
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
        InkWell(onTap: () => cubit.changeRightDrawer(), child: avatar())
      ],
    );
  } else {
    return AppBar(
      // leading: null,
      actions: [Container()],
      automaticallyImplyLeading: false,

      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            InkWell(
              onTap: () => cubit.changeLeftDrawer(),
              child: Image.asset(
                'assets/images/Reddit_Lockup_OnDark.png',
                scale: 6,
              ),
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
            InkWell(onTap: () => cubit.changeRightDrawer(), child: avatar())
          ],
        ),
      ),
    );
  }
}
