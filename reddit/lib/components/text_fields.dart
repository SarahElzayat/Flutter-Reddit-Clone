import 'package:flutter/material.dart';
import 'package:reddit/consts/colors.dart';

Widget defaultTextField(
  String labelText, {
  IconButton? icon,
  bool obscureText = false,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
  keyboardType = TextInputType.text,
  TextEditingController? formController,
  int? maxLength,
}) {
  return TextFormField(
    controller: formController,
    obscureText: obscureText,
    onChanged: onChanged,
    keyboardType: keyboardType,
    onFieldSubmitted: onSubmitted,
    style: const TextStyle(color: lightGreyColor),
    decoration: InputDecoration(
      labelText: labelText,
      suffixIcon: icon,
      suffixIconColor: greyColor,
      counterStyle: const TextStyle(color: greyColor),
    ),
    maxLength: maxLength,
  );
}
