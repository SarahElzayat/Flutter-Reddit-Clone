import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/subreddit/subreddit_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/moderation/user_management_screens/moderators.dart';
import '../../../screens/comments/add_comment_screen.dart';
import '../../../screens/subreddit/subreddit_screen.dart';
part 'subreddit_state.dart';

class SubredditCubit extends Cubit<SubredditState> {
  SubredditCubit() : super(SubredditInitial());

  static SubredditCubit get(context) => BlocProvider.of(context);

  SubredditModel? subreddit;
  Moderators? moderators;

  void setSubredditName(BuildContext context, String name) {
    Map<String, String> query = {'subreddit': name};
    DioHelper.getData(path: '$subredditInfo/$name', query: query).then((value) {
      if (value.statusCode == 200) {
        logger.wtf('Subreddit Info ====>');
        logger.wtf(value.data);
        subreddit = SubredditModel.fromJson(value.data);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Subreddit(),
          ),
        );
        // emit(subredditChange());
      }
    }).catchError((error) {
      logger.wtf('Error In Get Subreddit Info : $error');
    });
  }
}
