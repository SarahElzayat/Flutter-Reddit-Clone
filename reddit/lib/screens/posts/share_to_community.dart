import 'package:flutter/material.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/data/home/drawer_communities_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/main_screen.dart';
import 'package:reddit/widgets/posts/post_widget.dart';

class ShareToCommunityScreen extends StatelessWidget {
  const ShareToCommunityScreen(
      {super.key, required this.community, required this.sharedPost});
  final DrawerCommunitiesModel community;
  final PostModel sharedPost;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    textEditingController.text = sharedPost.title!;
    return Scaffold(
      appBar: AppBar(actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {
              DioHelper.postData(path: submitPost, data: {
                'title': textEditingController.text,
                'sharePostId': sharedPost.id,
                'kind': 'post',
                'inSubreddit': true,
                'subreddit': community.title
              }).then((value) {
                if (value.statusCode == 201) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreenForMobile(),
                      ));
                }
              });
            },
            color: ColorManager.blue,
            shape: const StadiumBorder(),
            child: const Text(
              'Post',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(
              color: ColorManager.grey,
              shape: const StadiumBorder(),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'r/${community.title} ',
                style:
                    const TextStyle(fontSize: 16, color: ColorManager.eggshellWhite),
              )),
          TextField(
            controller: textEditingController,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
          PostWidget(
            isNested: true,
            post: sharedPost,
            // insideProfiles: true,
            // postView: PostView.withCommentsInSearch,
          )
        ],
      ),
    );
  }
}
