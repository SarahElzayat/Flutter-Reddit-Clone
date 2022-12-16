///@author Sarah Elzayat
///@description left drawer's community model
class DrawerCommunitiesModel {
  String? title;
  String? picture;
  int? members;

  DrawerCommunitiesModel({this.title, this.picture, this.members});

  DrawerCommunitiesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    picture = json['picture'];
    members = json['members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['picture'] = picture;
    data['members'] = members;
    return data;
  }
}
