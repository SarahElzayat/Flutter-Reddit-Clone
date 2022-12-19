class PinPostModel {
  String? id;
  bool? pin;

  PinPostModel({this.id, this.pin});

  PinPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pin'] = this.pin;
    return data;
  }
}
