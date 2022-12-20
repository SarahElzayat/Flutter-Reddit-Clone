class ModeratorOf {
  String? subredditId;
  String? subredditName;
  int? numOfMembers;
  bool? nsfw;
  bool? followed;

  ModeratorOf({
    this.subredditId,
    this.subredditName,
    this.numOfMembers,
    this.nsfw,
    this.followed,
  });

  factory ModeratorOf.fromJson(Map<String, dynamic> json) => ModeratorOf(
        subredditId: json['subredditId'] as String?,
        subredditName: json['subredditName'] as String?,
        numOfMembers: json['numOfMembers'] as int?,
        nsfw: json['nsfw'] as bool?,
        followed: json['followed'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'subredditId': subredditId,
        'subredditName': subredditName,
        'numOfMembers': numOfMembers,
        'nsfw': nsfw,
        'followed': followed,
      };
}
