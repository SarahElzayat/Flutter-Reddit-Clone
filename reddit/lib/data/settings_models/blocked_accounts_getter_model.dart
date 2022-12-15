class BlockedAccountsGetterModel {
  String? before;
  String? after;
  List<Children>? children;

  BlockedAccountsGetterModel({this.before, this.after, this.children});

  BlockedAccountsGetterModel.fromJson(Map<String, dynamic> json) {
    before = json['before'];
    after = json['after'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
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
  Data? data;

  Children({this.id, this.data});

  Children.fromJson(Map<String, dynamic> json) {
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
  String? username;
  String? userImage;
  String? blockDate;

  Data({this.username, this.userImage, this.blockDate});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    userImage = json['userImage'];
    blockDate = json['blockDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['userImage'] = userImage;
    data['blockDate'] = blockDate;
    return data;
  }
}
