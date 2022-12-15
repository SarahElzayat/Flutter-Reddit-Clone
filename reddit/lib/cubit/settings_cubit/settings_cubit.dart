import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/settings_models/block_user_model.dart';
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

  void unBlock(userName, context) {
    final blockUser = BlockModel(block: false, username: userName);

    DioHelper.postData(
            path: block,
            data: blockUser.toJson(),
            token: CacheHelper.getData(key: 'token'))
        .then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You have unblocked $userName')));
      }
    }).catchError((err) {
      err = err as DioError;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.response!.data)));
    });
  }

  /// This function is responsible for sending the request for the backend to
  /// change the password of the user.
  /// @param [currentPassText] is the user current password
  /// @param [newPassText] is the new password
  /// @param [confirmText] is the confirmation of the same new password
  /// @param [context] the context of the screen to show
  /// the message on success or fail
  void changePasswordReq(currentPassText, confirmText, newPassText, context) {
    final changeRequest = ChangePasswordModel(
        confirmNewPassword: confirmText,
        currentPassword: currentPassText,
        newPassword: newPassText);

    DioHelper.putData(
      path: changePassword,
      data: changeRequest.toJson(),
    ).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Password has been changed!'),
            backgroundColor: ColorManager.green));
        Navigator.of(context).pop();
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password is not correct!'),
          backgroundColor: ColorManager.red));
    });
  }

  /// This function is responsible for sending the request for the backend to
  /// change the email of the user.
  /// @param [passText] is the user current password
  /// @param [mailText] is the new email
  /// @param [context] the context of the screen to show
  /// the message on success or fail
  void changeEmailAddress(passText, mailText, context) {
    final update = UpdateEmail(
      currentPassword: passText,
      newEmail: mailText,
    );

    DioHelper.putData(
      path: changeEmail,
      data: update.toJson(),
    ).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email has been changed!'),
            backgroundColor: ColorManager.green));
      }
    }).catchError((error) {
      error = error as DioError;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '${error.response?.data} :(',
          style: const TextStyle(
              color: ColorManager.eggshellWhite,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
        backgroundColor: ColorManager.red,
      ));
    });
  }

  /// this is a function responsible for applying the function of any
  /// dropDown box.
  /// @param [newValue] which is the newValue to be set.
  /// @param [type] which decide which function to be executed
  /// and which endpoint you want to communicate on.
  void changeDropValue(newValue, String type, context) {
    if (type == 'sortHome') {
      _sortHome(newValue);
    } else if (type == 'changeGender') {
      _changeGender(newValue, context);
    } else if (type == 'connectGoogle') {
    } else if (type == 'connectFaceBook') {}
  }

  void changeSwitch(bool newValue, String type) {
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

  void changeCountry(newCountry, ctx) {
    final request = {'country': newCountry};
    DioHelper.patchData(
            token: CacheHelper.getData(key: 'token'),
            path: accountSettings,
            data: request)
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200)
                {
                  emit(ChangeSwitchState()),
                  // ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                  //     content: Center(
                  //   child: Text('Hello'),
                  // ))),
                  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                      content: Text(
                        'now you come from $newCountry',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.black),
                      ),
                      backgroundColor: ColorManager.green)),
                }
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          // content: Text('${error.response?.data}'),
          content: Text('${error.response!.data}'),
          backgroundColor: ColorManager.red));
    });
  }

  void _changeGender(newGender, context) {
    final request = {'gender': newGender};
    DioHelper.patchData(
            token: CacheHelper.getData(key: 'token'),
            path: accountSettings,
            data: request)
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200)
                {
                  emit(ChangeSwitchState()),
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Your Gender is now $newGender',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.black),
                      ),
                      backgroundColor: ColorManager.green))
                }
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${error.response?.data}'),
          backgroundColor: ColorManager.red));
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
      CacheHelper.putData(key: 'SortHome', value: HomeSort.best.index);
    } else if (newValue == 'Hot') {
      CacheHelper.putData(key: 'SortHome', value: HomeSort.hot.index);
    } else if (newValue == 'New') {
      CacheHelper.putData(key: 'SortHome', value: HomeSort.newPosts.index);
    } else if (newValue == 'Top') {
      CacheHelper.putData(key: 'SortHome', value: HomeSort.top.index);
    } else if (newValue == 'Raising') {
      CacheHelper.putData(key: 'SortHome', value: HomeSort.raising.index);
    } else if (newValue == 'Controversial') {
      CacheHelper.putData(key: 'SortHome', value: HomeSort.controversial.index);
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
