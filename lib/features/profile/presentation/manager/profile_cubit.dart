import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/profile_model.dart';
import '../../../../core/utilities/api_constants.dart';
import '../../../../core/utilities/cache_helper.dart';
import '../../data/repos/profile_repo.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.profileRepo) : super(GetProfileInitialState());

  final ProfileRepo profileRepo;

  ProfileModel? profileModel;

  Future<void> getChefProfile({required String token, required int id}) async {
    emit(GetProfileLoadingState());
    var result = await profileRepo.getChefProfile(
      token: token,
      id: id,
    );
    result.fold((failure) {
      emit(GetProfileFailureState(failure.errorMessage));
    }, (profile) {
      profileModel = profile;
      emit(GetProfileSuccessState(profile));
    });
  }

  Future<void> toggleChefStatus({required String token}) async {
    if (state is GetProfileLoadingState) return;

    emit(ToggleChefStatusLoadingState());

    var result = await profileRepo.toggleChefStatus(token: token);

    result.fold(
          (failure) {
        emit(ToggleChefStatusFailureState(failure.errorMessage));
        if (profileModel != null) {
          emit(GetProfileSuccessState(profileModel!));
        }
      },
          (toggleModel) {
        profileModel = toggleModel.profileModel;
        emit(GetProfileSuccessState(profileModel!));
        emit(ToggleChefStatusSuccessState(toggleModel));
      },
    );
  }
  Future<void> logout({required String token}) async {
    emit(LogoutLoadingState());
    var result = await profileRepo.logout(token: token);

    result.fold(
          (failure) => emit(LogoutFailureState(failure.errorMessage)),
          (logoutModel) async {
            await CacheHelper.removeData(key: 'token');
        ApiConstants.token = null;
        emit(LogoutSuccessState(logoutModel));
      },
    );
  }
}