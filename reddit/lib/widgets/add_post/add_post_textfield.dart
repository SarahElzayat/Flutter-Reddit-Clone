/// Text Field Widget
/// @author Haitham Mohamed
/// @date 4/11/2022

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/add_post.dart/cubit/add_post_cubit.dart';
import 'package:flutter/material.dart';

/// Special Text Field that used in Add Post Screen
class AddPostTextField extends StatefulWidget {
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

  int? index;
  AddPostTextField({
    Key? key,
    // required this.textfieldType,
    required this.mltiline,
    required this.isBold,
    required this.fontSize,
    required this.hintText,
    this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<AddPostTextField> createState() => _AddPostTextFieldState();
}

class _AddPostTextFieldState extends State<AddPostTextField> {
  @override
  Widget build(BuildContext context) {
    final addPostCubit = BlocProvider.of<AddPostCubit>(context);
    return TextFormField(
      onChanged: ((value) {
        addPostCubit.checkPostValidation();
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
