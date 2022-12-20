class SocialLink {
  String? type;
  String? displayText;
  String? link;

  SocialLink({this.type, this.displayText, this.link});

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        type: json['type'] as String?,
        displayText: json['displayText'] as String?,
        link: json['link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'displayText': displayText,
        'link': link,
      };
}
