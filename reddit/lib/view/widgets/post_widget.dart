/// this widget build posts and show them
/// it use PostActionButtons and PostDescription widget
/// @author Haitham Mohamed
/// @date 14/10/2022

/// use the relative paths.

/// don't
// import 'package:assignment/view/widgets/post_action_buttons.dart';
// import 'package:assignment/data/model/post.dart';
// import 'package:assignment/view/screens/subreddit.dart';
// import 'package:assignment/view/widgets/post_description.dart';

/// do
import '../../view/widgets/post_action_buttons.dart';
import '../../view/screens/subreddit.dart';
import '../../view/widgets/post_description.dart';
import '../../data/model/post.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final List<Post> posts;
  const PostWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: ((context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              /// subreddit icon and title
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    iconSize: 35,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Image.asset(
                      posts[index].logo,
                      fit: BoxFit.fill,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const SubReddit())));
                    },
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(posts[index].title,
                          style: const TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis),
                    ),
                  )
                ],
              ),
              posts[index].description != ''
                  ? PostDescription(
                      charsLimits: 200,
                      fontSize: 20,
                      description: posts[index].description)
                  : const SizedBox(
                      height: 5,
                    ),
              posts[index].img != ''
                  ? Image(image: AssetImage(posts[index].img))
                  : const SizedBox(),
              const PostActionButtons(),
            ]),
          ),
        );
      }),
    );
  }
}
