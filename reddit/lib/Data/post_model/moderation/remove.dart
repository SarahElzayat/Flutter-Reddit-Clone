class Remove {
  String? removedBy;
  String? removedDate;

  Remove({this.removedBy, this.removedDate});

  factory Remove.fromJson(Map<String, dynamic> json) => Remove(
        removedBy: json['removedBy'] as String?,
        removedDate: json['removedDate'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'removedBy': removedBy,
        'removedDate': removedDate,
      };
}
