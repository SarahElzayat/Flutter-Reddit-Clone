import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/cubit/settings_cubit/settings_cubit_state.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(SettingsCubitInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  void changeSwitch(bool newValue) {
    //TODO - PUT the logic here

    emit(ChangeSwitchState());
  }
}
