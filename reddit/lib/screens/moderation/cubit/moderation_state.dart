part of 'moderation_cubit.dart';

@immutable
abstract class ModerationState {}

class ModerationInitial extends ModerationState {}

class LoadSettings extends ModerationState {}

class SettingsLoaded extends ModerationState {
  final dynamic settings;
  SettingsLoaded(this.settings);
}

class SetSettings extends ModerationState {}

class UpdateSettings extends ModerationState {}

class TextFieldChanged extends ModerationState {}

class BanReasonChosen extends ModerationState {}

class SaveDescription extends ModerationState {}

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

class LoadingMoreQueue extends ModerationState {}

class LoadedMoreQueue extends ModerationState {}

class LoadingQueue extends ModerationState {}

class LoadedQueue extends ModerationState {}

class NoMoreQueueToLoad extends ModerationState {}

class EmptyQueue extends ModerationState {}

class HandleFlairs extends ModerationState {}

class TrafficStatsLoaded extends ModerationState {}
