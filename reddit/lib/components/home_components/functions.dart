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
