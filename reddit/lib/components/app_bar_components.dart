/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The file contains helping components for the app bar
import 'package:flutter/material.dart';

import '../screens/search/search_screen.dart';

Widget avatar({image}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: CircleAvatar(
      radius: 15,
      child: Image.asset(
        'assets/images/Logo.png',
      ),
    ),
  );
}

Future<Object?> navigateToSearch(context) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SearchScreen()));
}
