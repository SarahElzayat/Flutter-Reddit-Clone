/// @author Sarah Elzayat
/// @description user's model in search results

class SearchResultProfileModel {
  String? id;
  Data? data;

  SearchResultProfileModel({this.id, this.data});

  SearchResultProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? id;
  String? username;
  int? karma;
  bool? nsfw;
  String? joinDate;
  bool? following;
  String? avatar;

  Data(
      {this.id,
      this.username,
      this.karma,
      this.nsfw,
      this.joinDate,
      this.following,
      this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    karma = json['karma'];
    nsfw = json['nsfw'];
    joinDate = json['joinDate'];
    following = json['following'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['karma'] = karma;
    data['nsfw'] = nsfw;
    data['joinDate'] = joinDate;
    data['following'] = following;
    data['avatar'] = avatar;
    return data;
  }
}
