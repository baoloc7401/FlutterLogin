import 'package:json_annotation/json_annotation.dart';
part 'activity_json.g.dart';

@JsonSerializable()
class Activity_Json {
  Activity_Json(
    this.activityId,
    this.activityTypes,
    this.activityDescription,
    this.createdAt,
  );
  String activityId;
  String activityTypes;
  String activityDescription;
  String createdAt;
  factory Activity_Json.fromJson(Map<String, dynamic> json) =>
      _$Activity_JsonFromJson(json);
  Map<String, dynamic> toJson() => _$Activity_JsonToJson(this);
}
