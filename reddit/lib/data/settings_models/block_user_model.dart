class BlockModel {
  bool? block;
  String? username;

  BlockModel({this.block, this.username});

  BlockModel.fromJson(Map<String, dynamic> json) {
    block = json['block'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'block': block, 'username': username};
    return data;
  }
}
