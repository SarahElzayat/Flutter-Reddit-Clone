import 'package:flutter/material.dart';
import 'package:reddit/consts/colors.dart';

class DefaultTextField extends StatefulWidget {
  final String labelText;
  final IconButton? icon;
  final bool obscureText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType keyboardType;
  final TextEditingController? formController;
  final int? maxLength;
  final bool multiLine;
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
  }) : super(key: key);

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
      style: const TextStyle(color: lightGreyColor),
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: greyColor, width: 2.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: darkBlueColor, width: 2.0),
        ),
        labelText: widget.labelText,
        labelStyle:
            TextStyle(color: _focusNode.hasFocus ? darkBlueColor : greyColor),
        suffixIcon: widget.icon,
        suffixIconColor: greyColor,
        counterStyle: const TextStyle(color: greyColor),
      ),
      maxLength: widget.maxLength,
      maxLines: widget.multiLine ? null : 1,
    );
  }
}
