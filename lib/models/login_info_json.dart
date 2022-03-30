import 'package:loginflutter/models/user_json.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_info_json.g.dart';

@JsonSerializable(explicitToJson: true)
class Login_Info_Json {
  Login_Info_Json(this.token, this.token_type, this.expires_in, this.user);
  String token;
  String token_type;
  int? expires_in;
  User_Json user;
  factory Login_Info_Json.fromJson(Map<String, dynamic> json) =>
      _$Login_Info_JsonFromJson(json);
  Map<String, dynamic> toJson() => _$Login_Info_JsonToJson(this);
}
