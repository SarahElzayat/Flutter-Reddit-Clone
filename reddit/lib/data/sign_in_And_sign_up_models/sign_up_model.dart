class SignUpModel {
  String? email;
  String? username;
  String? password;

  SignUpModel({this.email, this.username, this.password});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
