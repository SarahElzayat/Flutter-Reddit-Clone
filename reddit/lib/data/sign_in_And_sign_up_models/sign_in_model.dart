/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a model for the logIn attributes which are sent to the backend
/// instead of each time creating the strings and we may forget something

class LogInModel {
  String? username;
  String? password;

  LogInModel({this.username, this.password});

  LogInModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
