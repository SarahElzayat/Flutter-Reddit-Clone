class Image {
  String? path;
  String? caption;
  String? link;

  Image({this.path, this.caption, this.link});

  factory Image.fromJson(Map<String, dynamic>? json) => Image(
        path: json?['path'] as String?,
        caption: json?['caption'] as String?,
        link: json?['link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'path': path,
        'caption': caption,
        'link': link,
      };
}
