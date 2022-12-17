///@author: Yasmine Ghanem
///@date: 10/12/2022
///moderation cubit that handles all moduration functions

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/moderation_models/actions_user_model.dart';
import 'package:reddit/data/moderation_models/community_settings_model.dart';
import 'package:reddit/data/moderation_models/description_model.dart';
import 'package:reddit/data/moderation_models/get_users_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/router.dart';
part 'moderation_state.dart';

class ModerationCubit extends Cubit<ModerationState> {
  ///settings of the community
  late CommunitySettingsModel settings;
  late ModPostSettingsModel postSettings;

  ///suggested topics for a subreddit list
  List<dynamic> topics = [];
  late TextEditingController controller;
  ModerationCubit() : super(ModerationInitial());
  static ModerationCubit get(context) => BlocProvider.of(context);

  ///text editing controllers for textfields in modtools' screens

  ///text editing controller fo the community description textfield
  ///userd in description screen
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController welcomeMessageController =
      TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController modNoteController = TextEditingController();
  final TextEditingController userNoteController = TextEditingController();

  ///@param [context]
  ///@param [name] the name of the subreddit
  ///returns the current community settings of a certain subreddit
  void getCommunitySettings(context, name) {
    DioHelper.getData(path: '/r/$name/about/edit').then((value) {
      if (value.statusCode == 200) {
        settings = CommunitySettingsModel.fromJson(value.data);
        Logger().e(settings.communityDescription);
        usernameController.text = settings.communityName as String;
        descriptionController.text = settings.communityDescription as String;
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Failed to load community settings loaded'));
    });
  }

  ///returns the post settings for a certain subreddit
  ///@param [context]
  ///@param [name]
  void getPostSettings(context, name) {
    DioHelper.getData(path: '/r/$name/about/edit-post-settings').then((value) {
      if (value.statusCode == 200) {
        postSettings = ModPostSettingsModel.fromJson(value.data);
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Failed loading post settings'));
    });
  }

  /// gets the current settings of the subreddit being moderated
  void getSettings(context, name) {
    getCommunitySettings(context, name);
    getPostSettings(context, name);
    emit(LoadSettings());
  }

  /// updates the community settings when save changes button is pressed
  void updateCommunitySettings(context) {
    settings.communityDescription = descriptionController.text;
    DioHelper.putData(
            path: '/r/${settings.communityName}/about/edit',
            data: settings.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        Logger().e(settings.communityDescription);
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Community settings updated successfully', error: false));
      }
    });
  }

  /// updates the post and comments settings when save changes button is pressed
  void updatePostSettings(context) {
    DioHelper.putData(
            path: '/r/${settings.communityName}/about/edit-post-settings',
            data: postSettings.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Post settings updated successfully', error: false));
      }
    });
  }

  ///updates settings when the save changes button is pressed
  void updateSettings(context) {
    Logger().e(descriptionController.text);
    settings.communityDescription = descriptionController.text;
    settings.communityName = usernameController.text;
    try {
      updateCommunitySettings(context);
      updatePostSettings(context);
      getCommunitySettings(context, settings.communityName);
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Settings updated successfully', error: false));
      emit(LoadSettings());
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: 'Failed to update settings'));
    }
  }

  void getSuggestedTopics(context) {
    DioHelper.getData(path: '/r/${settings.communityName}/suggested-topics')
        .then((value) {
      if (value.statusCode == 200) {}
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Failed to load topics\n${error.response}'));
    });
  }

  //handling changing the description
  bool isChanged = false;
  bool emptyDescription = true;

  ///@param [description] description currently being edited
  ///checks if the description being edited is changed to enable save button
  void onChanged() {
    if (descriptionController.text != settings.communityDescription) {
      isChanged = true;
      emptyDescription = descriptionController.text.isEmpty;
      settings.communityDescription = descriptionController.text;
      emit(DescriptionChanged());
    }
  }

  ///@param[description] new description of the community
  ///saves a new description to the community
  void saveDescription(description) {
    DescriptionModel descriptionModel =
        DescriptionModel(description: description);
    DioHelper.postData(
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
  void checkDays() {
    emptyDays = daysController.text.isEmpty;
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

  ///@param [username] username of user to ban
  ///updates button state whether enabled or not
  void buttonState(String username) {
    emptyUsername = username.isEmpty;
    emit(EnableButton());
  }

  //User moderation funactions in subreddit
  // a moderator can ban, mute, approve or invite user as a moderator

  ///@param[context] context of banned users screen
  /// this functions bans a user from a subreddit
  void banUser(context) {
    BanUserModel banUser = BanUserModel(
        username: usernameController.text,
        subreddit: settings.communityName ?? 'yazzooz',
        banPeriod: permenant ? 0 : daysController.text as int,
        reasonForBan: banReason,
        modNote: modNoteController.text,
        noteInclude: userNoteController.text);

    DioHelper.postData(path: ban, data: banUser.toJson()).then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'User banned successfully', error: false));
        getUsers(context, UserManagement.banned);
        emit(BanUser());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: 'Failed to ban user'));
    });
  }

  ///@param [context] context of invite moderator screen
  ///this function invites a user as a moderator
  void inviteModerator(context) {
    InviteModeratorModel inviteModerator = InviteModeratorModel(
      username: usernameController.text,
      subreddit: settings.communityName,
      permissionToEverything: isFullPermissions,
      permissionToManageFlair: permissionValues[2],
      permissionToManagePostsComments: permissionValues[5],
      permissionToManageSettings: permissionValues[1],
      permissionToManageUsers: permissionValues[0],
    );

    DioHelper.postData(
            token: token, path: inviteMod, data: inviteModerator.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'u/$invitedModerator was invited', error: false));
        getUsers(context, UserManagement.moderator);
        emit(InviteMod());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Error inviting user', error: true));
    });
  }

  ///@param [context] context of invite moderator screen
  ///this function mutes a user in a subreddit
  void muteUser(context) {
    MuteUserModel mutedUser = MuteUserModel(
        username: usernameController.text, muteReason: modNoteController.text);
    DioHelper.postData(
            path: '/r/yazzooz/mute-user',
            data: mutedUser.toJson(),
            token: token)
        .then((value) {
      if (value.statusCode == 200) {
        getUsers(context, UserManagement.muted);
        emit(MuteUser());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Error muting user\n${error.response!.data}'));
    });
  }

  ///@param [context] context of invite moderator screen
  ///this function approves a user into a subreddit
  void approveUser(context) {
    ApproveUserModel approveUser =
        ApproveUserModel(username: usernameController.text);
    DioHelper.postData(
            token: token,
            path: '/r/yazzooz/approve-user',
            data: approveUser.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            responseSnackBar(message: 'User approved', error: false));
        getUsers(context, UserManagement.approved);
        emit(ApproveUser());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Error approving user\n${error.response!.data}'));
    });
  }

  List<dynamic> users = [];

  void getUsers(context, UserManagement type) {
    String finalPath = (type == UserManagement.banned)
        ? 'banned'
        : (type == UserManagement.muted)
            ? 'muted'
            : (type == UserManagement.approved)
                ? 'approved'
                : 'moderators';
    DioHelper.getData(path: '/r/yazzooz/about/$finalPath').then((value) {
      Logger().e(value.data['children']);
      if (value.statusCode == 200) {
        users = value.data['children']
            .map((value) => (type == UserManagement.banned)
                ? BannedUsersModel.fromJson(value as Map<String, dynamic>)
                : (type == UserManagement.muted)
                    ? MuteUserModel.fromJson(value as Map<String, dynamic>)
                    : (type == UserManagement.approved)
                        ? ApprovedUsersModel.fromJson(
                            value as Map<String, dynamic>)
                        : ModeratorsModel.fromJson(
                            value as Map<String, dynamic>))
            .toList();
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Failed loading muted users', error: true));
    });
  }

  List<dynamic> bannedUsers = [];

  ///@param [context] user management screen context
  ///gets a list of users based on the user management type [banned, muted, moderator, approved]
  void getBannedUsers(context) {
    DioHelper.getData(path: '/r/yazzooz/about/banned').then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        bannedUsers = value.data['children']
            .map((value) =>
                BannedUsersModel.fromJson(value as Map<String, dynamic>))
            .toList();
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Failed loading banned users'));
    });
  }

  List<dynamic> mutedUsers = [];

  void getMutedUsers(context) {
    DioHelper.getData(path: '/r/yazzooz/about/muted').then((value) {
      if (value.statusCode == 200) {
        mutedUsers = value.data['children']
            .map((value) =>
                MuteUserModel.fromJson(value as Map<String, dynamic>))
            .toList();
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Failed loading muted users', error: true));
    });
  }

  List<dynamic> approvedUsers = [];

  void getApprovedUsers(context) {
    DioHelper.getData(path: '/r/yazzooz/about/approved').then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        approvedUsers = value.data['children']
            .map((approvedUser) => ApproveUserModel.fromJson(approvedUser))
            .toList();
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Failed loading approved users'));
    });
  }

  List<dynamic> moderators = [];

  void getModerators(context) {
    DioHelper.getData(path: '/r/yazzooz/about/moderators').then((value) {
      if (value.statusCode == 200) {
        Logger().e(value.data['children']);
        moderators = value.data['children']
            .map((user) => ModeratorsModel.fromJson(user))
            .toList();
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: 'Failed loading moderators'));
    });
  }

  //Queues related functions
  void getSpam() {}

  void getEdited() {}

  void getUnmoderated() {}

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

  ///selected item from enum [ModToolsSelectedItem] indicates the lit tile chosen to act accoridingly
  ///the function sets it to the incoming item
  ///the default is spam
  ///shows the spam widget
  ModToolsSelectedItem webSelectedItem = ModToolsSelectedItem.spam;
  ModToolsGroup webSelectedGroup = ModToolsGroup.queues;

  ///@param [item] the tile chosen from the mod tools in web
  setWebSelectedItem(context, ModToolsSelectedItem item, ModToolsGroup group) {
    webSelectedItem = item;
    webSelectedGroup = group;
    if (webSelectedGroup == ModToolsGroup.userManagement) {
      UserManagement type = (item == ModToolsSelectedItem.approved)
          ? UserManagement.approved
          : (item == ModToolsSelectedItem.banned)
              ? UserManagement.banned
              : (item == ModToolsSelectedItem.muted)
                  ? UserManagement.muted
                  : UserManagement.moderator;
      getUsers(context, type);
    }
    emit(WebModTools());
  }

  ///List of posts
  ///could be spam, edited, unmoderated
  List<dynamic> posts = [];

  ///value of selected sorting iem
  String? sortingValue = sortingItems.first;

  ///@param [value] the tile chosen from the mod tools in web
  setSortType(value) {
    sortingValue = value;
    emit(SetDropdownItem());
  }

  ///value of selected listing iem
  String? listingTypeValue = listingTypes.first;

  ///@param [value] the tile chosen from the mod tools in web
  setListType(String? value) {
    listingTypeValue = value;
    emit(SetDropdownItem());
  }

  /// value of selected view
  String? viewValue = view.first;

  ///@param [value] the tile chosen from the mod tools in web
  setView(String? value) {
    viewValue = value;
    emit(SetDropdownItem());
  }

  ///@param [value] new switch value to toggle switch
  toggleNSFWSwitch(value) {
    settings.nSFW = value;
    emit(Toggle());
  }

  ///@param [value] new switch value to toggle switch
  toggleMessageSwitch(value) {
    settings.sendWelcomeMessage ?? false;
    settings.sendWelcomeMessage = value;
    emit(Toggle());
  }

  ///@param [value] chosen community language
  setCommunityLanguage(String? value) {
    settings.language = value;
    emit(SetDropdownItem());
  }

  ///@param [value] chosen community region
  setCommunityRegion(String? value) {
    settings.region = value;
    emit(SetDropdownItem());
  }

  String communityTopic = 'Activism';

  ///@param [value] chosen community region
  setCommunityTopic(value) {
    communityTopic = value;
    settings.subTopics = [communityTopic, communityTopic];
    settings.mainTopic = communityTopic;
    emit(SetDropdownItem());
  }

  // bool settingsChanged = false;
  bool settingsChanged() {
    return true;
  }

  //MOD NOTIFICATIONS
  bool notificationsSwitch = false;
  void toggleModNotifications() {
    notificationsSwitch = !notificationsSwitch;
    emit(Toggle());
  }

  bool milestoneSwitch = false;
  void toggleMilestone() {
    milestoneSwitch = !milestoneSwitch;
    emit(Toggle());
  }

  bool tipsSwitch = false;
  void toggleTips() {
    tipsSwitch = !tipsSwitch;
    emit(Toggle());
  }

  //POST AND COMMENT SETTINGS
  ///post type
  String postOption = postOptions.first;

  ///@param [value] chosen post type from dropdown list
  void setPostType(value) {
    postOption = value;
    emit(SetDropdownItem());
  }

  /// suggested sort
  String sort = suggestedSort.first;

  ///@param [value] chosen post type from dropdown list
  void setSuggestedSort(value) {
    sort = value;
    emit(SetDropdownItem());
  }

  // all switches in the comments section settings
  Map<String, bool> commentsSwitches = {
    'crossposting': false,
    'archivePosts': false,
    'spoilerTag': false,
    'multipleImages': false,
    'predictions': false,
    'collapseComments': false,
    'giphy': false,
    'images': false,
    'gifs': false
  };

  void toggleCommentSwitches(key, value) {
    commentsSwitches[key] = value;
    emit(Toggle());
  }
}
