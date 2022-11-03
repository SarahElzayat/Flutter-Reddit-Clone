/// @author Abdelaziz Salah
/// @date 3/11/2022
/// this is a model for the Sign up attributes which are sent to the backend
/// instead of each time creating the strings and we may forget something.

class SignUpModel {
  String? email;
  String? username;
  String? password;

  SignUpModel({this.email, this.username, this.password});

  /// this named constructor takes a map in form of json file and set the values
  /// depending on its content.
  SignUpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }

  /// this function convert the data members into json formate
  /// it returns [Map] of string and dynamic object depending on its value.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
