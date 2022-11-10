/// A widget that displays a square text field with a label.
/// date: 23/10/2022
/// @author: Ahmed Atta

import 'package:flutter/material.dart';
import '../components/helpers/color_manager.dart';

class SquareTextField extends StatefulWidget {
  /// Creates an [SquareTextField].
  /// it's used in many places in the app like in Add Comment and Add Community screens
  /// the [labelText] is required.
  const SquareTextField({
    Key? key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.formController,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.showSuffix = true,
  }) : super(key: key);

  /// The text to display in the label.
  final String labelText;

  /// The type of keyboard to use for editing the text.
  /// Defaults to [TextInputType.text].
  final TextInputType keyboardType;

  /// The maximum number of characters to allow in the text field.
  final int? maxLength;

  /// The controller for the text field.
  final TextEditingController? formController;

  /// its used to show or hide the suffix whitch contains the number of line left.
  /// Default to [true].
  final bool showSuffix;

  /// Called when the text being edited changes.
  final void Function(String)? onChanged;

  /// Called when the text is submitted.
  final void Function(String)? onSubmitted;

  /// Called when [validate] is called.
  final String? Function(String?)? validator;

  @override
  SquareTextFieldState createState() => SquareTextFieldState();
}

class SquareTextFieldState extends State<SquareTextField> {
  late FocusNode _focusNode;
  var textLength = 0;

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
      onChanged: (value) {
        setState(() {
          textLength = value.length;
        });
      },
      keyboardType: widget.keyboardType,
      onFieldSubmitted: widget.onSubmitted,
      style: const TextStyle(color: ColorManager.lightGrey),
      decoration: InputDecoration(
        hintText: widget.labelText,
        filled: true,
        fillColor: ColorManager.darkGrey,
        suffixIconConstraints: const BoxConstraints(),
        suffixIcon: widget.showSuffix
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('${widget.maxLength ?? 0 - textLength}',
                    style: const TextStyle(color: ColorManager.greyColor)),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLength: widget.maxLength,
      validator: widget.validator,
    );
  }
}