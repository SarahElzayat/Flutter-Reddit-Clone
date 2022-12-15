import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/helpers/enums.dart';
import '../../shared/local/shared_preferences.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../cubit/settings_cubit/settings_cubit_state.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(SettingsCubitInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  void changePassword() {
    /// TODO: all logic should be included here.
  }
  void changeEmail() {
    /// TODO: all logic should be included here.
  }

  /// this is a function responsible for applying the function of any
  /// dropDown box.
  /// @param [newValue] which is the newValue to be set.
  /// @param [type] which decide which function to be executed
  /// and which endpoint you want to communicate on.
  void changeDropValue(newValue, String type) {
    /// TODO - PUT THE LOGIC HERE FOR DROP BOXES.
    if (type == 'sortHome') {
      _sortHome(newValue);
    } else if (type == 'autoPlay') {
      _autoPlay(newValue);
    } else if (type == 'changeGender') {
      _changeGender(newValue);
    } else if (type == 'changeCountry') {
      _changeCountry(newValue);
    } else if (type == 'connectGoogle') {
    } else if (type == 'connectFaceBook') {}
  }

  void changeSwitch(bool newValue, String type) {
    if (type == 'allowPeopleToFollowYou') {
      _allowPeopleToFollowYou(newValue);
    } else if (type == 'showNSFW') {
      _showNFSW(newValue);
    }
  }

  /// this is a utility function used to allow the videos to be autoplayed.
  /// @param [newValue] which is a boolean true for allow
  /// false for disallow.
  void _autoPlay(newValue) {
    final request = {'autoplayMedia': newValue};
    DioHelper.patchData(path: accountSettings, data: request)
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200) {emit(ChangeSwitchState())}
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
    });
  }

  void _changeCountry(newCountry) {
    /// apply the logic of the backend here
    final request = {'country': newCountry};
    DioHelper.patchData(path: accountSettings, data: request)
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200) {emit(ChangeSwitchState())}
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
    });
  }

  void _changeGender(newGender) {
    /// apply the logic of the backend here
    final request = {'gender': newGender};
    DioHelper.patchData(path: accountSettings, data: request)
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200) {emit(ChangeSwitchState())}
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
    });
  }

  /// this is a utility function used to sort the home depending on the
  /// user choice by caching the result the he chose.
  /// @param [newValue] which is a string from the drop down menu which
  /// can take a value from 6 from the [HomeSort] enum which is defined in
  /// the helpers folder.
  /// these values are: [best, hot, new, top, raising, controversial].
  void _sortHome(newValue) {
    if (newValue == 'Best') {
      CacheHelper.putData(key: 'Sort', value: HomeSort.best);
    } else if (newValue == 'Hot') {
      CacheHelper.putData(key: 'Sort', value: HomeSort.hot);
    } else if (newValue == 'New') {
      CacheHelper.putData(key: 'Sort', value: HomeSort.newPosts);
    } else if (newValue == 'Top') {
      CacheHelper.putData(key: 'Sort', value: HomeSort.top);
    } else if (newValue == 'Raising') {
      CacheHelper.putData(key: 'Sort', value: HomeSort.raising);
    } else if (newValue == 'Controversial') {
      CacheHelper.putData(key: 'Sort', value: HomeSort.controversial);
    }
    emit(ChangeSwitchState());
  }

  /// this function is utility function which is responsible
  /// for making the user allow other users
  /// to follow him by toggling a switch
  /// @param [newValue] which is a boolean either true or false.
  void _allowPeopleToFollowYou(newValue) {
    /// apply the logic of the backend here
    final request = {'allowToFollowYou': newValue};
    DioHelper.patchData(path: accountSettings, data: request)
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200) {emit(ChangeSwitchState())}
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
    });
  }

  /// this is a utility function allowing the user to see NSFW content
  /// @param [newValue] which is a boolean either true for show
  /// or false to hide.
  void _showNFSW(newValue) {
    /// apply the logic of the backend here
    final request = {'nsfw': newValue};
    DioHelper.patchData(path: accountSettings, data: request)
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200) {emit(ChangeSwitchState())}
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
    });
  }
}
