import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/profile_repo.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.profileRepo) : super(GetProfileInitialState());

  final ProfileRepo profileRepo;

  Future<void> getChefProfile({required String token, required int id}) async {
    emit(GetProfileLoadingState());
    var result = await profileRepo.getChefProfile(
      token: token,
      id: id,
    );
    result.fold((failure) {
      emit(GetProfileFailureState(failure.errorMessage));
    }, (profile) {
      emit(GetProfileSuccessState(profile));
    });
  }

}
