///@author: Yasmine Ghanem
///@date: 10/12/2022
///moderation cubit that handles all moduration functions

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:reddit/components/helpers/color_manager.dart';
import 'package:reddit/components/helpers/enums.dart';
import 'package:reddit/components/snack_bar.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/data/moderation_models/actions_user_model.dart';
import 'package:reddit/data/moderation_models/community_settings_model.dart';
import 'package:reddit/data/moderation_models/description_model.dart';
import 'package:reddit/data/moderation_models/flairs_model.dart';
import 'package:reddit/data/moderation_models/get_users_model.dart';
import 'package:reddit/data/post_model/post_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/screens/comments/add_comment_screen.dart';
part 'moderation_state.dart';

class ModerationCubit extends Cubit<ModerationState> {
  ModerationCubit() : super(ModerationInitial());

  /// for accessing the cubit outside the class
  static ModerationCubit get(context) => BlocProvider.of(context);

  ///settings of the community
  CommunitySettingsModel settings = CommunitySettingsModel();
  ModPostSettingsModel postSettings = ModPostSettingsModel();

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
  final TextEditingController regionController = TextEditingController();

  ///Post settings variable

  ///Community type varialbles
  bool typeChanged = false;
  bool nsfwSwitch = false;
  Color? typeColor;
  String? communityType;

  ///Post type variables
  bool postTypeChanged = false;
  bool imageLinks = false;
  bool videoLinks = false;

  ///Welcome message variables
  bool sendMessageSwitch = false;
  bool messageChanged = false;

  ///Location variables
  bool regionChanged = false;

  ///topics variables
  bool topicChanged = false;
  String selectedTopic = '';

  //description variables
  bool descriptionChanged = false;
  bool emptyDescription = true;

  //quesues variable
  List<PostModel> posts = [];
  String afterId = '';
  String beforeId = '';

  ///user management variables
  ///checks whether a user is banned permenant
  bool permenant = true;
  bool emptyDays = true;
  bool emptyReason = true;
  String banReason = 'Pick a reason';
  bool emptyUsername = true;
  List<dynamic> users = [];

  ///GET requests

  ///@param [context] screen context
  ///@param [name] community name
  ///sends a GET request to retrieve the settings of a certain subreddit
  void getCommunitySettings(context, name) {
    DioHelper.getData(path: '/r/$name/about/edit').then((value) {
      if (value.statusCode == 200) {
        settings = CommunitySettingsModel.fromJson(value.data);

        //Initialize community settings in all screens

        //initialize community description to appear in text field
        descriptionController.text = (settings.communityDescription ?? '');

        //initialize community welcome message to appear in text field
        welcomeMessageController.text = (settings.welcomeMessage ?? '');

        //initialize community location to appear in text field
        regionController.text = settings.region.toString();

        //initialize community type settings
        nsfwSwitch = (settings.nSFW == true) ? true : false;
        communityType = settings.type;
        typeColor = (settings.type == 'Public')
            ? ColorManager.green
            : (settings.type == 'Private')
                ? ColorManager.red
                : ColorManager.yellow;

        sendMessageSwitch =
            (settings.sendWelcomeMessage == true) ? true : false;

        emit(SettingsLoaded(settings));
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
          message: 'Failed to load community settings loaded'));
    });
  }

  ///returns the post settings for a certain subreddit
  ///@param [context] screen context
  ///@param [name] name of the subreddit
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

  ///@param [context] screen context
  ///@param [name] name of the subreddit
  /// gets the current settings of the subreddit being moderated
  void getSettings(context, name) {
    getCommunitySettings(context, name);
    getPostSettings(context, name);
    emit(LoadSettings());
  }

  ///@param [context] screen context
  ///@param [loadMore] indicates whether the user wants more posts to be shown
  ///true when the scrollbar reaches end of screen
  ///@param [after] index to indicate the next request
  ///@param [before] index to indicate the next request
  ///@param [limit] number of posts retrieved from the request
  ///gets the posts in queue moderation in web
  void getQueuePosts(
      {context,
      bool loadMore = false,
      bool before = false,
      bool after = false,
      int limit = 10}) {
    if (kDebugMode) {
      logger.wtf('after$afterId');
      logger.wtf('before$beforeId');
    }

    loadMore ? emit(LoadingMoreQueue()) : emit(LoadingQueue());
    if (!loadMore) {
      posts.clear();
      beforeId = '';
      afterId = '';
    } else {
      if (kDebugMode) {
        logger.wtf('AFFFTEEEEERRRRRR ');
      }
      if (kDebugMode) {
        logger.wtf(posts[posts.length - 1].id);
      }
    }
    final query = {
      'after': after ? afterId : null,
      'before': before ? beforeId : null,
      'limit': limit,
      'sort': sortingValue!.toLowerCase(),
      'only': listingTypeValue!.toLowerCase()
    };

    String finalPath = (webSelectedItem == ModToolsSelectedItem.spam)
        ? 'spam'
        : (webSelectedItem == ModToolsSelectedItem.edited)
            ? 'edited'
            : 'unmoderated';

    DioHelper.getData(
            path: '/r/${settings.communityName}/about/$finalPath', query: query)
        .then((value) {
      if (value.statusCode == 200) {
        if (value.data['children'].length == 0) {
          if (kDebugMode) {
            logger.wtf('EMPPPTTYYYYY');
          }
        } else {
          logger.wtf(value.data['children']);
          for (int i = 0; i < value.data['children'].length; i++) {
            // logger.wtf(i);
            posts.add(PostModel.fromJsonwithData(value.data['children'][i]));
            loadMore ? emit(LoadedMoreQueue()) : emit(LoadedQueue());
          }
        }
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: 'Error loading posts'));
    });
  }

  ///@param[context] screen context
  ///retieves the suggested topics a subreddit can be bout
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

  ///@param [context] screen context
  ///@param [type] user management screen type
  ///returns users based on the type of widget
  void getUsers(context, UserManagement type) {
    String finalPath = (type == UserManagement.banned)
        ? 'banned'
        : (type == UserManagement.muted)
            ? 'muted'
            : (type == UserManagement.approved)
                ? 'approved'
                : 'moderators';
    DioHelper.getData(path: '/r/${settings.communityName}/about/$finalPath')
        .then((value) {
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

  ///POST and PUT requests

  ///@param [context] screen context
  /// updates the community settings when save changes button is pressed
  void updateCommunitySettings(context) {
    settings.welcomeMessage = welcomeMessageController.text;
    logger.wtf(token);
    final Map<String, dynamic> data = <String, dynamic>{};
    data['communityName'] = settings.communityName;
    data['mainTopic'] = settings.mainTopic;
    data['subTopics'] = settings.subTopics;
    data['communityDescription'] = descriptionController.text;
    data['sendWelcomeMessage'] = sendMessageSwitch;
    data['welcomeMessage'] = welcomeMessageController.text;
    data['language'] = settings.language;
    data['Region'] = regionController.text;
    data['Type'] = communityTopic;
    data['NSFW'] = nsfwSwitch;
    data['acceptingRequestsToJoin'] = settings.acceptingRequestsToJoin;
    data['acceptingRequestsToPost'] = settings.acceptingRequestsToPost;
    data['approvedUsersHaveTheAbilityTo'] =
        settings.approvedUsersHaveTheAbilityTo;

    DioHelper.putData(
            sentToken: token,
            path: '/r/${settings.communityName}/about/edit',
            data: data)
        .then((value) {
      if (value.statusCode == 200) {
        typeChanged = false;
        messageChanged = false;
        regionChanged = false;
        getCommunitySettings(context, settings.communityName);
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Community settings updated successfully', error: false));
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: '${error.response}'));
    });
  }

  ///@param [context] screen context
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

  ///@param [context] screen context
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

  ///adds or edits the description of the community
  ///saves a new description to the community
  void saveDescription() {
    DescriptionModel descriptionModel =
        DescriptionModel(description: descriptionController.text);
    DioHelper.postData(
            path: '/r/${settings.communityName}/add-description',
            data: descriptionModel.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        settings.communityDescription = descriptionController.text;
        descriptionChanged = false;
        emit(SaveDescription());
      }
    }).catchError((error) {
      error = error as DioError;
    });
  }

  //User moderation funactions in subreddit
  // a moderator can ban, mute, approve or invite user as a moderator

  ///@param[context] context of banned users screen
  /// this functions bans a user from a subreddit
  void banUser(context) {
    BanUserModel banUser = BanUserModel(
        username: usernameController.text,
        subreddit: settings.communityName,
        banPeriod: permenant ? 0 : daysController.text as int,
        reasonForBan: banReason,
        modNote: modNoteController.text,
        noteInclude: userNoteController.text);

    DioHelper.postData(sentToken: token, path: ban, data: banUser.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'User banned successfully', error: false));
        getUsers(context, UserManagement.banned);
        emit(BanUser());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Failed to ban user\n ${error.response}'));
    });
  }

  void unbanUser(username) {
    UnbanUserModel unbanUser =
        UnbanUserModel(subreddit: settings.communityName, username: username);
    DioHelper.postData(
            sentToken: token, path: '/unban', data: unbanUser.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        logger.wtf('tamam');
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      logger.wtf('msh tamam');
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
            sentToken: token, path: inviteMod, data: inviteModerator.toJson())
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

  void removeModerator() {}

  ///@param [context] context of invite moderator screen
  ///this function mutes a user in a subreddit
  void muteUser(context) {
    MuteUserModel mutedUser = MuteUserModel(
        username: usernameController.text, muteReason: modNoteController.text);
    DioHelper.postData(
            path: '/r/${settings.communityName}/mute-user',
            data: mutedUser.toJson(),
            sentToken: token)
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

  void unmuteUser(username) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    DioHelper.postData(
            sentToken: token,
            path: '/r/${settings.communityName}/unmute-user',
            data: data)
        .then((value) {
      if (value.statusCode == 200) {
        logger.wtf('tamam');
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      logger.wtf('msh tamam');
    });
  }

  ///@param [context] context of invite moderator screen
  ///this function approves a user into a subreddit
  void approveUser(context) {
    ApproveUserModel approveUser =
        ApproveUserModel(username: usernameController.text);
    DioHelper.postData(
            sentToken: token,
            path: '/r/${settings.communityName}/approve-user',
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

  void removeUser(username) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    DioHelper.postData(
            sentToken: token,
            path: '/r/${settings.communityName}/remove-user',
            data: data)
        .then((value) {
      if (value.statusCode == 200) {
        logger.wtf('tamam');
        emit(UsersLoaded());
      }
    }).catchError((error) {
      error = error as DioError;
      logger.wtf('msh tamam');
    });
  }

  //onChanged functions
  //check if the settings have been changed to enabale or disable a button

  ///checks if the description being edited is changed to enable save button
  void onChangedDescription() {
    if (descriptionController.text != settings.communityDescription) {
      descriptionChanged = true;
      emptyDescription = descriptionController.text.isEmpty;
      emit(TextFieldChanged());
    }
  }

  ///checks if the region assigned to a subreddit is changed to enable save button
  void onChangedRegion() {
    if (regionController.text != settings.region) {
      regionChanged = true;
      emit(TextFieldChanged());
    }
  }

  ///checks if the the community type have been changed
  void communityTypeChanged() {
    if (settings.nSFW != nsfwSwitch || settings.type != communityType) {
      typeChanged = true;
      emit(Toggle());
    }
  }

  ///checks if the the community welcome message have been changed
  void onChangedWelcomeMessage() {
    if (welcomeMessageController.text != settings.welcomeMessage ||
        sendMessageSwitch != settings.sendWelcomeMessage) {
      messageChanged = true;
      emit(TextFieldChanged());
    }
  }

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

  ///toggles permenant checkbox
  ///indicates whether user is banned permenantly or for a certain time
  void togglePermenant() {
    permenant = !permenant;
    emit(Toggle());
  }

  ///@param [reason] reason for banning a user
  ///sets reason chosen from modal bottom sheet
  void setBanReason(reason) {
    banReason = reason;
    emptyReason = false;
    emit(BanReasonChosen());
  }

  ///@param [username] username of user to ban
  ///updates button state whether enabled or not
  void buttonState(String username) {
    emptyUsername = username.isEmpty;
    emit(EnableButton());
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

  //FLAIRS
  List<dynamic> postFlairs = [];

  void getPostFlairs() {
    DioHelper.getData(path: '/r/${settings.communityName}/about/post-flairs')
        .then((value) {
      if (value.statusCode == 200) {
        postFlairs = value.data['postFlairs']
            .map((flair) => PostFlairModel.fromJson(flair))
            .toList();

        (postFlairs.isEmpty) ? emit(EmptyQueue()) : emit(HandleFlairs());
      }
    }).catchError((error) {
      error = error as DioError;
    });
  }

  bool modOnly = false;
  bool allowUser = false;
  String flairType = 'Text & emoji';
  int emojisLimit = 10;
  bool enablePostFlairs = false;

  void setPostFlairSettings(
      context, modOnly, allowsUser, flairType, emojisLimit) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enablePostFlairs'] = enablePostFlairs;
    data['allowUsers'] = allowUser;
    DioHelper.postData(
            path: '/r/${settings.communityName}/about/post-flairs-settings',
            data: data)
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            responseSnackBar(message: 'Success setting flair settings'));
        emit(HandleFlairs());
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Fialed to set flair settings'));
    });
  }

  ///@param[name]
  ///@param[backgroundColor]
  ///@param[textColor]
  void addFlair(context, name, backgroundColor, textColor) {
    FlairSettingModel flairSettings = FlairSettingModel(
        modOnly: modOnly,
        flairType: flairType,
        emojisLimit: emojisLimit,
        allowUserEdits: allowUser);
    PostFlairModel postFlair = PostFlairModel(
        flairName: name,
        backgroundColor: backgroundColor,
        textColor: textColor,
        settings: flairSettings);
    DioHelper.postData(
            sentToken: token,
            path: '/r/${settings.communityName}/about/post-flairs',
            data: postFlair.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        postFlairs.add(postFlair);
        emit(HandleFlairs());
        Navigator.pop(context);
      }
    }).catchError((error) {
      error = error as DioError;
      logger.e(error.response);
    });
  }

  PostFlairSettingsModel postFlairSetting = PostFlairSettingsModel();
  void getPostFlairSettings() {
    DioHelper.getData(
            path: '/r/${settings.communityName}/about/post-flairs-settings')
        .then((value) {
      if (value.statusCode == 200) {
        postFlairSetting =
            value.data.map((value) => PostFlairSettingsModel.fromJson(value));
        emit(HandleFlairs());
      }
    }).catchError((error) {
      error = error as DioError;
    });
  }

  void deletePostFlair(flairId) {
    DioHelper.deleteData(
            path: '/r/${settings.communityName}/about/post-flairs/$flairId')
        .then((value) {
      if (value.statusCode == 200) {
        getPostFlairs();
        emit(HandleFlairs());
      }
    }).catchError((error) {
      error = error as DioError;
    });
  }

  void addCommunityTopics(context) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = selectedTopic;

    DioHelper.postData(
            sentToken: token,
            path: '/r/${settings.communityName}/add-maintopic',
            data: data)
        .then((value) {
      if (value.statusCode == 200) {
        settings.mainTopic = selectedTopic;
        settings.subTopics = [selectedTopic];
        topicChanged = false;
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Topic added successfully', error: false));
        emit(EnableButton());
        Navigator.pop(context);
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: '${error.response}'));
    });
  }
}
