import 'package:flutter/material.dart';
import '../../components/helpers/color_manager.dart';
import '../../data/home/drawer_communities_model.dart';
import '../../data/post_model/post_model.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../main_screen.dart';
import '../../widgets/posts/post_widget.dart';

class ShareToCommunityScreen extends StatelessWidget {
  const ShareToCommunityScreen(
      {super.key,
      this.community,
      required this.sharedPost,
      required this.isCommunity,
      this.username});
  final DrawerCommunitiesModel? community;
  final PostModel sharedPost;
  final bool isCommunity;
  final String? username;

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
                'inSubreddit': isCommunity ? true : false,
                'subreddit': isCommunity ? community!.title : ''
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                  color: ColorManager.grey,
                  shape: const StadiumBorder(),
                  onPressed: () => isCommunity ? Navigator.pop(context) : null,
                  child: Text(
                    isCommunity
                        ? 'r/${community!.title}'
                        : 'u/${username.toString()}',
                    style: const TextStyle(
                        fontSize: 16, color: ColorManager.eggshellWhite),
                  )),
              TextField(
                controller: textEditingController,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}
