class BanUserModel {
  String? userId;
  String? subreddit;
  int? banPeriod;
  String? reasonForBan;
  String? modNote;
  String? noteInclude;

  BanUserModel(
      {this.userId,
      this.subreddit,
      this.banPeriod,
      this.reasonForBan,
      this.modNote,
      this.noteInclude});

  BanUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    subreddit = json['subreddit'];
    banPeriod = json['banPeriod'];
    reasonForBan = json['reasonForBan'];
    modNote = json['modNote'];
    noteInclude = json['noteInclude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['subreddit'] = subreddit;
    data['banPeriod'] = banPeriod;
    data['reasonForBan'] = reasonForBan;
    data['modNote'] = modNote;
    data['noteInclude'] = noteInclude;
    return data;
  }
}
