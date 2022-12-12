///@author: Yasmine Ghanem
///@date: 10/12/2022
///moderation cubit that handles all moduration functions
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/data/moderation_models/ban_user_model.dart';
import 'package:reddit/data/moderation_models/banned_users_model.dart';
import 'package:reddit/data/moderation_models/community_settings_model.dart';
import 'package:reddit/data/moderation_models/description_model.dart';
import 'package:reddit/data/moderation_models/moderators_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/router.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

part 'moderation_state.dart';

class ModerationCubit extends Cubit<ModerationState> {
  ///settings of the community
  CommunitySettingsModel settings = CommunitySettingsModel();

  ///suggested topics for a subreddit list
  List<dynamic> topics = [];

  ///text editing controller for [something] textfield
  late TextEditingController controller;
  ModerationCubit() : super(ModerationInitial());
  static ModerationCubit get(context) => BlocProvider.of(context);

  ///@param [name] the name of the subreddit
  ///returns the current community settings
  void getCommunitySettings(name, context) {
    String? token = CacheHelper.getData(key: 'token');
    DioHelper.getData(path: '/r/$name/about/edit').then((value) {
      if (value.statusCode == 200) {
        settings = CommunitySettingsModel.fromJson(value.data);
        emit(LoadSettings());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Failed to ban user\n${error.response}', error: true));
    });
    emit(LoadSettings());
  }

  List<dynamic> getSuggestedTopics(context) {
    String? token = CacheHelper.getData(key: 'token');
    DioHelper.getData(path: '/r/com1/suggested-topics').then((value) {
      if (value.statusCode == 200) {
        topics =
            value.data.map((topic) => CommunityTopics.fromJson(topic)).toList();
        print(topics);
        emit(TopicsLoaded(topics));
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Failed to load topics\n${error.response}', error: true));
    });
    return topics;
  }

  ///@param[description] new description of the community
  ///saves a new description to the community
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
          message: 'failed to update community description\n${error.response}',
          error: true);
    });
  }

  ///@param [name] subreddit name
  ///@param [type] subreddit type
  ///@param [nsfw] whether subreddit is not safe for work
  ///@param [category] subreddit category
  ///sets the settings of a community
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

    DioHelper.putData(path: '/r/$name/about/edit', data: settings.toJson())
        .then((value) {
      if (value.statusCode == 200) {}
    }).catchError((error) {
      error = error as DioError;
    });
  }

  bool isChanged = false;
  bool emptyDescription = true;

  ///@param [description] description currently being edited
  ///checks if the description being edited is changed to enable save button
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
    emit(Toggle());
  }

  /// bool to check if days textfield is empty
  bool emptyDays = true;

  ///@param [days] number of days a user is banned from a subreddit
  ///checks whether a number of days was specified to set permenant check box state
  void checkDays(String days) {
    emptyDays = days.isEmpty;
    if (emptyDays) {
      permenant = true;
    } else {
      permenant = false;
    }
    emit(Toggle());
  }

  ///bool to check if a reason has been chosen
  bool emptyReason = true;

  ///reason for banning a user
  String banReason = 'Pick a reason';

  ///@param [reason] reason for banning a user
  ///sets reason chosen from modal bottom sheet
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
  ///updates button state whether enabled or not
  void buttonState(String username) {
    emptyUsername = username.isEmpty;
    banUsername = username;
    emit(EnableButton());
  }

  ///@param[context] context of banned users screen
  ///@param [days] number of days a user is banned
  ///@param [modNote] moderator note, only seen by moderators
  ///@param [userNote] note to send to the banned user
  /// this functions bans a user from a subreddit
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
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'User banned successfully', error: false));
        emit(BanUser());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Failed to ban user', error: true));
    });
  }

  ///@param [context] user management screen context
  ///@param [type]
  ///gets a list of users based on the user management type [banned, muted, moderator, approved]
  List<dynamic> getUsers(context, UserManagement type) {
    List<dynamic> users = [];
    String? token = CacheHelper.getData(key: 'token');

    String finalPath = (type == UserManagement.banned)
        ? 'banned'
        : (type == UserManagement.approved)
            ? 'approved'
            : (type == UserManagement.muted)
                ? 'muted'
                : 'moderator';
    DioHelper.getData(path: '/r/${settings.communityName}/about/$finalPath')
        .then((value) {
      if (value.statusCode == 200) {
        users = value.data.map((user) => BannedUser.fromJson(user));
        emit(UsersLoaded(users));
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Failed loading ${type.toString()} user', error: true));
    });
    return users;
  }

  ///@param [context] mod tools screen context
  ///@param [route] the route to which screen navigates to
  ///navigates to the given route name
  void navigate(context, route) {
    Navigator.push(
        context, AppRouter.onGenerateRoute(RouteSettings(name: route)));
  }

  /// indicates whether invited mod has full permissions
  bool isFullPermissions = true;

  ///indicates rest of permissions of moderator
  ///if full permissions then all true
  List<String> permissions = [
    'Access',
    'Config',
    'Flair',
    'Chat config',
    'Mail',
    'Posts',
    'Wiki',
    'Chat operator',
  ];

  List<bool> permissionValues = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  ///invited moderator username
  String? invitedModerator;

  /// to check if username textfield is empty
  bool emptyModUsername = true;

  ///@param [username] username of moderator to invite
  void modButtonState(String username) {
    emptyModUsername = username.isEmpty;
    invitedModerator = username;
    emit(EnableButton());
  }

  ///handles toggling permissions in invite moderator screen
  ///@param [index] the index of the toggled checkbox
  void togglePermissions(int index) {
    // if full permisions is pressed
    if (index == -1) {
      isFullPermissions = !isFullPermissions;
      //sets all permission to true
      permissionValues = permissionValues.map((value) => true).toList();
      emit(Toggle());
      return;
    }
    //if any other permission is pressed
    permissionValues[index] = !permissionValues[index];
    if (permissionValues.contains(false)) {
      isFullPermissions = false;
      emit(Toggle());
    } else {
      isFullPermissions = true;
      emit(Toggle());
    }
  }

  ///@param [context] context of invite moderator screen
  void inviteModerator(context) {
    String? token = CacheHelper.getData(key: 'token');
    Moderator moderator = Moderator(
      username: invitedModerator,
      subreddit: settings.communityName,
      permissionToEverything: isFullPermissions,
      permissionToManageFlair: permissionValues[2],
      permissionToManagePostsComments: permissionValues[5],
      permissionToManageSettings: permissionValues[1],
      permissionToManageUsers: permissionValues[0],
    );

    DioHelper.postData(token: token, path: inviteMod, data: moderator.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'u/$invitedModerator was invited', error: false));
        emit(InviteMod());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Error inviting user', error: true));
    });
  }
}
