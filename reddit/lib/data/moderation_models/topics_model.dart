//no need
class SuggestedTopics {
  List<CommunityTopics>? communityTopics;

  SuggestedTopics({this.communityTopics});

  SuggestedTopics.fromJson(Map<String, dynamic> json) {
    if (json['communityTopics'] != null) {
      communityTopics = <CommunityTopics>[];
      json['communityTopics'].forEach((v) {
        communityTopics!.add(CommunityTopics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (communityTopics != null) {
      data['communityTopics'] =
          communityTopics!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicName'] = topicName;
    return data;
  }
}
