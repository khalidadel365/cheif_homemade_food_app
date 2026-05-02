import '../../../../core/models/profile_model.dart';

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

