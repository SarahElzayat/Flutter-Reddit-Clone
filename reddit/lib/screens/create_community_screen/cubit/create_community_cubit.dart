import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddit/data/create_community_model/create_community_model.dart';
import 'package:reddit/data/create_community_model/saved_categories_model.dart';
import 'package:reddit/networks/constant_end_points.dart';
import 'package:reddit/networks/dio_helper.dart';
import 'package:reddit/shared/local/shared_preferences.dart';

import '../../../components/snack_bar.dart';
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

  void creatCommunity(context, name, type, nsfw, category) {
    final CreateCommunityModel community = CreateCommunityModel(
        subredditName: name, type: type, nsfw: nsfw, category: category);
    String? token = CacheHelper.getData(key: 'token');

    DioHelper.postData(path: createCommunity, data: community.toJson())
        .then((value) {
      if (value.statusCode == 201) {
        ///TODO: Nagiate to AddPost with community name to add post to community

      }
    }).catchError((err) {
      err = err as DioError;
      ScaffoldMessenger.of(context)
          .showSnackBar(responseSnackBar(message: 'Failed to create r/$name'));
    });
  }
}
