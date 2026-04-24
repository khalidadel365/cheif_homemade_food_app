import '../../features/auth/data/models/login_model.dart';

class UserData {
  final int? id;
  final AccountInfo? accountInfo;

  UserData({
    this.id,
    this.accountInfo,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int?,
      accountInfo: AccountInfo.fromJson(json),
    );
  }
}
