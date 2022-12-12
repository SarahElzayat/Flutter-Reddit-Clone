// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  final String description;
  final double fontSize;
  final int charsLimits;
  final Key widgetKey;
  final void Function() callback;
  const ExpandedText({
    Key? key,
    required this.description,
    required this.fontSize,
    required this.charsLimits,
    required this.widgetKey,
    required this.callback,
  }) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  String lessText = '';
  String moreText = '';

  /// flag used to know the test is shrinked or not
  bool flag = true;
  @override
  void initState() {
    super.initState();

    /// if post description more than limit crop it to two substrings
    if (widget.description.length > widget.charsLimits) {
      lessText = widget.description.substring(0, widget.charsLimits);
      moreText = widget.description
          .substring(widget.charsLimits, widget.description.length);
    } else {
      lessText = widget.description;
      moreText = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          flag = !flag;
          widget.callback();
        });
      },
      child: Container(
        key: widget.widgetKey,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(bottom: 10),
        child: moreText.isEmpty
            ? Text(lessText)
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    flag ? ('$lessText...') : (lessText + moreText),
                    style: TextStyle(
                        fontSize: widget.fontSize * mediaQuery.textScaleFactor),
                  ),
                ],
              ),
      ),
    );
  }
}
