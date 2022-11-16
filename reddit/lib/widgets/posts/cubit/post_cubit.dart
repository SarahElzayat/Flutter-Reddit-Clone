/// this defines the Cubit that controls the state of each Post individually
/// date: 16/11/2022
/// @Author: Ahmed Atta

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/post_model/post_model.dart';
import 'post_cubit_state.dart';

class PostCubit extends Cubit<PostCubitState> {
  PostModel currentPost;
  PostCubit(this.currentPost) : super(PostCubitInitial());

  static PostCubit get(context) => BlocProvider.of(context);
}
