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
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: greyColor, width: 2.0),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: darkBlueColor, width: 2.0),
      ),
      labelText: labelText,
      suffixIcon: icon,
      suffixIconColor: greyColor,
      counterStyle: const TextStyle(color: greyColor),
    ),
    maxLength: maxLength,
  );
}

Widget squareTextField(
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
      hintText: labelText,
      filled: true,
      fillColor: darkGreyColor,
      suffixIcon: icon,
      suffixIconColor: greyColor,
      counterStyle: const TextStyle(color: greyColor),
      border: null,
      enabledBorder: null,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
      ),
    ),
    maxLength: maxLength,
  );
}
