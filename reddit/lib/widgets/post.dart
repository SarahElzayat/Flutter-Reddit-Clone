/// The widget of each post individually
/// @auther Ahmed Atta
/// @created at 2022 14/10
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class Post extends StatefulWidget {
  /// this a stateful widget that will be used to display each post
  final String photo;
  final String name;
  final String message;
  const Post({
    Key? key,
    required this.photo,
    required this.name,
    required this.message,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class _PostState extends State<Post> {
  var isPressed = false;
  String _selectedMenu = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.photo),
                ),
              ),
              Text(
                widget.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              PopupMenuButton<Menu>(
                  // Callback that sets the selected popup menu item.
                  onSelected: (Menu item) {
                    setState(() {
                      _selectedMenu = item.name;
                      debugPrint('Selected menu item: ${item.name}');
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                        const PopupMenuItem<Menu>(
                          value: Menu.itemOne,
                          child: Text('Item One'),
                        ),
                        const PopupMenuItem<Menu>(
                          value: Menu.itemTwo,
                          child: Text('Item Two'),
                        ),
                        const PopupMenuItem<Menu>(
                          value: Menu.itemThree,
                          child: Text('Item Three'),
                        ),
                        const PopupMenuItem<Menu>(
                          value: Menu.itemFour,
                          child: Text('Item Four'),
                        ),
                      ]),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: Text(
              widget.message,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          //row of buttons like and comment and share
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    flex: 7,
                    child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                        child: Icon(Icons.thumb_up_alt,
                            color:
                                isPressed ? Colors.blue : Colors.grey[700]))),
                Expanded(
                    flex: 7,
                    child: MaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.comment,
                          color: Colors.grey[700],
                        ))),
                Expanded(
                    flex: 7,
                    child: MaterialButton(
                        onPressed: () {
                          Share.share(widget.message,
                              subject: 'Look what I made!');
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.grey[700],
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
