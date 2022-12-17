class CommunitySettingsModel {
  String? communityName;
  String? mainTopic;
  List<String>? subTopics;
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
      this.mainTopic,
      this.subTopics,
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
    mainTopic = json['mainTopic'];
    subTopics = json['subTopics'].cast<String>();
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
    data['mainTopic'] = mainTopic;
    data['subTopics'] = subTopics;
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

class ModPostSettingsModel {
  bool? enableSpoiler;
  bool? allowImagesInComment;
  String? suggestedSort;

  ModPostSettingsModel(
      {this.enableSpoiler, this.allowImagesInComment, this.suggestedSort});

  ModPostSettingsModel.fromJson(Map<String, dynamic> json) {
    enableSpoiler = json['enableSpoiler'];
    allowImagesInComment = json['allowImagesInComment'];
    suggestedSort = json['suggestedSort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enableSpoiler'] = enableSpoiler;
    data['allowImagesInComment'] = allowImagesInComment;
    data['suggestedSort'] = suggestedSort;
    return data;
  }
}
