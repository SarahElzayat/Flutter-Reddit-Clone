import 'rule.dart';

class Rules {
  List<Rule>? rules;

  Rules({this.rules});

  factory Rules.fromJson(Map<String, dynamic> json) => Rules(
        rules: (json['rules'] as List<dynamic>?)
            ?.map((e) => Rule.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'rules': rules?.map((e) => e.toJson()).toList(),
      };
}
