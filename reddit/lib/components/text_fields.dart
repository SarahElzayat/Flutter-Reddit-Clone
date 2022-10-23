import 'package:flutter/material.dart';

Widget defaultTextField(
  String labelText, {
  Icon? icon,
  bool obscureText = false,
  onChanged,
  onSubmitted,
  keyboardType = TextInputType.text,
}) {
  return TextField(
    obscureText: obscureText,
    onChanged: onChanged,
    keyboardType: keyboardType,
    onSubmitted: onSubmitted,
    decoration: InputDecoration(
      // border: OutlineInputBorder(),
      labelText: labelText,
      suffixIcon: icon,
    ),
  );
}
