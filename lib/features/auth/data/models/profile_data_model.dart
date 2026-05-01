import '../../../../core/models/account_info.dart';

class ProfileData {
  final int? id;
  final AccountInfo? accountInfo;
  final int? total_orders;

  ProfileData({
    required this.id,
    required this.accountInfo,
    required this.total_orders,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      accountInfo:
          json['user'] != null ? AccountInfo.fromJson(json['user']) : null,
      total_orders: json['total_orders'] ?? 0,
    );
  }
}
