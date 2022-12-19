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
  String? id;
  BannedUser? data;

  Children({this.id, this.data});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? new BannedUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['userPhoto'] = this.userPhoto;
    data['bannedAt'] = this.bannedAt;
    data['banPeriod'] = this.banPeriod;
    data['modNote'] = this.modNote;
    data['noteInclude'] = this.noteInclude;
    data['reasonForBan'] = this.reasonForBan;
    return data;
  }
}
