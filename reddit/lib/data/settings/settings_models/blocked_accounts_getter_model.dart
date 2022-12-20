class BlockedAccountsGetterModel {
  String? username;
  String? avatar;
  String? blockDate;

  BlockedAccountsGetterModel({this.username, this.avatar, this.blockDate});

  BlockedAccountsGetterModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    blockDate = json['blockDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'avatar': avatar,
      'blockDate': blockDate,
    };
    return data;
  }
}
