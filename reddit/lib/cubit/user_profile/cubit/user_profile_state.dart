part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class FollowOrUnfollowState extends UserProfileState {}

class ChangeUserProfileInfo extends UserProfileState {}

class ChangeUserProfileSocialLinks extends UserProfileState {}

class ChangeUserProfileBanner extends UserProfileState {}
