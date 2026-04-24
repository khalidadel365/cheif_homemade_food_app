import '../../data/models/login_model.dart';
import '../../data/models/signup_model.dart';

abstract class AuthStates {}

class SignupInitialState extends AuthStates {}

class SignupLoadingState extends AuthStates {}

class SignupSuccessState extends AuthStates {
  SignUpModel? authModel;
  SignupSuccessState(this.authModel);
}

class SignupErrorState extends AuthStates {
  final String error;
  SignupErrorState(this.error);
}

class LoginInitialState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState(this.error);
}
