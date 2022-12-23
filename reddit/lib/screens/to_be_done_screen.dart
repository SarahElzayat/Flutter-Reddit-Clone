/// @author Sarah El-Zayat
/// @date 9/11/2022
/// this is a dummy route to screen that might be dont for future extension
import 'package:flutter/material.dart';

class ToBeDoneScreen extends StatefulWidget {
  const ToBeDoneScreen({super.key, required this.text});
  final String text;

  @override
  State<ToBeDoneScreen> createState() => _ToBeDoneScreenState();
}

class _ToBeDoneScreenState extends State<ToBeDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            widget.text,
            style: const TextStyle(color: Colors.white, fontSize: 50),
          ),
        ));
  }
}
