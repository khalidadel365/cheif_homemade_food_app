class LogoutModel {
  final String detail;

  LogoutModel({required this.detail});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(detail: json['detail'] as String);
  }
}
