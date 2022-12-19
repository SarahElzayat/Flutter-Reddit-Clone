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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['subreddit'] = this.subreddit;
    data['banPeriod'] = this.banPeriod;
    data['reasonForBan'] = this.reasonForBan;
    data['modNote'] = this.modNote;
    data['noteInclude'] = this.noteInclude;
    return data;
  }
}
