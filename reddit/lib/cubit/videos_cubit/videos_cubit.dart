import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/videos_cubit/videos_state.dart';

import '../../components/multi_manager/flick_multi_manager.dart';

class VideosCubit extends Cubit<VideosState> {
  VideosCubit() : super(VideosInitial());

  final FlickMultiManager flickMultiManager = FlickMultiManager();

  // getter for the flickMultiManager
  static VideosCubit get(context) => BlocProvider.of<VideosCubit>(context);
}
