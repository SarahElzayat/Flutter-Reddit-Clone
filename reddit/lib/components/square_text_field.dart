import 'package:flutter/material.dart';
import 'package:reddit/consts/colors.dart';

class SquareTextField extends StatefulWidget {
  final String labelText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType keyboardType;
  final TextEditingController? formController;
  final int maxLength;

  const SquareTextField({
    Key? key,
    required this.labelText,
    required this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.formController,
  }) : super(key: key);

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
      style: const TextStyle(color: lightGreyColor),
      decoration: InputDecoration(
        hintText: widget.labelText,
        filled: true,
        fillColor: darkGreyColor,
        suffixIconConstraints: const BoxConstraints(),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text('${widget.maxLength - textLength}',
              style: const TextStyle(color: greyColor)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
      ),
      maxLength: widget.maxLength,
    );
  }
}
