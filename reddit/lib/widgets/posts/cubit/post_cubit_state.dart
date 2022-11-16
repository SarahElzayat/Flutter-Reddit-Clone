/// this defines the state of the post cubit
/// @date 16/11/2022
/// @auther Ahmed Atta
abstract class PostCubitState {}

class PostCubitInitial extends PostCubitState {}

class PostCubitvoted extends PostCubitState {}

class PostCubitvotedError extends PostCubitState {}


class PostCubitSaved extends PostCubitState {}

class PostCubitHideChange extends PostCubitState {}

class PostCubitReported extends PostCubitState {}

class PostCubitDeleted extends PostCubitState {}
