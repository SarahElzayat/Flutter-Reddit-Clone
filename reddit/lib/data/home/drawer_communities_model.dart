///@author Sarah Elzayat
///@description left drawer's community model
class DrawerCommunitiesModel {
  String? title;
  String? picture;
  int? members;
  bool? isFavorite;

  DrawerCommunitiesModel({this.title, this.picture, this.members,this.isFavorite});

  DrawerCommunitiesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    picture = json['picture'];
    members = json['members'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['picture'] = picture;
    data['members'] = members;
    data['isFavorite'] = isFavorite;
    return data;
  }
}
