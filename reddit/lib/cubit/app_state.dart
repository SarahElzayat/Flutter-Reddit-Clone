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
class LoadingMoreHistoryState extends AppState{}
class HistoryEmptyState extends AppState{}
class LoadedHistoryState extends AppState{}
class LoadedMoreHistoryState extends AppState{}
class NoMoreHistoryToLoadState extends AppState{}
class ClearHistoryState extends AppState{}

class LoadingSavedPostsState extends AppState {}
class LoadingMoreSavedPostsState extends AppState {}
class LoadedSavedPostsState extends AppState {}

class LoadingSavedCommentsState extends AppState {}
class LoadingMoreSavedCommentsState extends AppState {}
class LoadedSavedCommentsState extends AppState {}


class LoadedMoreSavedState extends AppState{}
class NoMoreSavedToLoadState extends AppState{}

class SavedEmptyState extends AppState{}
class ErrorState extends AppState{}