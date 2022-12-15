class LogInForgetModel {
  // the type here represent whethere he forgot password or username
  String? type;
  String? username;
  String? email;

  LogInForgetModel({this.type, this.username, this.email});

  LogInForgetModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
