// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login_Info_Json _$Login_Info_JsonFromJson(Map<String, dynamic> json) =>
    Login_Info_Json(
      json['token'] as String,
      json['token_type'] as String,
      json['expires_in'] as int?,
      User_Json.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Login_Info_JsonToJson(Login_Info_Json instance) =>
    <String, dynamic>{
      'token': instance.token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'user': instance.user.toJson(),
    };
