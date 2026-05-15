import '../../../../core/models/profile_model.dart';

class ToggleChefOnlineStatusModel {
  final String? detail;
  final bool? isOnlineStatus;
  final ProfileModel? profileModel;

  ToggleChefOnlineStatusModel({
    this.detail,
    this.isOnlineStatus,
    this.profileModel,
  });

  factory ToggleChefOnlineStatusModel.fromJson(Map<String, dynamic> json) {
    return ToggleChefOnlineStatusModel(
      detail: json['detail'] as String?,
      isOnlineStatus: json['is_online'] as bool?,
      profileModel:
          json['chef'] != null ? ProfileModel.fromJson(json['chef']) : null,
    );
  }
}
