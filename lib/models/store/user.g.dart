// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['userId'] as String,
      json['vfaJoinedDate'] as String,
      json['vfaEmail'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'vfaJoinedDate': instance.vfaJoinedDate,
      'vfaEmail': instance.vfaEmail,
    };
