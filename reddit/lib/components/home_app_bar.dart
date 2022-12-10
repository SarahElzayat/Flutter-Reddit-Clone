/// @author Sarah El-Zayat
/// @date 9/11/2022
/// App bar of the application
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reddit/Screens/create_community_screen/create_community_screen.dart';
import 'package:reddit/components/app_bar_components.dart';
import 'package:reddit/components/home_dropdown_menu.dart';
import 'package:reddit/components/search_field.dart';

import '../cubit/app_cubit.dart';

///@param [index] is the index of the bottom navigation bar screen
///@param [context] is the context of the parent widget
/// returns the app bar of the screen
AppBar homeAppBar(context, index) {
  ///@param [cubit] an instance of the App Cubit to give easier access to the state management cubit
  final AppCubit cubit = AppCubit.get(context);

  ///checks if the it's mobile
  ///depending on the given index the title and actions are changed
  if (!kIsWeb) {
    return AppBar(
      titleSpacing: 0,
      title: cubit.screensNames[index] == 'Home'
          ? const HomeDropdownMenu()
          : cubit.screensNames[index] == 'Discover'
              ? SearchField(textEditingController: TextEditingController())
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
  }

  ///if it's web then display the following
  else {
    return AppBar(
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
              child: SearchField(
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
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateCommunityScreen(),
                  )),
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
