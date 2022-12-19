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
  int? karma;
  String? username;
  String? avatar;

  Data({this.id, this.karma, this.username, this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    karma = json['karma'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['karma'] = karma;
    data['username'] = username;
    data['avatar'] = avatar;
    return data;
  }
}
