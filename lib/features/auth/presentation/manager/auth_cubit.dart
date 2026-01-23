import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/signup_model.dart';
import '../../data/repos/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepo) : super(SignupInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  final AuthRepo authRepo;

  Future<void> SignupUser({
    required String? email,
    required String? password,
    required String? firstName,
    required String? lastName,
    required String? phone,
  }) async {
    emit(SignupLoadingState());
    Either<Failure, SignUpModel> result = await authRepo.SignupUser(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone);
    result.fold((failure) {
      emit(SignupErrorState(failure.errorMessage));
    }, (signupModel) {
      emit(SignupSuccessState(signupModel));
    });
  }
  Future<void> LoginUser({
    required String email,
    required String password
})async{
    emit(LoginLoadingState());
    var result = await authRepo.LoginUser(email: email, password: password);
    result.fold((failure){
      emit(LoginErrorState(failure.errorMessage));
    }, (loginModel){
      emit(LoginSuccessState(loginModel));
    });
  }
}
