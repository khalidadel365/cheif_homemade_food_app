import 'package:cheif_homemade_food/features/profile/data/models/logout_model.dart';

import '../../../../core/models/profile_model.dart';
import '../../../auth/data/models/account_info.dart';
import '../../data/models/password_confirm_model.dart';
import '../../data/models/password_reset_request_model.dart';
import '../../data/models/toggle_chef_online_status_model.dart';

class ProfileStates {}

class GetProfileInitialState extends ProfileStates {}

class GetProfileLoadingState extends ProfileStates {}

class GetProfileFailureState extends ProfileStates {
  final String errMessage;
  GetProfileFailureState(this.errMessage);
}

class GetProfileSuccessState extends ProfileStates {
  ProfileModel profileModel;
  GetProfileSuccessState(this.profileModel);
}

class ToggleChefStatusLoadingState extends ProfileStates {}

class ToggleChefStatusFailureState extends ProfileStates {
  final String errMessage;
  ToggleChefStatusFailureState(this.errMessage);
}

class ToggleChefStatusSuccessState extends ProfileStates {
  final ToggleChefOnlineStatusModel toggleModel;
  ToggleChefStatusSuccessState(this.toggleModel);
}

class EditProfileLoading extends ProfileStates {}

class EditProfileFailure extends ProfileStates {
  final String errMessage;
  EditProfileFailure(this.errMessage);
}

class EditProfileSuccess extends ProfileStates {
  ProfileModel profileModel;
  EditProfileSuccess(this.profileModel);
}

class UpdateProfileImageLoading extends ProfileStates {}

class UpdateProfileImageFailure extends ProfileStates {
  final String errMessage;
  UpdateProfileImageFailure(this.errMessage);
}

class UpdateProfileImageSuccess extends ProfileStates {
  AccountInfo accountInfo;
  UpdateProfileImageSuccess(this.accountInfo);
}

class LogoutLoadingState extends ProfileStates {}

class LogoutFailureState extends ProfileStates {
  final String errMessage;
  LogoutFailureState(this.errMessage);
}

class LogoutSuccessState extends ProfileStates {
  final LogoutModel logoutModel;
  LogoutSuccessState(this.logoutModel);
}

class ResetPasswordRequestLoading extends ProfileStates {}

class ResetPasswordRequestFailure extends ProfileStates {
  final String errMessage;
  ResetPasswordRequestFailure(this.errMessage);
}

class ResetPasswordRequestSuccess extends ProfileStates {
  PasswordResetRequestModel resetRequest;
  ResetPasswordRequestSuccess(this.resetRequest);
}

class ResetPasswordConfirmLoading extends ProfileStates {}

class ResetPasswordConfirmFailure extends ProfileStates {
  final String errMessage;
  ResetPasswordConfirmFailure(this.errMessage);
}

class ResetPasswordConfirmSuccess extends ProfileStates {
  PasswordConfirmModel confirmPassword;
  ResetPasswordConfirmSuccess(this.confirmPassword);
}
