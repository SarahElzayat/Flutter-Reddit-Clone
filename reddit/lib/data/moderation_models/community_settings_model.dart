class CommunitySettingsModel {
  String? communityName;
  List<CommunityTopics>? communityTopics;
  String? communityDescription;
  bool? sendWelcomeMessage;
  String? welcomeMessage;
  String? language;
  String? region;
  String? type;
  bool? nSFW;
  bool? acceptingRequestsToJoin;
  bool? acceptingRequestsToPost;
  String? approvedUsersHaveTheAbilityTo;

  CommunitySettingsModel(
      {this.communityName,
      this.communityTopics,
      this.communityDescription,
      this.sendWelcomeMessage,
      this.welcomeMessage,
      this.language,
      this.region,
      this.type,
      this.nSFW,
      this.acceptingRequestsToJoin,
      this.acceptingRequestsToPost,
      this.approvedUsersHaveTheAbilityTo});

  CommunitySettingsModel.fromJson(Map<String, dynamic> json) {
    communityName = json['communityName'];
    if (json['communityTopics'] != null) {
      communityTopics = <CommunityTopics>[];
      json['communityTopics'].forEach((v) {
        communityTopics!.add(CommunityTopics.fromJson(v));
      });
    }
    communityDescription = json['communityDescription'];
    sendWelcomeMessage = json['sendWelcomeMessage'];
    welcomeMessage = json['welcomeMessage'];
    language = json['language'];
    region = json['Region'];
    type = json['Type'];
    nSFW = json['NSFW'];
    acceptingRequestsToJoin = json['acceptingRequestsToJoin'];
    acceptingRequestsToPost = json['acceptingRequestsToPost'];
    approvedUsersHaveTheAbilityTo = json['approvedUsersHaveTheAbilityTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['communityName'] = communityName;
    if (communityTopics != null) {
      data['communityTopics'] =
          communityTopics!.map((v) => v.toJson()).toList();
    }
    data['communityDescription'] = communityDescription;
    data['sendWelcomeMessage'] = sendWelcomeMessage;
    data['welcomeMessage'] = welcomeMessage;
    data['language'] = language;
    data['Region'] = region;
    data['Type'] = type;
    data['NSFW'] = nSFW;
    data['acceptingRequestsToJoin'] = acceptingRequestsToJoin;
    data['acceptingRequestsToPost'] = acceptingRequestsToPost;
    data['approvedUsersHaveTheAbilityTo'] = approvedUsersHaveTheAbilityTo;
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
