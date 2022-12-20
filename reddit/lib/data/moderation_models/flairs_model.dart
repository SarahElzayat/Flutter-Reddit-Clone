class PostFlairModel {
  String? flairId;
  String? flairName;
  int? flairOrder;
  String? backgroundColor;
  String? textColor;
  FlairSettingModel? settings;

  PostFlairModel(
      {this.flairId,
      this.flairName,
      this.flairOrder,
      this.backgroundColor,
      this.textColor,
      this.settings});

  PostFlairModel.fromJson(Map<String, dynamic> json) {
    flairId = json['flairId'];
    flairName = json['flairName'];
    flairOrder = json['flairOrder'];
    backgroundColor = json['backgroundColor'];
    textColor = json['textColor'];
    settings = json['settings'] != null
        ? FlairSettingModel.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flairId'] = flairId;
    data['flairName'] = flairName;
    data['flairOrder'] = flairOrder;
    data['backgroundColor'] = backgroundColor;
    data['textColor'] = textColor;
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    return data;
  }
}

class FlairSettingModel {
  bool? modOnly;
  bool? allowUserEdits;
  String? flairType;
  int? emojisLimit;

  FlairSettingModel(
      {this.modOnly, this.allowUserEdits, this.flairType, this.emojisLimit});

  FlairSettingModel.fromJson(Map<String, dynamic> json) {
    modOnly = json['modOnly'];
    allowUserEdits = json['allowUserEdits'];
    flairType = json['flairType'];
    emojisLimit = json['emojisLimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modOnly'] = modOnly;
    data['allowUserEdits'] = allowUserEdits;
    data['flairType'] = flairType;
    data['emojisLimit'] = emojisLimit;
    return data;
  }
}

class PostFlairSettingsModel {
  bool? enablePostFlairs;
  bool? allowUsers;

  PostFlairSettingsModel({this.enablePostFlairs, this.allowUsers});

  PostFlairSettingsModel.fromJson(Map<String, dynamic> json) {
    enablePostFlairs = json['enablePostFlairs'];
    allowUsers = json['allowUsers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enablePostFlairs'] = enablePostFlairs;
    data['allowUsers'] = allowUsers;
    return data;
  }
}
