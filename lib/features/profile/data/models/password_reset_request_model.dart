class PasswordResetRequestModel {
  final String? uId;
  final String? token;
  PasswordResetRequestModel({this.uId, this.token});

  factory PasswordResetRequestModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetRequestModel(
      uId: json['uid'] != null ? json['uid'] as String : null,
      token: json['token'] != null ? json['token'] as String : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'token': token,
    };
  }
}
