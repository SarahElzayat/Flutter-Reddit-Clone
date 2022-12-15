class Banned {
  String? before;
  String? after;
  List<Children>? children;

  Banned({this.before, this.after, this.children});

  Banned.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['before'] = before;
    data['after'] = after;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? id;
  BannedUser? data;

  Children({this.id, this.data});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? new BannedUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BannedUser {
  String? username;
  String? userPhoto;
  String? bannedAt;
  int? banPeriod;
  String? modNote;
  String? noteInclude;
  String? reasonForBan;

  BannedUser(
      {this.username,
      this.userPhoto,
      this.bannedAt,
      this.banPeriod,
      this.modNote,
      this.noteInclude,
      this.reasonForBan});

  BannedUser.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userPhoto = json['userPhoto'];
    bannedAt = json['bannedAt'];
    banPeriod = json['banPeriod'];
    modNote = json['modNote'];
    noteInclude = json['noteInclude'];
    reasonForBan = json['reasonForBan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['userPhoto'] = userPhoto;
    data['bannedAt'] = bannedAt;
    data['banPeriod'] = banPeriod;
    data['modNote'] = modNote;
    data['noteInclude'] = noteInclude;
    data['reasonForBan'] = reasonForBan;
    return data;
  }
}
