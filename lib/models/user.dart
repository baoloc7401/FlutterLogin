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
