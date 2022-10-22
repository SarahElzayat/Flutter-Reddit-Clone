/// where are the author and date and description comments ya hanem ??

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostBuilder extends StatefulWidget {
  /// you should make the constructor const to make the class immutable
  /** const */ PostBuilder(
      {super.key, required this.post, required this.name, required this.title});

  /// it is better to make these vars final
  /** final */ String post, name, title;

  @override
  State<PostBuilder> createState() => _PostBuilderState();
}

class _PostBuilderState extends State<PostBuilder> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => showToast('This is a menu button'),
                icon: const Icon(Icons.menu),
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => showToast('This is an arrow button'),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.kym-cdn.com/photos/images/facebook/001/510/490/e7f.jpg'),
                ),
              ),
              Text(
                widget.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.post,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isPressed = !_isPressed;
                  });
                },
                icon: const Icon(Icons.thumb_up),
                color: _isPressed ? Colors.red : Colors.grey,
              ),
              IconButton(
                onPressed: () => showToast('You\'ll comment here'),
                icon: const Icon(Icons.comment),
                color: Colors.grey,
              ),
              IconButton(
                onPressed: () => showToast('You shall share it from here'),
                icon: const Icon(Icons.share),
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}

void showToast(text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.deepPurple,
      textColor: Colors.white,
      fontSize: 16.0);
}
