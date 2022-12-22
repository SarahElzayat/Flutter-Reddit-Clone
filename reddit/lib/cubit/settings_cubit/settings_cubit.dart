import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/data/google_api/google_sign_in_api.dart';
import 'package:reddit/data/settings/settings_models/block_user_model.dart';
import 'package:reddit/data/settings/settings_models/blocked_accounts_getter_model.dart';
import '../../data/settings/settings_models/change_password_model.dart';
import '../../data/settings/settings_models/update_email_model.dart';
import '../../components/helpers/enums.dart';
import '../../shared/local/shared_preferences.dart';
import '../../networks/constant_end_points.dart';
import '../../networks/dio_helper.dart';
import '../../cubit/settings_cubit/settings_cubit_state.dart';

class SettingsCubit extends Cubit<SettingsCubitState> {
  SettingsCubit() : super(SettingsCubitInitial());
  List<BlockedAccountsGetterModel> blockedUsers = [];

  static SettingsCubit get(context) => BlocProvider.of(context);

  void connectToFacebook(ctx) {}

  void connectToGoogle(ctx) {}

  Future<void> blockUser(context, PagingController pagingController) async {
    final userToBeBlocked = BlockModel(username: 'saraah', block: true);
    await DioHelper.postData(
      path: block,
      data: userToBeBlocked.toJson(),
    ).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('abdelazizHasBeenBlocked')));
      }
    }).catchError((err) {
      err = err as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.response?.data)));
    });

    pagingController.refresh();
  }

  /// the blocked accounts from the user.
  void getBlockedUsers(
      context, String? after, PagingController pagingController) async {
    emit(UnBlockState(false));
    print('Token is');
    print(CacheHelper.getData(key: 'token'));
    if (after == null) {
      await DioHelper.getData(path: blockedAccounts).then((response) {
        if (response.statusCode == 200) {
          blockedUsers.clear();
          for (var elem in response.data['children']) {
            blockedUsers.add(BlockedAccountsGetterModel.fromJson(elem));
          }
          pagingController.appendLastPage(blockedUsers);

          // if (response.data['after'] as String == '') {
          //   pagingController.appendLastPage(blockedUsers);
          // } else {
          //   pagingController.appendPage(
          //       blockedUsers, response.data['after'] as String);
          // }
        }
      }).catchError((error) {
        error = error as DioError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message.toString())));
      });
    } else {
      await DioHelper.getData(
          path: blockedAccounts,
          query: {'after': 'after', 'limit': '5'}).then((response) {
        if (response.statusCode == 200) {
          blockedUsers.clear();
          for (var elem in response.data['children']) {
            blockedUsers.add(BlockedAccountsGetterModel.fromJson(elem));
          }
          if (response.data['after'] as String == '') {
            pagingController.appendLastPage(blockedUsers);
          } else {
            pagingController.appendPage(
                blockedUsers, response.data['after'] as String);
          }
        }
        pagingController.appendLastPage(blockedUsers);

        // if (response.data['after'] as String == '') {
        //   pagingController.appendLastPage(blockedUsers);
        // } else {
        //   pagingController.appendPage(
        //       blockedUsers, response.data['after'] as String);
        // }
      }).catchError((error) {
        error = error as DioError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message.toString())));
      });

      emit(UnBlockState(true));
    }
  }

  void removeItem(item) {
    blockedUsers.remove(item);
    emit(UnBlockState(true));
  }

  Future<void> unBlock(userName, context, PagingController screenContr) async {
    final blockUser = BlockModel(block: false, username: userName);

    await DioHelper.postData(
      path: block,
      data: blockUser.toJson(),
    ).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'You have unblocked $userName  🤍🏳️', error: false));
      }
    }).catchError((err) {
      err = err as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: '${err.response?.data}'));
    });

    screenContr.refresh();
    emit(UnBlockState(true));
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
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Password has been changed! 🔑🔑', error: false));
        Navigator.of(context).pop();
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'The password is incorrect ! 😔'));
    });

    emit(ChangePassword());
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
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Email has been changed! 😊', error: false));
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: '${error.response?.data}  😔'));
    });

    emit(ChangeEmail());
  }

  void _connectGoogle(newValue) async {
    await GoogleSignInApi.logOut().then((response) {
      print(response);
    }).catchError((err) {
      print(err);
    });

    if (newValue == 'Connected') {
      final user = await GoogleSignInApi.login();

      GoogleSignInAuthentication googleToken = await user!.authentication;

      // final user = await GoogleSignInApi.login().then((response) {
      //   print(response!.displayName);
      // }).catchError((err) {
      //   print(err);
      // });

      await DioHelper.postData(
          path: signInGoogle,
          data: {'accessToken': googleToken.idToken}).then((response) async {
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Now You are connected with Google');
          await DioHelper.getData(path: accountSettings).then((response) {
            if (response.statusCode == 200) {
              CacheHelper.putData(
                  key: 'googleEmail', value: response.data['googeEmail']);
              print('Logged in with google successfully');
            }
          });
        }
      }).catchError((error) {
        error = error as DioError;
        print(error.response!.data);
      });
      // emit(ConnectGoogle());
    } else {
      GoogleSignInApi.logOut();
      // emit(DisconnectGoogle());
    }
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
      _connectGoogle(newValue);
    } else if (type == 'connectFaceBook') {
      // _connectFaceBook(newValue);
    }
  }

  void changeSwitch(bool newValue, String type) {
    if (type == 'allowPeopleToFollowYou') {
      _allowPeopleToFollowYou(newValue);
    } else if (type == 'show NSFW') {
      _showNFSW(newValue);
    } else if (type == 'autoPlay') {
      _autoPlay(newValue);
    }
  }

  /// this is a utility function used to allow the videos to be autoplayed.
  /// @param [newValue] which is a boolean true for allow
  /// false for disallow.
  void _autoPlay(newValue) async {
    final request = {'autoplayMedia': newValue};
    await DioHelper.patchData(
      token: CacheHelper.getData(key: 'token'),
      path: accountSettings,
      data: request,
    )
        .then((response) => {
              // if changed correctly then emit to all listeners that the
              // settings has been changed, else leave every thing as is.
              if (response.statusCode == 200)
                {
                  CacheHelper.putData(key: 'autoplayMedia', value: newValue),
                  emit(ChangeSwitchState())
                }
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
                  CacheHelper.putData(key: 'country', value: newCountry),
                  emit(ChangeSwitchState()),
                  ScaffoldMessenger.of(ctx).showSnackBar(responseSnackBar(
                      message: 'now you come from $newCountry  🗺️',
                      error: false))
                }
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);

      ScaffoldMessenger.of(ctx)
          .showSnackBar(responseSnackBar(message: '${error.response!.data}'));
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
                  CacheHelper.putData(key: 'gender', value: newGender),
                  emit(ChangeSwitchState()),
                  ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
                      message: 'Your Gender is now $newGender  🧑🧒',
                      error: false))
                }
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: '${error.response?.data}'));
    });
  }

  /// this is a utility function used to sort the home depending on the
  /// user choice by caching the result the he chose.
  /// @param [newValue] which is a string from the drop down menu which
  /// can take a value from 6 from the [HomeSort] enum which is defined in
  /// the helpers folder.
  /// these values are: [best, hot, new, top, raising, controversial].

// { hot, best, top, trending, newPosts, raising, controversial }
  void _sortHome(newValue) {
    if (newValue == 'Best') {
      CacheHelper.putData(key: 'SortHome', value: 1);
    } else if (newValue == 'Hot') {
      CacheHelper.putData(key: 'SortHome', value: 0);
    } else if (newValue == 'New') {
      CacheHelper.putData(key: 'SortHome', value: 4);
    } else if (newValue == 'Top') {
      CacheHelper.putData(key: 'SortHome', value: 2);
    } else if (newValue == 'Raising') {
      CacheHelper.putData(key: 'SortHome', value: 5);
    } else if (newValue == 'Controversial') {
      CacheHelper.putData(key: 'SortHome', value: 6);
    } else {
      /// trending
      CacheHelper.putData(key: 'SortHome', value: 3);
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
              if (response.statusCode == 200)
                {
                  CacheHelper.putData(key: 'allowToFollowYou', value: newValue),
                  emit(ChangeSwitchState())
                }
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
              if (response.statusCode == 200)
                {
                  CacheHelper.putData(key: 'nsfw', value: newValue),
                  emit(ChangeSwitchState())
                }
            })
        .catchError((error) {
      error = error as DioError;
      debugPrint(error.message);
    });
  }
}
