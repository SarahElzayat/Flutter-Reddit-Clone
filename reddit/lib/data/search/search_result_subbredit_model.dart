///@author Sarah Elzayat
///@description sybreddit's model in search results

class SearchResultSubredditModel {
  String? id;
  Data? data;

  SearchResultSubredditModel({this.id, this.data});

  SearchResultSubredditModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? subredditName;
  int? numberOfMembers;
  bool? nsfw;
  bool? joined;
  String? profilePicture;
  String? description;

  Data(
      {this.id,
      this.subredditName,
      this.numberOfMembers,
      this.nsfw,
      this.joined,
      this.profilePicture,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subredditName = json['subredditName'];
    numberOfMembers = json['numberOfMembers'];
    nsfw = json['nsfw'];
    joined = json['joined'];
    profilePicture = json['profilePicture'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subredditName'] = subredditName;
    data['numberOfMembers'] = numberOfMembers;
    data['nsfw'] = nsfw;
    data['joined'] = joined;
    data['profilePicture'] = profilePicture;
    data['description'] = description;

    return data;
  }
}
