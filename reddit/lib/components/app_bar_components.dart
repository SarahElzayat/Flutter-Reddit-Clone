import 'package:flutter/material.dart';

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
