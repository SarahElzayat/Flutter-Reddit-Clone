class ChangeGenderModel {
  String? gender;

  ChangeGenderModel({this.gender});

  ChangeGenderModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'gender': gender};
    return data;
  }
}
