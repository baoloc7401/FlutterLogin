// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User_Json _$User_JsonFromJson(Map<String, dynamic> json) => User_Json(
      json['userId'] as String,
      json['vfaJoinedDate'] as String,
      json['vfaEmail'] as String,
      json['userFullName'] as String,
    );

Map<String, dynamic> _$User_JsonToJson(User_Json instance) => <String, dynamic>{
      'userId': instance.userId,
      'vfaJoinedDate': instance.vfaJoinedDate,
      'vfaEmail': instance.vfaEmail,
      'userFullName': instance.userFullName,
    };
