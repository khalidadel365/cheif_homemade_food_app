class PasswordConfirmModel {
  final String? detail;

  PasswordConfirmModel(this.detail);
  factory PasswordConfirmModel.fromJson(Map<String, dynamic> json) {
    return PasswordConfirmModel(
      json['detail'] != null ? json['detail'] as String : null,
    );
  }
}
