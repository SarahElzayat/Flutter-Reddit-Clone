import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/subreddit/cubit/subreddit_cubit.dart';

/// Widget That Contain The Moderators Of subreddit
class SubredditAboutWidget extends StatelessWidget {
  const SubredditAboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subredditCubit = BlocProvider.of<SubredditCubit>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text('Moderators'), Icon(Icons.mail_outline)],
          ),
          const Divider(),
          for (int index = 0;
              index < subredditCubit.moderators.children!.length;
              index++)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                  subredditCubit.moderators.children![index].username ?? ''),
            )
        ],
      ),
    );
  }
}
