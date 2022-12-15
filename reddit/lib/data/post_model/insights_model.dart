class InsightsModel {
  int? totalViews;
  int? upvoteRate;
  int? communityKarma;
  int? totalShares;

  InsightsModel({
    this.totalViews,
    this.upvoteRate,
    this.communityKarma,
    this.totalShares,
  });

  factory InsightsModel.fromJson(Map<String, dynamic> json) => InsightsModel(
        totalViews: json['totalViews'] as int?,
        upvoteRate: json['upvoteRate'] as int?,
        communityKarma: json['communityKarma'] as int?,
        totalShares: json['totalShares'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'totalViews': totalViews,
        'upvoteRate': upvoteRate,
        'communityKarma': communityKarma,
        'totalShares': totalShares,
      };
}
