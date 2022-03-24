// ignore_for_file: non_constant_identifier_names

class LoginConfig {
  String token;
  String token_type;
  int? expires_in;
  User user;
  LoginConfig({
    required this.token,
    required this.token_type,
    required this.expires_in,
    required this.user,
  });

  factory LoginConfig.fromJson(dynamic json) {
    return LoginConfig(
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

class User {
  String userId;
  String vfaJoinedDate;
  String vfaEmail;
  User({
    required this.userId,
    required this.vfaJoinedDate,
    required this.vfaEmail,
  });
  factory User.fromJson(dynamic json) {
    return User(
      userId: json['userId'],
      vfaJoinedDate: json['vfaJoinedDate'],
      vfaEmail: json['vfaEmail'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['vfaJoinedDate'] = vfaJoinedDate;
    data['vfaEmail'] = vfaEmail;
    return data;
  }
}
