import 'flair.dart';
import 'hybrid_content.dart';
import 'image.dart';
import 'moderation.dart';

class PostModel {
  String? id;
  String? kind;
  String? subreddit;
  String? content;
  List<Image>? images;
  bool? nsfw;
  bool? spoiler;
  String? title;
  String? sharePostId;
  Flair? flair;
  int? comments;
  int? votes;
  String? postedAt;
  String? deletedAt;
  String? editedAt;
  String? postedBy;
  int? votingType;
  bool? saved;
  bool? followed;
  bool? hidden;
  bool? spammed;
  bool? inYourSubreddit;
  Moderation? moderation;
  String? link;
  String? video;
  List<HybridContent>? hybridContent;
  bool? sendReplies;
  bool? markedSpam;
  String? suggestedSort;

  PostModel({
    this.id,
    this.kind,
    this.subreddit,
    this.content,
    this.images,
    this.nsfw,
    this.spoiler,
    this.title,
    this.sharePostId,
    this.flair,
    this.comments,
    this.votes,
    this.postedAt,
    this.deletedAt,
    this.editedAt,
    this.postedBy,
    this.votingType,
    this.saved,
    this.followed,
    this.hidden,
    this.spammed,
    this.inYourSubreddit,
    this.moderation,
    this.link,
    this.video,
    this.hybridContent,
    this.sendReplies,
    this.markedSpam,
    this.suggestedSort,
  });

  factory PostModel.fromJsonwithData(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      kind: json['data']['kind'] as String?,
      title: json['data']['title'] as String?,
      subreddit: json['data']['subreddit'] as String?,
      link: json['data']['link'] as String?,
      images: (json['data']['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      video: json['data']['video'] as String?,
      hybridContent: (json['data']['hybridContent'] as List<dynamic>?)
          ?.map((e) => HybridContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      nsfw: json['data']['nsfw'] as bool?,
      spoiler: json['data']['spoiler'] as bool?,
      sharePostId: json['data']['sharePostId'] as String?,
      flair: json['data']['flair'] == null
          ? null
          : Flair.fromJson(json['data']['flair'] as Map<String, dynamic>),
      comments: json['data']['comments'] as int?,
      votes: json['data']['votes'] as int?,
      postedAt: json['data']['postedAt'] as String?,
      sendReplies: json['data']['sendReplies'] as bool?,
      markedSpam: json['data']['markedSpam'] as bool?,
      suggestedSort: json['data']['suggestedSort'] as String?,
      editedAt: json['data']['editedAt'] as String?,
      postedBy: json['data']['postedBy'] as String?,
      votingType: json['data']['votingType'] as int?,
      saved: json['data']['saved'] as bool?,
      followed: json['data']['followed'] as bool?,
      hidden: json['data']['hidden'] as bool?,
      spammed: json['data']['spammed'] as bool?,
      inYourSubreddit: json['data']['inYourSubreddit'] as bool?,
      moderation: json['data']['moderation'] == null
          ? null
          : Moderation.fromJson(
              json['data']['moderation'] as Map<String, dynamic>),
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        kind: json['kind'] as String?,
        subreddit: json['subreddit'] as String?,
        content: json['content'] as String?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
            .toList(),
        nsfw: json['nsfw'] as bool?,
        spoiler: json['spoiler'] as bool?,
        title: json['title'] as String?,
        sharePostId: json['sharePostId'] as String?,
        flair: json['flair'] == null
            ? null
            : Flair.fromJson(json['flair'] as Map<String, dynamic>),
        comments: json['comments'] as int?,
        votes: json['votes'] as int?,
        postedAt: json['postedAt'] as String?,
        deletedAt: json['deletedAt'] as String?,
        editedAt: json['editedAt'] as String?,
        postedBy: json['postedBy'] as String?,
        votingType: json['votingType'] as int?,
        saved: json['saved'] as bool?,
        followed: json['followed'] as bool?,
        hidden: json['hidden'] as bool?,
        spammed: json['spammed'] as bool?,
        inYourSubreddit: json['inYourSubreddit'] as bool?,
        moderation: json['moderation'] == null
            ? null
            : Moderation.fromJson(json['moderation'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind,
        'subreddit': subreddit,
        'content': content,
        'images': images?.map((e) => e.toJson()).toList(),
        'nsfw': nsfw,
        'spoiler': spoiler,
        'title': title,
        'sharePostId': sharePostId,
        'flair': flair?.toJson(),
        'comments': comments,
        'votes': votes,
        'postedAt': postedAt,
        'deletedAt': deletedAt,
        'editedAt': editedAt,
        'postedBy': postedBy,
        'votingType': votingType,
        'saved': saved,
        'followed': followed,
        'hidden': hidden,
        'spammed': spammed,
        'inYourSubreddit': inYourSubreddit,
        'moderation': moderation?.toJson(),
      };
  //TODO - add more fields
  PostModel copyWith({
    String? id,
    String? kind,
    String? subreddit,
    String? content,
    List<Image>? images,
    bool? nsfw,
    bool? spoiler,
    String? title,
    String? sharePostId,
    Flair? flair,
    int? comments,
    int? votes,
    String? postedAt,
    String? deletedAt,
    String? editedAt,
    String? postedBy,
    int? votingType,
    bool? saved,
    bool? followed,
    bool? hidden,
    bool? spammed,
    bool? inYourSubreddit,
    Moderation? moderation,
  }) {
    return PostModel(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      subreddit: subreddit ?? this.subreddit,
      content: content ?? this.content,
      images: images ?? this.images,
      nsfw: nsfw ?? this.nsfw,
      spoiler: spoiler ?? this.spoiler,
      title: title ?? this.title,
      sharePostId: sharePostId ?? this.sharePostId,
      flair: flair ?? this.flair,
      comments: comments ?? this.comments,
      votes: votes ?? this.votes,
      postedAt: postedAt ?? this.postedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      editedAt: editedAt ?? this.editedAt,
      postedBy: postedBy ?? this.postedBy,
      votingType: votingType ?? this.votingType,
      saved: saved ?? this.saved,
      followed: followed ?? this.followed,
      hidden: hidden ?? this.hidden,
      spammed: spammed ?? this.spammed,
      inYourSubreddit: inYourSubreddit ?? this.inYourSubreddit,
      moderation: moderation ?? this.moderation,
      suggestedSort: suggestedSort,
      video: video,
      hybridContent: hybridContent,
    );
  }
}
