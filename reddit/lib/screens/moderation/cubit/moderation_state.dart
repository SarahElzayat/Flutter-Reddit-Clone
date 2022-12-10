part of 'moderation_cubit.dart';

@immutable
abstract class ModerationState {}

class ModerationInitial extends ModerationState {}

class LoadSettings extends ModerationState {}

class SetSettings extends ModerationState {}

class UpdateSettings extends ModerationState {}

class DescriptionChanged extends ModerationState {}

class BanReasonChosen extends ModerationState {}

class TogglePermenant extends ModerationState {}

class EnableBanButton extends ModerationState {}

class BanUser extends ModerationState {}
