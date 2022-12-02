/// date: 8/11/2022
/// @Author: Ahmed Atta

class Flair {
  String? flairId;
  String? flairText;
  String? backgroundColor;
  String? textColor;

  Flair({
    this.flairId,
    this.flairText,
    this.backgroundColor,
    this.textColor,
  });

  factory Flair.fromJson(Map<String, dynamic> json) => Flair(
        flairId: json['flairId'] as String?,
        flairText: json['flairText'] as String?,
        backgroundColor: json['backgroundColor'] as String?,
        textColor: json['textColor'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'flairId': flairId,
        'flairText': flairText,
        'backgroundColor': backgroundColor,
        'textColor': textColor,
      };
}
