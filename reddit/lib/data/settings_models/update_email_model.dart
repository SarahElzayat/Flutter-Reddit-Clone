/// @author Abdelaziz Salah
/// @date 12/12/2022
/// This is a model for the update emai request to
/// convert from and to a json in order
/// to be able to send a requests to the backend.

class UpdateEmail {
  String? currentPassword;
  String? newEmail;

  UpdateEmail({this.currentPassword, this.newEmail});

  UpdateEmail.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    newEmail = json['newEmail'];
  }

  Map<String, String> toJson() {
    Map<String, String> data = {
      'currentPassword': currentPassword!,
      'newEmail': newEmail!
    };
    return data;
  }
}
