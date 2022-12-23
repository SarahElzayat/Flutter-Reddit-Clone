/// this file is used to define Cubit used to manage the videos in the app.
/// date: 20/12/2022
/// @Author: Ahmed Atta

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/videos_cubit/videos_state.dart';

import '../../components/multi_manager/flick_multi_manager.dart';

/// Cubit used to manage the videos in the app.
class VideosCubit extends Cubit<VideosState> {
  VideosCubit() : super(VideosInitial());

  /// the [FlickMultiManager] that is used to manage multiple videos.
  final FlickMultiManager flickMultiManager = FlickMultiManager();

  /// static getter of the cubit through inhereted widgets
  static VideosCubit get(context) => BlocProvider.of<VideosCubit>(context);
}
