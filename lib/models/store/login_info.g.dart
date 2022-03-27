// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login_Info _$Login_InfoFromJson(Map<String, dynamic> json) => Login_Info(
      json['token'] as String,
      json['token_type'] as String,
      json['expires_in'] as int?,
      User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Login_InfoToJson(Login_Info instance) =>
    <String, dynamic>{
      'token': instance.token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'user': instance.user.toJson(),
    };
