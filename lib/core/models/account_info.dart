import '../utilities/api_constants.dart';

class AccountInfo {
  final int? id;
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
    this.id,
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

  String? get fullProfilePicUrl {
    if (profilePicUrl == null) return null;
    return "${ApiConstants.baseUrl}$profilePicUrl";
  }

  factory AccountInfo.fromJson(Map<String, dynamic> json) {
    return AccountInfo(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone_number'] as String?,
      profilePicUrl: json['profile_picture'] as String?,
      address_longitude: json['address_longitude'] as String?,
      address_latitude: json['address_latitude'] as String?,
      userType: json['user_type'] as String?,
      isActive: json['is_active'] as bool?,
    );
  }
}
