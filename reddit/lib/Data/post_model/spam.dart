class Spam {
  String? spammedBy;
  String? spammedDate;

  Spam({this.spammedBy, this.spammedDate});

  factory Spam.fromJson(Map<String, dynamic> json) => Spam(
        spammedBy: json['spammedBy'] as String?,
        spammedDate: json['spammedDate'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'spammedBy': spammedBy,
        'spammedDate': spammedDate,
      };
}
