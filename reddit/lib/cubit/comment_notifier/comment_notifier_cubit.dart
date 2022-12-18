/// This is the Cubit for the notifier of Commentss, resposible for rebuilding Commentss when changed
/// date: 28/11/2022
/// @Author: Ahmed Atta
import 'package:flutter_bloc/flutter_bloc.dart';

import 'comment_notifier_state.dart';

class CommentNotifierCubit extends Cubit<CommentsNotifierState> {
  CommentNotifierCubit() : super(CommentsNotifierInitial());

  /// static getter of the cubit through inhereted widgets
  static CommentNotifierCubit get(context) => BlocProvider.of(context);

  /// updates the UI of the Posts
  void notifyComments() {
    emit(CommentsContentChanged());
  }
}
