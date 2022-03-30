import 'package:json_annotation/json_annotation.dart';
part 'user_json.g.dart';

@JsonSerializable()
class User_Json {
  User_Json(this.userId, this.vfaJoinedDate, this.vfaEmail, this.userFullName);
  String userId;
  String vfaJoinedDate;
  String vfaEmail;
  String userFullName;
  factory User_Json.fromJson(Map<String, dynamic> json) =>
      _$User_JsonFromJson(json);
  Map<String, dynamic> toJson() => _$User_JsonToJson(this);
}
