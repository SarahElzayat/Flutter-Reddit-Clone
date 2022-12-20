class MarkSpoilerModel {
  String? id;

  MarkSpoilerModel({this.id});

  MarkSpoilerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
