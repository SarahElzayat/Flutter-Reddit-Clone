class Rule {
  String? ruleId;
  String? ruleName;
  int? ruleOrder;
  String? createdAt;
  String? appliesTo;
  String? reportReason;
  String? description;

  Rule({
    this.ruleId,
    this.ruleName,
    this.ruleOrder,
    this.createdAt,
    this.appliesTo,
    this.reportReason,
    this.description,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
        ruleId: json['ruleID'] as String?,
        ruleName: json['ruleName'] as String?,
        ruleOrder: json['ruleOrder'] as int?,
        createdAt: json['createdAt'] as String?,
        appliesTo: json['appliesTo'] as String?,
        reportReason: json['reportReason'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ruleID': ruleId,
        'ruleName': ruleName,
        'ruleOrder': ruleOrder,
        'createdAt': createdAt,
        'appliesTo': appliesTo,
        'reportReason': reportReason,
        'description': description,
      };
}
