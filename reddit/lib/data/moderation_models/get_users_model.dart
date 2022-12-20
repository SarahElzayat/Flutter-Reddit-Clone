///@author: Yasmine Ghanem
///@date: 12/12/2020

class BannedUsersModel {
  String? username;
  String? userId;
  String? avatar;
  String? bannedAt;
  int? banPeriod;
  String? modNote;
  String? noteInclude;
  String? reasonForBan;

  BannedUsersModel(
      {this.username,
      this.userId,
      this.avatar,
      this.bannedAt,
      this.banPeriod,
      this.modNote,
      this.noteInclude,
      this.reasonForBan});

  BannedUsersModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userId = json['userId'];
    avatar = json['avatar'];
    bannedAt = json['bannedAt'];
    banPeriod = json['banPeriod'];
    modNote = json['modNote'];
    noteInclude = json['noteInclude'];
    reasonForBan = json['reasonForBan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['userId'] = userId;
    data['avatar'] = avatar;
    data['bannedAt'] = bannedAt;
    data['banPeriod'] = banPeriod;
    data['modNote'] = modNote;
    data['noteInclude'] = noteInclude;
    data['reasonForBan'] = reasonForBan;
    return data;
  }
}

class MutedUsersModel {
  String? username;
  String? dateOfMute;
  String? muteReason;

  MutedUsersModel({this.username, this.dateOfMute, this.muteReason});

  MutedUsersModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    dateOfMute = json['dateOfMute'];
    muteReason = json['muteReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['dateOfMute'] = dateOfMute;
    data['muteReason'] = muteReason;
    return data;
  }
}

class ApprovedUsersModel {
  String? username;
  String? avatar;
  String? dateOfApprove;

  ApprovedUsersModel({this.username, this.avatar, this.dateOfApprove});

  ApprovedUsersModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    dateOfApprove = json['dateOfApprove'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['avatar'] = avatar;
    data['dateOfApprove'] = dateOfApprove;
    return data;
  }
}

class ModeratorsModel {
  String? username;
  String? avatar;
  String? dateOfModeration;
  List<String>? permissions;

  ModeratorsModel(
      {this.username, this.avatar, this.dateOfModeration, this.permissions});

  ModeratorsModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    dateOfModeration = json['dateOfModeration'];
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['avatar'] = avatar;
    data['dateOfModeration'] = dateOfModeration;
    data['permissions'] = permissions;
    return data;
  }
}

class MutedZeft {
  String? before;
  String? after;
  List<Children>? children;

  MutedZeft({this.before, this.after, this.children});

  MutedZeft.fromJson(Map<String, dynamic> json) {
    before = json['before'];
    after = json['after'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['before'] = this.before;
    data['after'] = this.after;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? username;
  String? avatar;
  String? dateOfMute;
  String? muteReason;

  Children({this.username, this.avatar, this.dateOfMute, this.muteReason});

  Children.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    dateOfMute = json['dateOfMute'];
    muteReason = json['muteReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['dateOfMute'] = this.dateOfMute;
    data['muteReason'] = this.muteReason;
    return data;
  }
}
