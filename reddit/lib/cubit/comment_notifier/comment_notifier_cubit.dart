/// This is the Cubit for the notifier of Comments, resposible for rebuilding Comments when changed
/// date: 28/11/2022
/// @Author: Ahmed Atta
import 'package:flutter_bloc/flutter_bloc.dart';
import 'comment_notifier_state.dart';

class CommentNotifierCubit extends Cubit<CommentsNotifierState> {
  CommentNotifierCubit() : super(CommentsNotifierInitial());

  /// static getter of the cubit through inhereted widgets
  static CommentNotifierCubit get(context) => BlocProvider.of(context);

  /// updates the UI of the Commentss when changed
  void notifyComments() {
    emit(CommentsContentChanged());
  }
}
