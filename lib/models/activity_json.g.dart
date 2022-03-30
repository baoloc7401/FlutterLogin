// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity_Json _$Activity_JsonFromJson(Map<String, dynamic> json) =>
    Activity_Json(
      json['activityId'] as String,
      json['activityTypes'] as String,
      json['activityDescription'] as String,
      json['createdAt'] as String,
    );

Map<String, dynamic> _$Activity_JsonToJson(Activity_Json instance) =>
    <String, dynamic>{
      'activityId': instance.activityId,
      'activityTypes': instance.activityTypes,
      'activityDescription': instance.activityDescription,
      'createdAt': instance.createdAt,
    };
