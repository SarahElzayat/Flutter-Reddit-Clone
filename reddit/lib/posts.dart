// fen el comments wl @author wl date ya hanem ?

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool heartPressed = false;

  void _menuButton() {
    Fluttertoast.showToast(
        msg: "You clicked the menu button",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
        fontSize: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) =>
            CardInstance(_menuButton, context, heartPressed),
        itemCount: 6,
      ),
    );
  }
}

/// don't use this ignore tags matensobesh :D, eb2y 7ely el warning nfso
// ignore: non_constant_identifier_names => de laa sheleha

/// el moshkela hena enna katba esm el Widget UpperCamelCase
/// wehna metf2en fl styling en ehna nemshy camelCase bs
/// fa el 7l enk tkhleha badal CardInstance => cardInstance
/// (khaly 7rf el C small msh capital)
///
/// note kaman dayman law 3auza te3mly widget gdeda 7oteha fe file lw7dha
/// msh f nfs el file bta3 widget tanya da el good practice.
Widget CardInstance(menuButton, context, heartPressed) => Card(
      child: Column(children: [
        Row(children: [
          IconButton(icon: const Icon(Icons.menu), onPressed: menuButton),
          Text(
            'Post title',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ]),
        const Text('UserName\nPostText', textAlign: TextAlign.right),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
                color: heartPressed ? Colors.red : Colors.black),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share)),
          ],
        )
      ]),
    );
