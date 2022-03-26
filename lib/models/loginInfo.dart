// ignore_for_file: non_constant_identifier_names
import 'package:loginflutter/models/user.dart';

class LoginInfo {
  String token;
  String token_type;
  int? expires_in;
  User user;
  LoginInfo({
    required this.token,
    required this.token_type,
    required this.expires_in,
    required this.user,
  });

  factory LoginInfo.fromJson(dynamic json) {
    return LoginInfo(
      token: json['token'],
      token_type: json['token_type'],
      expires_in: json['expires_in'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['token_type'] = token_type;
    data['expires_in'] = expires_in;
    data['user']['userId'] = user.userId;
    data['user']['vfaJoinedDate'] = user.vfaJoinedDate;
    data['user']['vfaEmail'] = user.vfaEmail;
    return data;
  }
}
