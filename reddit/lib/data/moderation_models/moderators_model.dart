///@author: YasmineGhanem
///@date: 12/12/2020
class Moderator {
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

  Moderator(
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

  Moderator.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
