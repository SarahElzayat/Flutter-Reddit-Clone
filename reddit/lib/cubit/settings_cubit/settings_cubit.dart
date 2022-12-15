import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/helpers/color_manager.dart';
import '../../data/settings_models/change_password_model.dart';
import '../../data/settings_models/update_email_model.dart';
import '../../components/helpers/enums.dart';
import '../../shared/local/shared_preferences.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../cubit/settings_cubit/settings_cubit_state.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(SettingsCubitInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  void changePasswordReq(currentPassText, confirmText, newPassText, context) {
    final changeRequest = ChangePasswordModel(
        confirmNewPassword: confirmText,
        currentPassword: currentPassText,
        newPassword: newPassText);

    DioHelper.putData(
            path: changePassword,
            data: changeRequest.toJson(),
            token: CacheHelper.getData(key: 'token'))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email has been sent!'),
            backgroundColor: ColorManager.green));
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password is not correct!'),
          backgroundColor: ColorManager.red));
    });
  }

  void changeEmailAddress(passText, mailText, context) {
    final update = UpdateEmail(
      currentPassword: passText,
      newEmail: mailText,
    );

    DioHelper.putData(
            path: changeEmail,
            data: update.toJson(),
            token: CacheHelper.getData(key: 'token'))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email has been sent!'),
            backgroundColor: ColorManager.green));
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('The inserted password is incorrect'),
        backgroundColor: ColorManager.red,
      ));
    });
  }

  /// this is a function responsible for applying the function of any
  /// dropDown box.
  /// @param [newValue] which is the newValue to be set.
  /// @param [type] which decide which function to be executed
  /// and which endpoint you want to communicate on.
  void changeDropValue(newValue, String type) {
    if (type == 'sortHome') {
      _sortHome(newValue);
    } else if (type == 'changeGender') {
      _changeGender(newValue);
    } else if (type == 'connectGoogle') {
    } else if (type == 'connectFaceBook') {}
  }

  void changeSwitch(bool newValue, String type) {
    print(type);
    if (type == 'allowPeopleToFollowYou') {
      _allowPeopleToFollowYou(newValue);
    } else if (type == 'showNSFW') {
      _showNFSW(newValue);
    } else if (type == 'autoPlay') {
      _autoPlay(newValue);
    }
  }

  /// this is a utility function used to allow the videos to be autoplayed.
  /// @param [newValue] which is a boolean true for allow
  /// false for disallow.
  void _autoPlay(newValue) {
    final request = {'autoplayMedia': newValue};
    print(request);
    DioHelper.patchData(
      token: CacheHelper.getData(key: 'token'),
      path: accountSettings,
      data: request,
    )
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

  void changeCountry(newCountry) {
    final request = {'country': newCountry};
    DioHelper.patchData(
            token: CacheHelper.getData(key: 'token'),
            path: accountSettings,
            data: request)
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
    final request = {'gender': newGender};
    DioHelper.patchData(
            token: CacheHelper.getData(key: 'token'),
            path: accountSettings,
            data: request)
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
    final request = {'allowToFollowYou': newValue};
    DioHelper.patchData(
            token: CacheHelper.getData(key: 'token'),
            path: accountSettings,
            data: request)
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
    final request = {'nsfw': newValue};
    DioHelper.patchData(
            token: CacheHelper.getData(key: 'token'),
            path: accountSettings,
            data: request)
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
