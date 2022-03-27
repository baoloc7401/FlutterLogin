import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User(
    this.userId,
    this.vfaJoinedDate,
    this.vfaEmail,
  );
  String userId;
  String vfaJoinedDate;
  String vfaEmail;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
