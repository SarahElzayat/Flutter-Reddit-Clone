import 'post_data.dart';

class PostModel {
  String? id;
  PostData? data;

  PostModel({this.id, this.data});

  @override
  String toString() => 'PostModel(id: $id, data: $data)';

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as String?,
        data: json['data'] == null
            ? null
            : PostData.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'data': data?.toJson(),
      };
}
