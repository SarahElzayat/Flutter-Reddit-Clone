class BanUserModel {
  String? username;
  String? subreddit;
  int? banPeriod;
  String? reasonForBan;
  String? modNote;
  String? noteInclude;

  BanUserModel(
      {this.username,
      this.subreddit,
      this.banPeriod,
      this.reasonForBan,
      this.modNote,
      this.noteInclude});

  BanUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    subreddit = json['subreddit'];
    banPeriod = json['banPeriod'];
    reasonForBan = json['reasonForBan'];
    modNote = json['modNote'];
    noteInclude = json['noteInclude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['subreddit'] = subreddit;
    data['banPeriod'] = banPeriod;
    data['reasonForBan'] = reasonForBan;
    data['modNote'] = modNote;
    data['noteInclude'] = noteInclude;
    return data;
  }
}

class MuteUserModel {
  String? username;
  String? muteReason;

  MuteUserModel({this.username, this.muteReason});

  MuteUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    muteReason = json['muteReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['muteReason'] = muteReason;
    return data;
  }
}

class InviteModeratorModel {
  String? username;
  String? subreddit;
  String? avatar;
  String? dateOfModeration;
  bool? permissionToEverything;
  bool? permissionToManageUsers;
  bool? permissionToManageSettings;
  bool? permissionToManageFlair;
  bool? permissionToManagePostsComments;
  List<String>? permissions;

  InviteModeratorModel(
      {this.username,
      this.subreddit,
      this.avatar,
      this.dateOfModeration,
      this.permissions,
      this.permissionToEverything,
      this.permissionToManageUsers,
      this.permissionToManageSettings,
      this.permissionToManageFlair,
      this.permissionToManagePostsComments});

  InviteModeratorModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    subreddit = json['subreddit'];
    dateOfModeration = json['dateOfModeration'];
    permissionToEverything = json['permissionToEverything'];
    permissionToManageUsers = json['permissionToManageUsers'];
    permissionToManageSettings = json['permissionToManageSettings'];
    permissionToManageFlair = json['permissionToManageFlair'];
    permissionToManagePostsComments = json['permissionToManagePostsComments'];
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['subreddit'] = subreddit;
    data['avatar'] = avatar;
    data['dateOfModeration'] = dateOfModeration;
    data['permissionToEverything'] = permissionToEverything;
    data['permissionToManageUsers'] = permissionToManageUsers;
    data['permissionToManageSettings'] = permissionToManageSettings;
    data['permissionToManageFlair'] = permissionToManageFlair;
    data['permissionToManagePostsComments'] = permissionToManagePostsComments;
    data['permissions'] = permissions;
    return data;
  }
}

class ApproveUserModel {
  String? username;

  ApproveUserModel({this.username});

  ApproveUserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    return data;
  }
}
