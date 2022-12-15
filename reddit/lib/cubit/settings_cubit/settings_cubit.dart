import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/settings_cubit/settings_cubit_state.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(SettingsCubitInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  void changeDropValue(newValue, String type) {
    /// TODO - PUT THE LOGIC HERE FOR DROP BOXES.
    if (type == 'SortHome') {
    } else if (type == 'autoPlay') {
    } else if (type == 'changeGender') {
    } else if (type == 'ConnectGoogle') {
    } else if (type == 'ConnectFaceBook') {}
  }

  void changeSwitch(bool newValue, String type) {
    if (type == 'allowPeopleToFollowYou') {
      allowPeopleToFollowYou(newValue);
    } else if (type == 'showNSFW') {
      showNFSW(newValue);
    }
  }

  void autoPlay(newValue) {
    if (newValue == 'Always') {
    } else if (newValue == 'When on Wi-Fi') {
    } else if (newValue == 'Never') {}
    emit(ChangeSwitchState());
  }

  void sortHome(newValue) {
    if (newValue == 'Best') {
    } else if (newValue == 'Hot') {
    } else if (newValue == 'New') {
    } else if (newValue == 'Top') {
    } else if (newValue == 'Raising') {
    } else if (newValue == 'Controversial') {}
    emit(ChangeSwitchState());
  }

  void allowPeopleToFollowYou(newValue) {
    /// apply the logic of the backend here
    if (newValue) {
      /// allow
    } else {
      /// disallow
    }

    emit(ChangeSwitchState());
  }

  void showNFSW(newValue) {
    /// apply the logic of the backend here
    if (newValue) {
      /// show
    } else {
      /// hide
    }

    emit(ChangeSwitchState());
  }
}
