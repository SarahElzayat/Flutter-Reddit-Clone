import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/helpers/color_manager.dart';
import '../../cubit/app_cubit/app_cubit.dart';
import 'share_to_community.dart';

import '../../data/post_model/post_model.dart';

class PickCommunityScreen extends StatefulWidget {
  const PickCommunityScreen({super.key, required this.sharedPost});

  final PostModel sharedPost;
  @override
  State<PickCommunityScreen> createState() => _PickCommunityScreenState();
}

class _PickCommunityScreenState extends State<PickCommunityScreen> {
  @override
  void initState() {
    AppCubit.get(context).getYourCommunities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Choose a community')),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'JOINED',
                style: TextStyle(
                  color: ColorManager.lightGrey,
                  fontSize: 14,
                ),
              ),
              // if (cubit.yourCommunitiesList.isNotEmpty)
              cubit.yourCommunitiesList.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: Center(
                        child: Text(
                          'Join a subreddit!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.yourCommunitiesList.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShareToCommunityScreen(
                                    isCommunity: true,
                                    community: cubit.yourCommunitiesList.values
                                        .elementAt(index),
                                    sharedPost: widget.sharedPost),
                              ));
                        },
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        './assets/images/uranus.png'),
                                    radius: 20,
                                  ),
                                ),
                                Text(
                                  'r/${cubit.yourCommunitiesList.values.elementAt(index).title!}',
                                  style: const TextStyle(
                                      color: ColorManager.eggshellWhite,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
