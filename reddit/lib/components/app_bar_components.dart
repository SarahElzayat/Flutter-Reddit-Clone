/// @author Sarah El-Zayat
/// @date 9/11/2022
/// The file contains helping components for the app bar
import 'package:flutter/material.dart';
import '../screens/search/search_screen.dart';

///@param [image] is the user's profile picture
/// the functions returns the user's profile picture as a circle avatara
Widget avatar({image}) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: CircleAvatar(
      radius: 15,
      child: image ??
          Image.asset(
            'assets/images/Logo.png',
          ),
    ),
  );
}

/// the method navigates to search screen
/// @param [context] is the context of the screen that's required to navigate to
Future<Object?> navigateToSearch(context) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SearchScreen()));
}
