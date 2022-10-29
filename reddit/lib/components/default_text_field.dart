/// A widget that displays a text field with a label.
/// date: 23/10/2022
/// @Author: Ahmed Atta

import 'package:flutter/material.dart';
import '../Components/color_manager.dart';

class DefaultTextField extends StatefulWidget {
  /// Creates an [DefaultTextField].
  /// it's used in many places in the app like in the change password screen
  /// the [labelText] is required.
  const DefaultTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.multiLine = false,
    this.icon,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.formController,
    this.maxLength,
    this.validator,
  }) : super(key: key);

  /// The text to display in the label.
  /// it's required.
  final String labelText;

  /// the icon to display in the text field.
  final IconButton? icon;

  /// indicates Whether the text being edited is obscured.
  /// Defaults to [false].
  final bool obscureText;

  /// Called when the text being edited changes.
  final void Function(String)? onChanged;

  /// Called when the text is submitted.
  final void Function(String)? onSubmitted;

  /// Called when [validate] is called.
  final String? Function(String?)? validator;

  /// The type of keyboard to use for editing the text.
  /// Defaults to [TextInputType.text].
  final TextInputType keyboardType;

  /// The controller for the text field.
  final TextEditingController? formController;

  /// The maximum number of characters to allow in the text field.
  final int? maxLength;

  /// indicates Whether the text field should be multiline.
  /// Defaults to [false].
  final bool multiLine;

  @override
  DefaultTextFieldState createState() => DefaultTextFieldState();
}

class DefaultTextFieldState extends State<DefaultTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.formController,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      keyboardType:
          widget.multiLine ? TextInputType.multiline : widget.keyboardType,
      onFieldSubmitted: widget.onSubmitted,
      style: const TextStyle(color: ColorManager.lightGrey),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.greyColor, width: 2.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.darkBlueColor, width: 2.0),
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
            color: _focusNode.hasFocus
                ? ColorManager.darkBlueColor
                : ColorManager.greyColor),
        suffixIcon: widget.icon,
        suffixIconColor: ColorManager.greyColor,
        counterStyle: const TextStyle(color: ColorManager.greyColor),
      ),
      maxLength: widget.maxLength,
      maxLines: widget.multiLine ? null : 1,
      validator: widget.validator,
    );
  }
}
