/// this widget contains the description of the post
/// it's in separate widget because it StatefulWidget
/// it has read more and less buttons if text so long
/// @author Haitham Mohamed
/// @date 14/10/2022
import 'package:flutter/material.dart';

class PostDescription extends StatefulWidget {
  final String description;
  final double fontSize;
  final int charsLimits;
  const PostDescription({
    Key? key,
    required this.description,
    required this.fontSize,
    required this.charsLimits,
  }) : super(key: key);

  @override
  State<PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<PostDescription> {
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
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 10),
      child: moreText.isEmpty
          ? Text(lessText)
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  flag ? ('$lessText...') : (lessText + moreText),
                  style: TextStyle(fontSize: widget.fontSize),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? 'show more' : 'show less',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
