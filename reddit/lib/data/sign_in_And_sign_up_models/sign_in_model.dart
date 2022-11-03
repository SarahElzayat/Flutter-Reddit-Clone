class LogInModel {
  String? username;
  String? password;

  LogInModel({this.username, this.password});

  LogInModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
