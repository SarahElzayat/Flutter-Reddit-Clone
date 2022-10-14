/// this is a utility widget which creates each new post.
/// @author Abdelaziz Salah
/// @date 14/10/2022

import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  /// this should be the path of the image or its URL but here
  /// for simplicity I won't use it and instead i will use one of the built in
  /// Icons instead
  final String imgPath;

  /// this should be the name of the user account
  final String userName;

  /// this is the content of each post
  final String thePostContent;
  const Post(
      {super.key,
      required this.imgPath,
      required this.userName,
      required this.thePostContent});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final themeData = Theme.of(context);
    return SizedBox(
      height: mediaQuery.size.height * 0.2,
      child: Card(
        elevation: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// the header of the post which contains the prof pic and the name
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.perm_device_information_outlined),
                  ),
                  const SizedBox(
                    width: 7.5,
                  ),
                  Text(
                    userName,
                    style: themeData.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),

            /// the content of the post
            Text(
              thePostContent,
              style: themeData.textTheme.bodyMedium,
            ),

            /// the three buttons
            /// each should be a row which contains the Icon and the title.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [Icon(Icons.thumb_up), Text('Like')],
                        )),
                  ),
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.comment),
                            Text('Comment'),
                          ],
                        )),
                  ),
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.ios_share),
                            Text('Share'),
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
