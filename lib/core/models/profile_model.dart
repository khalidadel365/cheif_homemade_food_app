import 'user_data.dart';

class ProfileModel {
  final int? id;
  final UserData? userData;
  final int? totalOrders;
  final double? rating;
  final int? totalReviews;
  final String? bio;
  final String? cuisineSpecialties;
  final int? yearsOfExperience;
  final bool? isVerified;
  final bool? isOnline;
  final String? createdAt;
  final String? updatedAt;

  ProfileModel({
    this.id,
    this.userData,
    this.totalOrders,
    this.rating,
    this.totalReviews,
    this.bio,
    this.cuisineSpecialties,
    this.yearsOfExperience,
    this.isVerified,
    this.isOnline,
    this.createdAt,
    this.updatedAt,
  });

  ProfileModel copyWith({
    bool? isOnline,
  }) {
    return ProfileModel(
      id: id,
      userData: userData,
      totalOrders: totalOrders,
      rating: rating,
      totalReviews: totalReviews,
      bio: bio,
      cuisineSpecialties: cuisineSpecialties,
      yearsOfExperience: yearsOfExperience,
      isVerified: isVerified,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as int?,
      userData: json['user'] != null ? UserData.fromJson(json['user']) : null,
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
      totalReviews: json['total_reviews'] as int?,
      totalOrders: json['total_orders'] as int?,
      bio: json['bio'] as String?,
      cuisineSpecialties: json['cuisine_specialties'] as String?,
      yearsOfExperience: json['years_of_experience'] as int?,
      isVerified: json['is_verified'] as bool?,
      isOnline: json['is_online'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
