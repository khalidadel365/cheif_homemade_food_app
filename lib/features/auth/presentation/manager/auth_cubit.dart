import 'package:cheif_homemade_food/core/models/profile_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utilities/api_constants.dart';
import '../../data/repos/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepo) : super(SignupInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final AuthRepo authRepo;
  String? email, password, firstName, lastName, phone;
  String? bio, address;
  int? yearsOfExperience;

  Future<void> setupProfile({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
    required int yearsOfExp,
    required String bio,
    String? address = '21 Street',
  }) async {
    emit(SignupLoadingState());
    Either<Failure, ProfileModel> result = await authRepo.setupProfile(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      yearsOfExp: yearsOfExp,
      bio: bio,
    );
    result.fold(
      (failure) {
        emit(SignupErrorState(failure.errorMessage));
      },
      (signupModel) {
        emit(SignupSuccessState(signupModel));
      },
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    var result = await authRepo.loginUser(email: email, password: password);
    result.fold(
      (failure) {
        emit(LoginErrorState(failure.errorMessage));
      },
      (loginModel) {
        ApiConstants.token = loginModel.token!;
        ApiConstants.id = loginModel.profileData!.id!;
        print(ApiConstants.id);
        emit(LoginSuccessState(loginModel));
      },
    );
  }

  Future<void> updateProfileImage({
    required String token,
    required XFile imageProfile,
  }) async {
    emit(UpdateProfileImageLoading());
    var result = await authRepo.updateProfileImage(
      token: token,
      imageProfile: imageProfile,
    );
    result.fold(
      (failure) {
        emit(UpdateProfileImageFailure(failure.errorMessage));
      },
      (accountInfo) {
        emit(UpdateProfileImageSuccess(accountInfo));
      },
    );
  }
}
