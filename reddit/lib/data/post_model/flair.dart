class Flair {
  String? id;
  String? flairName;
  int? order;
  String? backgroundColor;
  String? textColor;

  Flair({
    this.id,
    this.flairName,
    this.order,
    this.backgroundColor,
    this.textColor,
  });

  factory Flair.fromJson(Map<String, dynamic> json) => Flair(
        id: json['id'] as String?,
        flairName: json['flairName'] as String?,
        order: json['order'] as int?,
        backgroundColor: json['backgroundColor'] as String?,
        textColor: json['textColor'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'flairName': flairName,
        'order': order,
        'backgroundColor': backgroundColor,
        'textColor': textColor,
      };
}
