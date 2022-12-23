///@author Sarah Elzayat
///@date 22/12/2022
///@description this file has functions reusable components to open and close drawers

import 'package:flutter/material.dart';
import 'package:reddit/screens/comments/add_comment_screen.dart';

void changeEndDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState!.isEndDrawerOpen
      ? scaffoldKey.currentState?.closeEndDrawer()
      : scaffoldKey.currentState?.openEndDrawer();
  logger.d('CALEED');
}

///The method changes the drawer state from open to closed and vice versa
void changeLeftDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
  scaffoldKey.currentState!.isDrawerOpen
      ? scaffoldKey.currentState?.closeDrawer()
      : scaffoldKey.currentState?.openDrawer();
}
