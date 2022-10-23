import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  var maxLength = 10;
  var textLength = 0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        suffixText: '${textLength.toString()}/${maxLength.toString()}',
        counterText: "",
      ),
      cursorRadius: Radius.circular(10),
      keyboardType: TextInputType.text,
      autofocus: true,
      maxLength: maxLength,
      onChanged: (value) {
        setState(() {
          textLength = value.length;
        });
      },
    );
  }
}
