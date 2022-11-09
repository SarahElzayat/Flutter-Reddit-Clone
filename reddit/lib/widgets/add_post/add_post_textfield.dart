/// Text Field Widget
/// @author Haitham Mohamed
/// @date 4/11/2022

import '../../variable/global_varible.dart';
import 'package:flutter/material.dart';

/// Special Text Field that used in Add Post Screen
class AddPostTextField extends StatefulWidget {
  /// Boolen to check if it is title or not because if
  /// it's we will check is it empty or not
  /// Because it never allow To create post without title
  /// There are other validation that not implemented yet
  final bool isTitle;

  /// Make Text Field Multiply Lines or not
  final bool mltiline;

  /// Make Text Field Bold or normal
  final bool isBold;

  /// Text Font Size
  final int fontSize;

  /// Hint Text
  final String hintText;

  /// Text Field Controller
  final TextEditingController controller;
  const AddPostTextField({
    Key? key,
    required this.isTitle,
    required this.mltiline,
    required this.isBold,
    required this.fontSize,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  State<AddPostTextField> createState() => _AddPostTextFieldState();
}

class _AddPostTextFieldState extends State<AddPostTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: ((value) {
        setState(() {
          /// keep on checking the validation
          if (widget.isTitle) {
            GlobalVarible.isEmpty.value = widget.controller.text.isEmpty;
            GlobalVarible.isEmpty.notifyListeners();
          }
        });
      }),
      keyboardType:
          (widget.mltiline) ? TextInputType.multiline : TextInputType.text,
      maxLines: (widget.mltiline) ? null : 1,
      controller: widget.controller,
      cursorColor: Colors.blue,
      style: TextStyle(
          fontSize: MediaQuery.of(context).textScaleFactor * widget.fontSize),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontWeight: (widget.isBold) ? FontWeight.bold : FontWeight.normal,
              fontSize:
                  MediaQuery.of(context).textScaleFactor * widget.fontSize)),
    );
  }
}
