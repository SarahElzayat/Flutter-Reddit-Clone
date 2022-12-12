//no need
class SuggestedTopics {
  List<CommunityTopics>? communityTopics;

  SuggestedTopics({this.communityTopics});

  SuggestedTopics.fromJson(Map<String, dynamic> json) {
    if (json['communityTopics'] != null) {
      communityTopics = <CommunityTopics>[];
      json['communityTopics'].forEach((v) {
        communityTopics!.add(new CommunityTopics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.communityTopics != null) {
      data['communityTopics'] =
          this.communityTopics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommunityTopics {
  String? topicName;

  CommunityTopics({this.topicName});

  CommunityTopics.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topicName'] = this.topicName;
    return data;
  }
}
