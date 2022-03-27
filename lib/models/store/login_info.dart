import 'package:loginflutter/store/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_info.g.dart';

@JsonSerializable(explicitToJson: true)
class Login_Info {
  Login_Info(this.token, this.token_type, this.expires_in, this.user);
  String token;
  String token_type;
  int? expires_in;
  User user;
  factory Login_Info.fromJson(Map<String, dynamic> json) =>
      _$Login_InfoFromJson(json);
  Map<String, dynamic> toJson() => _$Login_InfoToJson(this);
}
