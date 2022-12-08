part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ChangeBottomNavBarState extends AppState {}

class ChangeHomeMenuIndex extends AppState {}

class ChangeHomeMenuDropdownState extends AppState {}

class ChangeRightDrawerState extends AppState {}
class ChangeLeftDrawerState extends AppState {}
// class ChangeEndDrawerState extends AppState {}

class ChangeModeratingListState extends AppState {}
class ChangeYourCommunitiesState extends AppState {}

class ChangeHistoryCategoryState extends AppState{}
class ChangeHistoryPostViewState extends AppState{}
class LoadingHistoryState extends AppState{}
class HistoryEmptyState extends AppState{}
class LoadedHistoryState extends AppState{}
// class AppInitial extends AppState {}
// class AppInitial extends AppState {}
