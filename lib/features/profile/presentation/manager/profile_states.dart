import '../../../../core/models/profile_model.dart';
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

