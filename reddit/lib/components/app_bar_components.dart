import 'package:flutter/material.dart';

import '../Screens/search/search_screen.dart';

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
