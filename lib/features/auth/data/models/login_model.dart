import 'package:cheif_homemade_food/features/auth/data/models/profile_data_model.dart';

class LoginModel {
  final String? token;
  final ProfileData? profileData;

  LoginModel({this.token, this.profileData});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      profileData:
          json['profile'] != null
              ? ProfileData.fromJson(json['profile'])
              : null,
    );
  }
}
