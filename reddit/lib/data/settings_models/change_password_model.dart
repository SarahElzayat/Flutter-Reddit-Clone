/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is a model for tchange password request
/// to convert from and to a json in order
/// to be able to send a requests to the backend.

class ChangePasswordModel {
  String? currentPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordModel(
      {this.currentPassword, this.newPassword, this.confirmNewPassword});

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
    confirmNewPassword = json['confirmNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = {
      'currentPassword': currentPassword!,
      'newPassword': newPassword!,
      'confirmNewPassword': confirmNewPassword!,
    };
    return data;
  }
}
