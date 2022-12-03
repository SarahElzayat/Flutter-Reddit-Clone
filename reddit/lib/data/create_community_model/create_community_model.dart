class CreateCommunityModel {
  String? subredditName;
  String? type;
  bool? nsfw;
  String? category;

  CreateCommunityModel(
      {this.subredditName, this.type, this.nsfw, this.category});

  CreateCommunityModel.fromJson(Map<String, dynamic> json) {
    subredditName = json['subredditName'];
    type = json['type'];
    nsfw = json['nsfw'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subredditName'] = this.subredditName;
    data['type'] = this.type;
    data['nsfw'] = this.nsfw;
    data['category'] = this.category;
    return data;
  }
}
