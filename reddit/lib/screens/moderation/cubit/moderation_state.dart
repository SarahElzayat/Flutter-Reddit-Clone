part of 'moderation_cubit.dart';

@immutable
abstract class ModerationState {}

class ModerationInitial extends ModerationState {}

class LoadSettings extends ModerationState {}

class SetSettings extends ModerationState {}

class UpdateSettings extends ModerationState {}

class DescriptionChanged extends ModerationState {}

class BanReasonChosen extends ModerationState {}

class Toggle extends ModerationState {}

class EnableButton extends ModerationState {}

class BanUser extends ModerationState {}

class MuteUser extends ModerationState {}

class ApproveUser extends ModerationState {}

class InviteMod extends ModerationState {}

class WebModTools extends ModerationState {}

class SetDropdownItem extends ModerationState {}

class UsersLoaded extends ModerationState {}

class TopicsLoaded extends ModerationState {}
