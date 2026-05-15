import '../../../../core/utilities/string_extensions.dart';

class AccountInfo {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? profilePicUrl;
  final String? address_longitude;
  final String? address_latitude;
  final bool? isActive;
  final String? userType;

  AccountInfo({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.profilePicUrl,
    this.address_longitude,
    this.address_latitude,
    this.userType,
    this.isActive,
  });

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    String? rawUrl = json['profile_picture'] as String?;

    return AccountInfo(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone_number'] as String?,

      profilePicUrl: rawUrl.toCleanImageUrl(),

      address_longitude: json['address_longitude'] as String?,
      address_latitude: json['address_latitude'] as String?,
      userType: json['user_type'] as String?,
      isActive: json['is_active'] as bool?,
    );
  }
}
