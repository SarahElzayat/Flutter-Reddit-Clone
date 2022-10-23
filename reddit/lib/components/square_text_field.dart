import 'package:flutter/material.dart';
import 'package:reddit/consts/colors.dart';

class SquareTextField extends StatefulWidget {
  final String labelText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType keyboardType;
  final TextEditingController? formController;
  final int? maxLength;
  final bool showSuffix;

  const SquareTextField({
    Key? key,
    this.showSuffix = true,
    this.keyboardType = TextInputType.text,
    required this.labelText,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
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
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        hintText: widget.labelText,
        filled: true,
        fillColor: darkGreyColor,
        suffixIconConstraints: const BoxConstraints(),
        suffixIcon: widget.showSuffix
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text('${widget.maxLength ?? 0 - textLength}',
                    style: const TextStyle(color: greyColor)),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      maxLength: widget.maxLength,
    );
  }
}
