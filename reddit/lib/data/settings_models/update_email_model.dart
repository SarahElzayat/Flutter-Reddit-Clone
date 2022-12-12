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
