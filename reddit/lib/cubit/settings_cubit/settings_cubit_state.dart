import 'dart:isolate';

abstract class SettingsCubitState {}

class SettingsCubitInitial extends SettingsCubitState {}

class ChangeSwitchState extends SettingsCubitState {}

class ChangePassword extends SettingsCubitState {}

class ChangeEmail extends SettingsCubitState {}

class UnBlockState extends SettingsCubitState {
  bool isLoaded;
  UnBlockState(this.isLoaded);
}

class ChangeLanguageState extends SettingsCubitState {}

class ChangeFontSizeState extends SettingsCubitState {}

class ChangePostLayoutState extends SettingsCubitState {}
