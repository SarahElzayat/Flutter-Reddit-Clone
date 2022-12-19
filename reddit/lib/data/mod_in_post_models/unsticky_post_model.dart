class PinPostModel {
  String? id;
  bool? pin;

  PinPostModel({this.id, this.pin});

  PinPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pin'] = pin;
    return data;
  }
}
