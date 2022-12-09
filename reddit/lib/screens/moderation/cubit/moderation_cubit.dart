import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'moderation_state.dart';

class ModerationCubit extends Cubit<ModerationState> {
  ModerationCubit() : super(ModerationInitial());
  static ModerationCubit get(context) => BlocProvider.of(context);
}
