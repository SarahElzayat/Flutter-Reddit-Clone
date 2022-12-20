part of 'create_community_cubit.dart';

@immutable
abstract class CreateCommunityState {}

class CreateCommunityInitial extends CreateCommunityState {}

class SavedCategoriesLoaded extends CreateCommunityState {
  final List<dynamic> categories;
  SavedCategoriesLoaded(this.categories);
}

class InitializeSettings extends CreateCommunityState {}

class CreateCommunity extends CreateCommunityState {}
