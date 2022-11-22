import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_notifier_state.dart';

class PostNotifierCubit extends Cubit<PostNotifierState> {
  PostNotifierCubit() : super(PostNotifierInitial());

  static PostNotifierCubit get(context) => BlocProvider.of(context);

  void changedPost() {
    emit(PostChanged());
  }
}
