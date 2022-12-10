///@author: Yasmine Ghanem
///@date: 10/12/2022
///moderation cubit that handles all moduration functions
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/data/moderation_models/ban_user_model.dart';
import 'package:reddit/data/moderation_models/community_settings_model.dart';
import 'package:reddit/data/moderation_models/description_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

part 'moderation_state.dart';

class ModerationCubit extends Cubit<ModerationState> {
  CommunitySettingsModel settings = CommunitySettingsModel();
  late TextEditingController controller;
  ModerationCubit() : super(ModerationInitial());
  static ModerationCubit get(context) => BlocProvider.of(context);

  ///@param[name] the name of the subreddit
  void getCommunitySettings(name, context) {
    String? token = CacheHelper.getData(key: 'token');
    DioHelper.getData(token: token, path: '/r/$name/about/edit').then((value) {
      if (value.statusCode == 200) {
        settings = CommunitySettingsModel.fromJson(value.data);
        emit(LoadSettings());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar('Failed to ban user\n${error.response}', true));
    });
    emit(LoadSettings());
  }

  ///@param[description] new description of the community
  void saveDescription(description) {
    DescriptionModel descriptionModel =
        DescriptionModel(description: description);
    String? token = CacheHelper.getData(key: 'token');
    DioHelper.postData(
            token: token,
            path: '/r/${settings.communityName}/add-description',
            data: descriptionModel.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        settings.communityDescription = description;
      }
    }).catchError((error) {
      error = error as DioError;
      responseSnackBar(
          'failed to update community description\n${error.response}', true);
    });
  }

  ///@param [name]
  ///@param [type]
  ///@param [nsfw]
  ///@param [category]
  void setCommunitySettings(name, type, nsfw, category) {
    settings = CommunitySettingsModel(
        communityName: name,
        type: type,
        nSFW: nsfw,
        communityDescription: '',
        communityTopics: [],
        region: '',
        language: '',
        welcomeMessage: '',
        sendWelcomeMessage: true,
        acceptingRequestsToJoin: true,
        acceptingRequestsToPost: true,
        approvedUsersHaveTheAbilityTo: 'Post & Comment');

    String? token = CacheHelper.getData(key: 'token');

    DioHelper.putData(
            token: token, path: '/r/$name/about/edit', data: settings.toJson())
        .then((value) {
      if (value.statusCode == 200) {}
    }).catchError((error) {
      error = error as DioError;
    });
  }

  bool isChanged = false;
  bool emptyDescription = true;

  ///@param [description] description currently being edited
  void onChanged(String description) {
    if (description != settings.communityDescription) {
      isChanged = true;
      emptyDescription = description.isEmpty;
    }
    emit(DescriptionChanged());
  }

  ///checkbox state bool
  bool permenant = true;

  ///toggles permenant checkbox
  ///indicates whether user is banned permenantly or for a certain time
  void togglePermenant() {
    permenant = !permenant;
    emit(TogglePermenant());
  }

  /// bool to check if days textfield is empty
  bool emptyDays = true;
  void checkDays(String days) {
    emptyDays = days.isEmpty;
    if (emptyDays) {
      permenant = true;
    } else {
      permenant = false;
    }
    emit(TogglePermenant());
  }

  ///bool to check if a reason has been chosen
  bool emptyReason = true;
  String banReason = 'Pick a reason';
  void setBanReason(reason) {
    banReason = reason;
    emptyReason = false;
    emit(BanReasonChosen());
  }

  /// bool to check if username textfield is empty
  bool emptyUsername = true;

  /// username to ban
  String? banUsername;

  ///@param [username] username of user to ban
  void buttonState(String username) {
    emptyUsername = username.isEmpty;
    banUsername = username;
    emit(EnableBanButton());
  }

  ///@param[context]
  ///@param [days]
  ///@param [modNote]
  ///@param [userNote]
  void banUser(context, String days, modNote, userNote) {
    BanUserModel banUser = BanUserModel(
        userId: 'user',
        subreddit: settings.communityName,
        banPeriod: (permenant) ? null : days as int,
        reasonForBan: banReason,
        modNote: modNote,
        noteInclude: userNote);

    String? token = CacheHelper.getData(key: 'token');

    DioHelper.postData(token: token, path: ban, data: banUser.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(responseSnackBar('User banned successfully', false));
        emit(BanUser());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar('Failed to ban user', true));
    });
  }
}
