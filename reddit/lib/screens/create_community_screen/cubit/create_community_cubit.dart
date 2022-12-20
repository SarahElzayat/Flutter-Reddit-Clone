import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import '../../../components/helpers/enums.dart';
import '../../../components/snack_bar.dart';
import '../../../cubit/subreddit/cubit/subreddit_cubit.dart';
import '../../../data/create_community_model/create_community_model.dart';
import '../../../data/create_community_model/saved_categories_model.dart';
import '../../../data/moderation_models/community_settings_model.dart';
import '../../../networks/constant_end_points.dart';
import '../../../networks/dio_helper.dart';
import '../../moderation/cubit/moderation_cubit.dart';
import '../../../shared/local/shared_preferences.dart';

part 'create_community_state.dart';

class CreateCommunityCubit extends Cubit<CreateCommunityState> {
  List<dynamic> categories = [];
  late CreateCommunityModel community;
  CreateCommunityCubit() : super(CreateCommunityInitial());
  static CreateCommunityCubit get(context) => BlocProvider.of(context);

  List<dynamic> getSavedCategories() {
    DioHelper.getData(path: savedCategories).then((value) {
      if (value.statusCode == 200) {
        categories = value.data
            .map((category) => Categories.fromJson(category))
            .toList();
        emit(SavedCategoriesLoaded(categories));
      }
    }).catchError((error) {});
    return categories;
  }

  ///@param [context] of screen
  ///@param [name] subreddit name
  ///@param [type] subreddit type
  ///@param [nsfw] whether subreddit is not safe for work
  ///@param [category] subreddit category
  ///initializes the community settings when first creating a community
  void initializeCommunitySettings(context, name, type, nsfw, category) {
    String finalType = (type == CommunityTypes.public)
        ? 'Public'
        : (type == CommunityTypes.restricted)
            ? 'Restricted'
            : 'Private';
    CommunitySettingsModel settings = CommunitySettingsModel(
        communityName: name,
        type: type,
        nSFW: nsfw ?? false,
        communityDescription: '',
        mainTopic: 'Activism',
        subTopics: [],
        region: 'United States',
        language: 'English',
        welcomeMessage: '',
        sendWelcomeMessage: false,
        acceptingRequestsToJoin: true,
        acceptingRequestsToPost: true,
        approvedUsersHaveTheAbilityTo: 'Post & Comment');

    DioHelper.putData(path: '/r/$name/about/edit', data: settings.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Community settings initialized successfully',
            error: false));
      }
    }).catchError((error) {
      error = error as DioError;
      Logger().e(error.response);
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Couldn\'t initialize community settings'));
    });
  }

  ///initializes the post settings when first creating a community
  ///@param [context] of screen
  ///@param [name] of created subreddit
  void initializePostSettings(context, name) {
    ModPostSettingsModel postSettings = ModPostSettingsModel(
        enableSpoiler: true, allowImagesInComment: true, suggestedSort: 'none');
    DioHelper.putData(
            path: '/r/$name/about/edit-post-settings',
            data: postSettings.toJson())
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'Post settings initialized successfully', error: false));
      }
    }).catchError((error) {
      error = error as DioError;
      ScaffoldMessenger.of(context).showSnackBar(
          responseSnackBar(message: 'Couldn\'t initialize post settings'));
    });
  }

  void creatCommunity(context, name, type, nsfw, category) {
    String finalType = (type == CommunityTypes.private)
        ? 'Private'
        : (type == CommunityTypes.restricted)
            ? 'Restricted'
            : 'Public';
    final CreateCommunityModel community = CreateCommunityModel(
        subredditName: name, type: finalType, nsfw: nsfw, category: category);
    String? token = CacheHelper.getData(key: 'token');

    DioHelper.postData(
            sentToken: token, path: createCommunity, data: community.toJson())
        .then((value) {
      if (value.statusCode == 201) {
        ///TODO: Nagiate to AddPost with community name to add post to community
        initializeCommunitySettings(context, name, type, nsfw, category);
        initializePostSettings(context, name);
        ScaffoldMessenger.of(context).showSnackBar(responseSnackBar(
            message: 'r/$name created successfully', error: false));
        emit(CreateCommunity());
        SubredditCubit.get(context)
            .setSubredditName(context, name, replace: true);
      }
    }).catchError((err) {
      err = err as DioError;
      Logger().e(err.response);
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: 'Failed to create r/$name'));
    });
  }
}
